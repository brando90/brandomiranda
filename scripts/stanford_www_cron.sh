#!/usr/bin/env bash
# Cron entrypoint on ilc.stanford.edu. Pulls origin/main, then runs the publisher.
# The Kerberos keytab path is an existing file on SNAP disk; this script never prints it.
set -euo pipefail

HOME_DIR="${WWW_SYNC_HOME:-/dfs/scratch0/brando9}"
export HOME="$HOME_DIR"
export GIT_TERMINAL_PROMPT=0
export KRB5CCNAME="$HOME_DIR/krb5/www-sync.cc"
export LD_LIBRARY_PATH="$HOME_DIR/ruby-3.4.11/x64/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

mkdir -p "$HOME_DIR/krb5" "$HOME_DIR/bin" "$HOME_DIR/log" "$HOME_DIR/locks" "$HOME_DIR/.ssh"
exec 9>"$HOME_DIR/locks/www-sync.lock"
if ! flock -n 9; then
  exit 0
fi
kinit -kt "$HOME_DIR/.keytab" brando9@CS.STANFORD.EDU

REPO="$HOME_DIR/brandomiranda-www"
if [[ ! -d "$REPO/.git" ]]; then
  git clone --depth 1 --branch main https://github.com/brando90/brandomiranda.git "$REPO"
fi
git -C "$REPO" fetch --depth 1 origin main
git -C "$REPO" reset --hard origin/main

install -m 700 "$REPO/scripts/stanford_www_cron.sh" "$HOME_DIR/bin/stanford-www-sync"
exec bash "$REPO/scripts/stanford_www_sync.sh"
