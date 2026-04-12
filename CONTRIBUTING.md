# Contributing to nimmit-brain

**nimmit-brain** is the AI brain template by KOOMPI. Fork it, customize it, run your own AI team — or contribute improvements back for everyone.

## 🔒 Your Privacy, Our Promise

**Your conversations stay private. Always.**

Here's how it works:

- You chat with Nimmit in your private DM or workspace — **nobody else sees this**
- When Nimmit learns something useful (a better way to do things, a new pattern, a domain insight), **only the lesson gets extracted** — not your data, not your messages, not your name
- That lesson is pushed to the shared `nimmit-brain` repo so **everyone benefits**
- When someone else's Nimmit learns something, **you get that upgrade too**

Think of it like open source code — contributors share improvements, not personal data.

**What gets shared:** lessons, patterns, knowledge (generic)
**What stays private:** your chats, your files, your business data, your identity

## How It Works (Simple Version)

1. **You use Nimmit** — chat normally, work on your stuff
2. **Nimmit learns** — picks up better ways to do things from interacting with you
3. **Lessons auto-sync** — useful improvements flow back to the shared brain
4. **Everyone upgrades** — next week, you and all Nimmit users get smarter

You don't need to know git or open pull requests. Just use Nimmit. If you want to contribute more directly, see the technical guide below.

---

## Technical Guide (for developers)

1. Fork `koompi/nimmit-brain`
2. Create a feature branch: `git checkout -b my-improvement`
3. Make your changes
4. Open a PR with the required template filled out
5. Nimmit reviews weekly. Merged or feedback given.

## What's Welcome

| Category | Path | Examples |
|----------|------|----------|
| Procedural patterns | `brain/memory/procedural/` | Debugging flows, deployment checklists |
| Domain knowledge | `brain/memory/semantic/` | Industry docs, technical references |
| Workflow improvements | `brain/WORKFLOW.md`, `scripts/` | Automation, process refinements |
| Bug fixes | Any brain file | Typos, broken references, logic errors |
| New memory archetypes | `brain/memory/` | New file types, novel structures |

## What's NOT Accepted

- **SOUL.md / IDENTITY.md changes** — core personality is non-negotiable
- **Approval gate changes** — security boundary, only KOOMPI internal
- **Credentials, tokens, IPs, secrets** — never
- **Vendor lock-in** — patterns must work across providers
- **Unexplained changes** — every PR must include the lesson learned

## PR Format

- **One change per PR.** Keeps reviews focused.
- Explain the lesson: what scenario taught you this?
- Reference the real-world context.
- Use the PR template (auto-loaded when you open a PR).

## Review Process

1. Automated checks: restricted file detection, formatting
2. Nimmit reviews weekly batch
3. Merge, request changes, or close with explanation
4. Major changes may land in a minor version bump

## Style

- KOOMPI: 2 O's, 2 P's. Nimmit: 2 M's, 2 T's.
- Markdown, 80-char lines where practical
- Concise > verbose

## Questions?

Open an issue with the `question` label.
