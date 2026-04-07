# Nimmit

> Install an AI worker. Teach it your job. Let it work.

Built on [OpenClaw](https://github.com/openclaw/openclaw). Shipped by KOOMPI.

## What Nimmit Does

Nimmit is an **AI worker that runs 24/7** on your machine. It doesn't wait to be asked. It wakes up, checks what needs doing, and does it.

- **Remembers everything** — your org, your preferences, your history. Gets sharper over time.
- **Works on its own** — proactive heartbeat checks tasks, deadlines, and inboxes without being prompted.
- **Executes, not just advises** — drafts the document, replies to the customer, prepares the report, updates the spreadsheet.
- **Talks to you where you are** — Telegram, terminal, or any channel OpenClaw supports.
- **Learns any domain** — install a skill pack or teach it yourself. School, factory, law firm, farm, clinic — the domain doesn't matter.

This isn't a chatbot. It's a team member that never sleeps.

## Install

```bash
curl -fsSL https://nimmit.koompi.ai/install | bash
```

One command. Five minutes. Running as a service.

## Skill Packs

Skill packs give Nimmit domain knowledge on day one. They're **starter kits, not limits** — Nimmit can learn any domain you teach it.

### Core

| Pack | Purpose | What It Does |
|------|---------|--------------|
| 🧠 **Memory** | Memory architecture | Hierarchical storage, daily logging, weekly compaction, proactive memory hygiene |

Installed by default. Teaches Nimmit to write everything down, index (not dump), and prune aggressively.

### Business & Operations

| Pack | Domain | What Nimmit Can Do |
|------|--------|-------------------|
| 👔 **Executive** | Leadership, C-suite | Morning briefings, decision support, report drafting, overnight intelligence, weekly reviews |
| 🏪 **SME** | Any business | Social media, customer service, inventory alerts, marketing campaigns, financial reports |
| 💰 **Finance** | Accounting, CFO | AP/AR, reconciliation, budgets, P&L, cash flow forecasting, month-end close |
| 🎨 **Creative** | Agencies, studios | Project management, client briefs, content calendars, review/approval workflows, asset management |
| 🚚 **Logistics** | Supply chain | Shipment tracking, warehouse management, route planning, customs docs, fleet coordination |
| 🏗️ **Construction** | Project management | Scheduling, daily site reports, subcontractor coordination, procurement, safety compliance |

### Public Sector & Education

| Pack | Domain | What Nimmit Can Do |
|------|--------|-------------------|
| 🏛️ **Government** | Ministries, departments | Formal documents, meeting prep, procurement tracking, compliance, inter-department communication |
| 🏫 **Education** | Schools, universities | Scheduling, curriculum planning, attendance tracking, parent communication, content generation |
| 🤝 **Nonprofit** | NGOs, foundations | Donor management, grant tracking, fundraising, volunteer coordination, impact reporting |

### Professional Services

| Pack | Domain | What Nimmit Can Do |
|------|--------|-------------------|
| ⚕️ **Healthcare** | Clinics, practices | Patient scheduling, records management, prescriptions, follow-ups, lab tracking, compliance |
| ⚖️ **Legal** | Law firms | Case management, document drafting, deadline tracking, billing, discovery, court calendar |
| 🏠 **Real Estate** | Brokerages, agents | Listings, client pipeline, showings, contracts, market analysis, transaction lifecycle |
| 🌾 **Agriculture** | Farms, cooperatives | Crop planning, weather alerts, inventory, market prices, harvest tracking, equipment maintenance |
| 🏨 **Hospitality** | Hotels, resorts | Reservations, guest communication, housekeeping, revenue management, reviews, events |

### Intelligence & Research

| Pack | Domain | What Nimmit Can Do |
|------|--------|-------------------|
| 🌍 **Geopolitical** | Risk analysis, OSINT | Conflict monitoring, sanctions tracking, scenario analysis, stakeholder mapping, intelligence briefs |
| 📊 **Economist** | Economic analysis | Macro indicators, central bank monitoring, forecasting, inflation analysis, research notes |
| 🕷️ **Web Crawler** | Research, monitoring | Social media monitoring, brand tracking, competitor intelligence, trend detection, news aggregation |

Don't see your domain? Nimmit works without a skill pack. Or write your own — it's a single markdown file.

## How It Works

```
You install Nimmit
    → OpenClaw seeds the brain (SOUL.md, IDENTITY.md, HEARTBEAT.md, AGENTS.md)
    → You pick a skill pack (domain knowledge + proactive behavior)
    → Nimmit gets a heartbeat (wakes up, checks what needs doing, does it)
    → It works — every day, on its own
```

**The morning briefing** is just the standup. Nimmit's real work happens all day:

- Picks up tasks and completes them
- Responds to messages on your behalf
- Drafts documents in the right tone and language
- Flags what needs your attention — ignores what doesn't
- Remembers decisions and builds institutional memory

## Tech Stack

- **Runtime:** [OpenClaw](https://github.com/openclaw/openclaw) — open-source AI gateway
- **Brain:** Markdown workspace — seeded by OpenClaw's built-in templates
- **Skills:** Modular domain packs with Heartbeat behavior — or bring your own
- **Channels:** Telegram, terminal, extensible
- **Service:** systemd (auto-start, auto-restart)
- **Hardware:** Any Linux machine, including KOOMPI Mini

## Structure

```
koompi-nimmit/
├── install.sh              # One-command installer
├── skill-packs/
│   ├── agriculture/        # Farms + cooperatives
│   ├── construction/       # Project management
│   ├── creative/           # Agencies + studios
│   ├── economist/          # Economic analysis
│   ├── education/          # Schools + universities
│   ├── executive/          # Leadership + C-suite
│   ├── finance/            # Accounting + CFO
│   ├── geopolitical/       # Risk analysis + OSINT
│   ├── government/         # Ministries + departments
│   ├── healthcare/         # Clinics + practices
│   ├── hospitality/        # Hotels + resorts
│   ├── legal/              # Law firms
│   ├── logistics/          # Supply chain
│   ├── memory/             # Memory architecture (core)
│   ├── nonprofit/          # NGOs + foundations
│   ├── real-estate/        # Brokerages + agents
│   ├── sme/                # Small & medium businesses
│   └── web-crawler/        # Research + monitoring
├── worker/                 # Cloudflare Worker (nimmit.koompi.ai)
│   ├── src/index.ts
│   └── wrangler.toml
└── README.md
```

## License

Apache 2.0 — same as OpenClaw.
