#!/usr/bin/env bash
# Claude Code Stop hook - sends ntfy.sh notification when a session ends.
# NTFY_TOPIC is passed as an environment variable via docker run --env NTFY_TOPIC.

DIR="${CLAUDE_PROJECT_DIR:-.}"

# Read hook input from stdin
INPUT=$(cat)

# Prevent infinite loop: if hook already fired once, just exit
IS_ACTIVE=$(echo "$INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('stop_hook_active',False))" 2>/dev/null || echo "False")
[ "$IS_ACTIVE" = "True" ] && exit 0

# Read topic from environment
TOPIC="${NTFY_TOPIC}"
[ -z "$TOPIC" ] && exit 0

# Build a descriptive summary (<=200 chars) from the session transcript
MSG=$(echo "$INPUT" | python3 -c "
import sys, json

MAX = 200
inp = json.load(sys.stdin)
last = inp.get('last_assistant_message', '') or ''
tp   = inp.get('transcript_path', '')

# Try to get the first user message (the task) from the transcript
task = ''
if tp:
    try:
        with open(tp, 'r', encoding='utf-8') as f:
            for line in f:
                entry = json.loads(line)
                role = entry.get('role', '')
                if role == 'user':
                    # content can be string or list of content blocks
                    c = entry.get('content', '')
                    if isinstance(c, list):
                        c = ' '.join(
                            b.get('text', '') for b in c
                            if isinstance(b, dict) and b.get('type') == 'text'
                        )
                    task = c.strip().replace('\n', ' ')
                    break
    except Exception:
        pass

# Build the message
parts = []
if task:
    parts.append('Task: ' + task)
if last:
    # Take last meaningful line from assistant response
    snippet = ' '.join(last.strip().split())
    parts.append('Done: ' + snippet)

if parts:
    msg = ' | '.join(parts)
else:
    msg = 'Session completed.'

# Truncate to MAX chars
if len(msg) > MAX:
    msg = msg[:MAX - 3] + '...'

print(msg)
" 2>/dev/null || echo "Claude Code: Session completed.")

curl -s -d "$MSG" "https://ntfy.sh/$TOPIC" >/dev/null 2>&1

exit 0
