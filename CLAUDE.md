# Stormbound: instructions for AI agents

Shaman addon of the Bound family for WoW: Forever, built on LibBound-1.0 (`../LibBound`). Design:
the Obsidian vault, `Private/projects/Bound Addons/Stormbound Design.md`.

## Build & test

No build step: WoW loads the .lua files directly. Before committing, from this folder:

```bash
tools/sync-libbound.sh                                                # LibBound into Libs/ (not tracked)
for f in *.lua; do luac5.1 -p "$f" || echo "syntax error: $f"; done
~/.luarocks/bin/luacheck .
wowbench check . && wowbench test .                                   # 0 errors, every scenario ok
```

Scenarios live in `tests/*.scenario.lua` (`tests/_shaman.lua` is shared setup). Anything shared by
every Bound addon belongs in LibBound, not here. Run `/codex:review` before every commit.

## Git flow: main is protected

Changes go through pull requests that Claude opens and merges itself:
`git switch -c <topic>`, commit (with `.beads/issues.jsonl`), `git push -u origin <topic>`,
`gh pr create --fill` (body ends with the Claude Code attribution line),
`gh pr merge --squash --delete-branch`. Releases: tag on main, `wowbench pack . --set-version X`,
`gh release create vX dist/Stormbound-X.zip`.

CurseForge: `CURSEFORGE.md` is the project page (pasted by hand) and `Stormbound.png` its picture (made by `tools/make_media.py`). Before a release: write the version in `CHANGELOG.md`, run `python3 tools/sync_curseforge.py` (it copies the changelog to the bottom of the page). The comment at the top of `CURSEFORGE.md` is the text for CurseForge's "Summary" field (at most 256 characters; the tool checks it, `--summary` prints it).

## Issues

Beads (`bd`). There is no Dolt remote: skip `bd dolt push`.


<!-- BEGIN BEADS INTEGRATION v:1 profile:minimal hash:ca08a54f -->
## Beads Issue Tracker

This project uses **bd (beads)** for issue tracking. Run `bd prime` to see full workflow context and commands.

### Quick Reference

```bash
bd ready              # Find available work
bd show <id>          # View issue details
bd update <id> --claim  # Claim work
bd close <id>         # Complete work
```

### Rules

- Use `bd` for ALL task tracking — do NOT use TodoWrite, TaskCreate, or markdown TODO lists
- Run `bd prime` for detailed command reference and session close protocol
- Use `bd remember` for persistent knowledge — do NOT use MEMORY.md files

## Session Completion

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `git push` succeeds.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   git pull --rebase
   bd dolt push
   git push
   git status  # MUST show "up to date with origin"
   ```
5. **Clean up** - Clear stashes, prune remote branches
6. **Verify** - All changes committed AND pushed
7. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds
<!-- END BEADS INTEGRATION -->
