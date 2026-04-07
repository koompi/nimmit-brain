#!/usr/bin/env bash
set -euo pipefail

# Nimmit Installer
# Usage: curl -fsSL https://nimmit.koompi.ai/install | bash

info()  { echo -e "\033[0;36m🦅\033[0m $1"; }
ok()    { echo -e "\033[0;32m✅\033[0m $1"; }
warn()  { echo -e "\033[1;33m⚠️\033[0m $1"; }
fail()  { echo -e "\033[0;31m❌\033[0m $1"; exit 1; }

[[ $EUID -eq 0 ]] && fail "Don't run as root."

AGENT="nimmit"
SKILL_BASE="https://nimmit.koompi.ai/skill-packs"

# ─── 1. Bun ───
info "Installing Bun..."
if command -v bun &>/dev/null; then
  ok "Bun $(bun --version)"
else
  curl -fsSL https://bun.sh/install | bash
  export BUN_INSTALL="$HOME/.bun" PATH="$HOME/.bun/bin:$PATH"
  ok "Bun installed"
fi

# ─── 2. OpenClaw ───
info "Installing OpenClaw..."
if command -v openclaw &>/dev/null; then
  ok "OpenClaw $(openclaw --version 2>/dev/null | head -1)"
else
  bun install -g openclaw 2>&1 | tail -1
  ok "OpenClaw installed"
fi

# ─── 3. Register agent (OpenClaw seeds its own brain templates) ───
info "Registering $AGENT agent..."
if openclaw agents list --json 2>/dev/null | grep -q "\"$AGENT\""; then
  ok "Agent '$AGENT' already registered"
else
  openclaw agents add --name "$AGENT" --non-interactive 2>/dev/null \
    && ok "Agent '$AGENT' registered" \
    || warn "Run manually: openclaw agents add --name $AGENT"
fi

WORKSPACE=$(openclaw agents show "$AGENT" --json 2>/dev/null | grep -oP '"workspace"\s*:\s*"\K[^"]+' || echo "$HOME/.openclaw/agents/$AGENT/workspace")

# ─── 4. Skill packs (multi-select) ───
echo ""
info "Select skill packs (space-separated, e.g. '1 3 7'):"
echo ""
echo "  Business & Operations"
echo "    1) 👔 Executive        2) 🏪 SME"
echo "    3) 💰 Finance          4) 🎨 Creative"
echo "    5) 🚚 Logistics        6) 🏗️ Construction"
echo ""
echo "  Public Sector & Education"
echo "    7) 🏛️ Government       8) 🏫 Education"
echo "    9) 🤝 Nonprofit"
echo ""
echo "  Professional Services"
echo "   10) ⚕️ Healthcare      11) ⚖️ Legal"
echo "   12) 🏠 Real Estate     13) 🌾 Agriculture"
echo "   14) 🏨 Hospitality"
echo ""
echo "  Intelligence & Research"
echo "   15) 🌍 Geopolitical    16) 📊 Economist"
echo "   17) 🕷️ Web Crawler"
echo ""
echo "   all) Install everything    skip) None"
echo ""
read -rp "Choose: " PICKS

resolve_skill() {
  case $1 in
    1) echo "executive" ;; 2) echo "sme" ;; 3) echo "finance" ;; 4) echo "creative" ;;
    5) echo "logistics" ;; 6) echo "construction" ;; 7) echo "government" ;; 8) echo "education" ;;
    9) echo "nonprofit" ;; 10) echo "healthcare" ;; 11) echo "legal" ;; 12) echo "real-estate" ;;
    13) echo "agriculture" ;; 14) echo "hospitality" ;; 15) echo "geopolitical" ;; 16) echo "economist" ;;
    17) echo "web-crawler" ;; *) echo "" ;;
  esac
}

SKILLS=()
if [[ "$PICKS" == "all" ]]; then
  for i in $(seq 1 17); do SKILLS+=("$(resolve_skill $i)"); done
elif [[ "$PICKS" != "skip" && -n "$PICKS" ]]; then
  for p in $PICKS; do
    s=$(resolve_skill "$p")
    [[ -n "$s" ]] && SKILLS+=("$s")
  done
fi

if (( ${#SKILLS[@]} > 5 )); then
  warn "Installing ${#SKILLS[@]} packs — this increases token costs per API call."
fi

INSTALLED=0
for SKILL in "${SKILLS[@]}"; do
  DEST="$WORKSPACE/skills/nimmit-${SKILL}"
  mkdir -p "$DEST"
  if curl -fsSL "$SKILL_BASE/$SKILL/SKILL.md" -o "$DEST/SKILL.md" 2>/dev/null; then
    ok "$SKILL"
    ((INSTALLED++))
  else
    warn "Could not download $SKILL"
  fi
done
(( INSTALLED > 0 )) && ok "$INSTALLED skill pack(s) installed"

# ─── 5. Memory architecture (recommended) ───
echo ""
read -rp "Install memory architecture skill? (recommended) [Y/n]: " MEM_PICK
MEM_PICK="${MEM_PICK:-Y}"
if [[ "$MEM_PICK" =~ ^[Yy] ]]; then
  DEST="$WORKSPACE/skills/nimmit-memory"
  mkdir -p "$DEST"
  curl -fsSL "$SKILL_BASE/memory/SKILL.md" -o "$DEST/SKILL.md" 2>/dev/null \
    && ok "Memory architecture installed" \
    || warn "Could not download memory skill"
fi

# ─── 6. Telegram ───
echo ""
read -rp "Telegram bot token (blank to skip): " TG_TOKEN
if [[ -n "$TG_TOKEN" ]]; then
  ENV_FILE="$HOME/.openclaw/.env"
  mkdir -p "$(dirname "$ENV_FILE")"
  if [[ -f "$ENV_FILE" ]] && grep -q "TELEGRAM_BOT_TOKEN" "$ENV_FILE"; then
    sed -i "s/TELEGRAM_BOT_TOKEN=.*/TELEGRAM_BOT_TOKEN=\"$TG_TOKEN\"/" "$ENV_FILE"
  else
    echo "TELEGRAM_BOT_TOKEN=\"$TG_TOKEN\"" >> "$ENV_FILE"
  fi
  chmod 600 "$ENV_FILE"
  openclaw config set channels.telegram.enabled true 2>/dev/null || true
  ok "Telegram configured"
fi

# ─── 7. systemd service ───
info "Setting up service..."
SERVICE="$HOME/.config/systemd/user/openclaw-gateway.service"
mkdir -p "$(dirname "$SERVICE")"
cat > "$SERVICE" << EOF
[Unit]
Description=OpenClaw Gateway ($AGENT)
After=network-online.target

[Service]
Type=simple
EnvironmentFile=-$HOME/.openclaw/.env
ExecStart=$(which bun) run $(which openclaw) gateway
Restart=on-failure
RestartSec=10

[Install]
WantedBy=default.target
EOF
systemctl --user daemon-reload 2>/dev/null || true
systemctl --user enable openclaw-gateway 2>/dev/null || true
ok "Service configured"

# ─── Done ───
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "  \033[0;32m🦅 Nimmit is ready.\033[0m"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  Start: openclaw gateway --force"
echo "  Or:    systemctl --user start openclaw-gateway"
echo ""
