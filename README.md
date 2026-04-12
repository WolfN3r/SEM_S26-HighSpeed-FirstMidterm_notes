# HSDSD First Midterm -- Study Notes Generator

Dockerized [Claude Code](https://docs.anthropic.com/en/docs/claude-code) environment that reads HSDSD ( High-Speed PC Board System Design) lecture slides and automatically generates study materials -- knowledge files, concise notes, exam examples, practice questions, and rendered PDFs with LaTeX equations.

Built for the EMC course at **NTUST** (National Taiwan University of Science and Technology).

## How It Works

1. You provide lecture slide PDFs in `WorkingDir/LectureSlides/`
2. Docker container runs Claude Code with `--dangerously-skip-permissions`
3. Claude reads the PDFs, extracts knowledge, verifies equations, and generates study materials
4. Output: markdown files (viewable in Obsidian) + rendered PDFs with LaTeX equations
5. You get a push notification via [ntfy.sh](https://ntfy.sh) when the session ends

## Project Structure

```
.
├── Dockerfile                          # Debian + Node.js + Claude Code + pandoc + LaTeX
├── Makefile                            # Build, run, verify, cleanup commands
├── .env.example                        # Template for API key config
├── .dockerignore
├── README.md
│
└── WorkingDir/                         # Mounted as /workspace inside the container
    ├── CLAUDE.md                       # Task instructions Claude reads on startup
    ├── LectureSlides/                  # Drop your PDFs here (gitignored)
    │   └── .gitkeep
    └── .claude/                        # Claude Code project config
        ├── settings.json               # Statusline + stop hook
        ├── statusline-command.sh       # Context window progress bar
        └── hooks/
            └── stop-notify.sh          # ntfy.sh notification on session end
```

> Only `WorkingDir/` is mounted into the container. Claude cannot see the Dockerfile, Makefile, or `.env`.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (Docker Desktop or Docker Engine in WSL2)
- [Anthropic API key](https://console.anthropic.com)
- (Optional) [ntfy.sh](https://ntfy.sh) app for push notifications

> **WSL2 note:** If running Docker Engine inside WSL2, clone/copy this repo into the WSL native filesystem (e.g. `~/projects/`) -- not `/mnt/c/`. Docker bind mounts from `/mnt/c/` are unreliable.

## Quick Start

```bash
# 1. Clone and configure
git clone https://github.com/WolfN3r/SEM_S26-HighSpeed-FirstMidterm_notes.git
cd SEM_S26-HighSpeed-FirstMidterm_notes
cp .env.example .env
nano .env                       # Add your ANTHROPIC_API_KEY

# 2. Add your lecture PDFs
cp /path/to/your/chap*.pdf WorkingDir/LectureSlides/

# 3. Build and verify
make build                      # ~5-10 min first time (~700MB image)
make verify                     # Check image, .env, files, ntfy

# 4. Launch Claude Code
make claude                     # With confirmation prompt
# or
make cc YES=1                   # Skip confirmation
```

Claude reads `CLAUDE.md` and works through **6 tasks** automatically:

| Task | Output |
|------|--------|
| Knowledge extraction | `knowledge/chap1.md` ... `chap4.md` |
| Equation verification | `knowledge/equation-corrections.md` |
| Study notes | `notes/study-notes.md` |
| Exam examples | `notes/exam-examples.md` |
| Practice questions | `notes/practice-questions.md` |
| PDF export | `pdf/*.pdf` (rendered LaTeX equations) |

Every equation includes a source citation like *(chap2.pdf, p.15)*.

## Commands

| Command | Description |
|---------|-------------|
| `make build` | Build the Docker image |
| `make update-claude` | Rebuild with latest Claude Code (no cache) |
| `make claude` | Launch Claude Code (with confirmation) |
| `make cc` | Smart open: start or attach automatically |
| `make cc YES=1` | Same, skip confirmation |
| `make claude-attach` | Attach second session to running container |
| `make start` | Open a plain bash shell in the container |
| `make verify` | Run all setup checks |
| `make stop` | Stop the running container |
| `make clean` | Remove container and image |

## Notifications

A [stop hook](WorkingDir/.claude/hooks/stop-notify.sh) sends a push notification via [ntfy.sh](https://ntfy.sh) when a Claude session ends, with a short summary of what was accomplished (max 200 chars).

Setup:
1. Install the ntfy app ([Android](https://play.google.com/store/apps/details?id=io.heckel.ntfy) / [iOS](https://apps.apple.com/app/ntfy/id1625396347))
2. Set `NTFY_TOPIC` in `.env` to a unique string
3. Subscribe to that topic in the app
4. `make verify` to test

## Security

- Claude runs as non-root user `claude` (no sudo)
- No Docker socket mounted (no container escape)
- `.env` is gitignored and excluded from Docker build context
- `--dangerously-skip-permissions` grants full shell access **inside the container only**
- Set a [spending limit](https://console.anthropic.com) on your Anthropic account

## Output

After Claude finishes, `WorkingDir/` will contain:

```
WorkingDir/
├── knowledge/                  # Detailed chapter knowledge
│   ├── chap1.md ... chap4.md
│   └── equation-corrections.md
├── notes/
│   ├── study-notes.md          # Concise study notes
│   ├── exam-examples.md        # Likely exam problems
│   └── practice-questions.md   # Practice test with answers
└── pdf/                        # Rendered PDFs with LaTeX
    ├── chap1-knowledge.pdf
    ├── study-notes.pdf
    ├── exam-examples.pdf
    └── practice-questions.pdf
```

The `.md` files render nicely in [Obsidian](https://obsidian.md). The `.pdf` files have fully rendered LaTeX equations.

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `ANTHROPIC_API_KEY not set` | Edit `.env` with your key, or run `make env-setup` |
| Claude can't read PDFs | Ensure PDFs are real files (not iCloud/OneDrive placeholders) |
| ntfy notification not arriving | Run `make verify` to test; check topic matches |
| Image build fails | Run `make update-claude`; check internet connection |
| PDF export LaTeX error | Claude auto-fixes; check `equation-corrections.md` if it persists |
| Empty /workspace in container | Move repo to WSL native filesystem (not `/mnt/c/`) |
