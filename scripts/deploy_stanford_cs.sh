#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

CSID="${CSID:-brando9}"
CS_HOST="${CS_HOST:-xenon.stanford.edu}"
REMOTE_WWW="${REMOTE_WWW:-~/www/}"
RSYNC_DELETE="${RSYNC_DELETE:-0}"

"$repo_root/scripts/build_stanford_cs.sh"

ssh "${CSID}@${CS_HOST}" 'mkdir -p ~/www'

rsync_args=(-az)
if [[ "$RSYNC_DELETE" == "1" ]]; then
  rsync_args+=(--delete)
fi

rsync "${rsync_args[@]}" _site/ "${CSID}@${CS_HOST}:${REMOTE_WWW}"
ssh "${CSID}@${CS_HOST}" 'fs sa ~ www l && /afs/cs/software/bin/fsr sa ~/www www read'

echo "Deployed to https://cs.stanford.edu/people/${CSID}/"
