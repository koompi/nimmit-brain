const GITHUB_RAW = "https://raw.githubusercontent.com/koompi/koompi-nimmit/main";

export default {
  async fetch(request: Request): Promise<Response> {
    const url = new URL(request.url);
    const path = url.pathname;

    // GET /install → serve install.sh
    if (path === "/install" || path === "/install.sh") {
      const res = await fetch(`${GITHUB_RAW}/install.sh`);
      if (!res.ok) {
        return new Response("Failed to fetch install script", { status: 502 });
      }
      const body = await res.text();
      return new Response(body, {
        headers: {
          "Content-Type": "text/plain; charset=utf-8",
          "Cache-Control": "public, max-age=300",
        },
      });
    }

    // GET /skill-packs/<industry>/SKILL.md
    const skillMatch = path.match(/^\/skill-packs\/([a-z-]+)\/SKILL\.md$/);
    if (skillMatch) {
      const industry = skillMatch[1];
      const res = await fetch(`${GITHUB_RAW}/skill-packs/${industry}/SKILL.md`);
      if (!res.ok) {
        return new Response(`Skill pack '${industry}' not found`, { status: 404 });
      }
      const body = await res.text();
      return new Response(body, {
        headers: {
          "Content-Type": "text/markdown; charset=utf-8",
          "Cache-Control": "public, max-age=300",
        },
      });
    }

    // GET / → landing
    if (path === "/" || path === "") {
      return new Response(
        [
          "# Nimmit",
          "",
          "AI-powered business assistant by KOOMPI.",
          "",
          "## Install",
          "",
          "```bash",
          "curl -fsSL https://nimmit.koompi.ai/install | bash",
          "```",
          "",
          "## Skill Packs",
          "",
          "### Core",
          "- [Memory](/skill-packs/memory/SKILL.md) — memory architecture (recommended)",
          "",
          "### Business & Operations",
          "- [Executive](/skill-packs/executive/SKILL.md)",
          "- [SME](/skill-packs/sme/SKILL.md)",
          "- [Finance](/skill-packs/finance/SKILL.md)",
          "- [Creative](/skill-packs/creative/SKILL.md)",
          "- [Logistics](/skill-packs/logistics/SKILL.md)",
          "- [Construction](/skill-packs/construction/SKILL.md)",
          "",
          "### Public Sector & Education",
          "- [Government](/skill-packs/government/SKILL.md)",
          "- [Education](/skill-packs/education/SKILL.md)",
          "- [Nonprofit](/skill-packs/nonprofit/SKILL.md)",
          "",
          "### Professional Services",
          "- [Healthcare](/skill-packs/healthcare/SKILL.md)",
          "- [Legal](/skill-packs/legal/SKILL.md)",
          "- [Real Estate](/skill-packs/real-estate/SKILL.md)",
          "- [Agriculture](/skill-packs/agriculture/SKILL.md)",
          "- [Hospitality](/skill-packs/hospitality/SKILL.md)",
          "",
          "### Intelligence & Research",
          "- [Geopolitical](/skill-packs/geopolitical/SKILL.md)",
          "- [Economist](/skill-packs/economist/SKILL.md)",
          "- [Web Crawler](/skill-packs/web-crawler/SKILL.md)",
        ].join("\n"),
        {
          headers: {
            "Content-Type": "text/markdown; charset=utf-8",
          },
        }
      );
    }

    return new Response("Not found", { status: 404 });
  },
} satisfies ExportedHandler;
