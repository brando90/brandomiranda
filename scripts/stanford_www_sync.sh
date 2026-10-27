#!/usr/bin/env bash
# Publish a clean checkout of brando90/brandomiranda main to the Stanford CS page.
# Intended to run on ilc.stanford.edu after scripts/stanford_www_cron.sh has fetched main.
set -euo pipefail

HOME_DIR="${WWW_SYNC_HOME:-/dfs/scratch0/brando9}"
REPO="${WWW_SYNC_REPO:-$HOME_DIR/brandomiranda-www}"
GEM_HOME="${WWW_SYNC_GEM_HOME:-$HOME_DIR/gems/www}"
MARKER="$HOME_DIR/www-published-sha"
KNOWN_HOSTS="$HOME_DIR/.ssh/known_hosts"
PINNED_HOSTS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/xenon_stanford_edu.known_hosts"
PINNED_FINGERPRINT="SHA256:GxFkoKiDNAoOP90/6hc534TthXkj8UwYZZk5O1PbtfQ"
REMOTE="${WWW_SYNC_REMOTE:-brando9@xenon.stanford.edu}"

export HOME="$HOME_DIR"
export GEM_HOME
export PATH="$GEM_HOME/bin:$HOME_DIR/ruby-3.4.11/x64/bin:/usr/bin:/bin"
export GIT_TERMINAL_PROMPT=0
export KRB5CCNAME="${KRB5CCNAME:-$HOME_DIR/krb5/www-sync.cc}"
RUBY_PREFIX="$HOME_DIR/ruby-3.4.11/x64"
export LD_LIBRARY_PATH="$RUBY_PREFIX/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
export RUBYLIB="$RUBY_PREFIX/lib/ruby/3.4.0:$RUBY_PREFIX/lib/ruby/3.4.0/x86_64-linux:$RUBY_PREFIX/lib/ruby/site_ruby/3.4.0:$RUBY_PREFIX/lib/ruby/site_ruby/3.4.0/x86_64-linux${RUBYLIB:+:$RUBYLIB}"

mkdir -p "$HOME_DIR/.ssh" "$(dirname "$KRB5CCNAME")"
kinit -kt "$HOME_DIR/.keytab" brando9@CS.STANFORD.EDU

cd "$REPO"
sha="$(git rev-parse HEAD)"
if [[ -f "$MARKER" && "$(<"$MARKER")" == "$sha" ]]; then
  echo "$(date -u +%Y-%m-%dT%H:%M:%SZ) unchanged $sha"
  exit 0
fi

jekyll="$GEM_HOME/bin/jekyll"
if [[ ! -x "$jekyll" ]]; then
  echo "Jekyll is not installed at $jekyll" >&2
  exit 1
fi

actual_fp="$(ssh-keygen -lf "$PINNED_HOSTS" | awk '{print $2}')"
if [[ "$actual_fp" != "$PINNED_FINGERPRINT" ]]; then
  echo "Pinned xenon host key does not match the expected fingerprint" >&2
  exit 1
fi
install -m 600 "$PINNED_HOSTS" "$KNOWN_HOSTS"

JEKYLL_ENV=production JEKYLL_NO_BUNDLER_REQUIRE=true \
  "$jekyll" build --config _config.yml,_config_stanford_cs.yml
test -s _site/index.html
# Gate: a build with a missing key page or a broken internal link is never copied to the live page.
if command -v python3 >/dev/null; then
  python3 scripts/check_site.py --dir _site
else
  echo "python3 not found: skipping the pre-publish check" >&2
fi

ssh_base=(
  ssh
  -o BatchMode=yes
  -o GSSAPIAuthentication=yes
  -o GSSAPIDelegateCredentials=yes
  -o PreferredAuthentications=gssapi-with-mic
  -o StrictHostKeyChecking=yes
  -o UserKnownHostsFile="$KNOWN_HOSTS"
)
rsync -az --delete -e "${ssh_base[*]}" _site/ "$REMOTE:www/"
"${ssh_base[@]}" "$REMOTE" 'fs sa ~ www l && /afs/cs/software/bin/fsr sa ~/www www read'

# Publishing succeeded: record it first, so a failing live check never makes cron rebuild and re-copy the same commit.
printf '%s\n' "$sha" > "$MARKER"
# Then the live page must answer; a failure here is logged and exits non-zero.
for attempt in 1 2 3 4 5 6; do
  command -v python3 >/dev/null || break
  if python3 scripts/check_site.py --url "https://cs.stanford.edu/people/brando9/"; then break; fi
  [[ "$attempt" == 6 ]] && { echo "Live page failed its check after publishing $sha" >&2; exit 1; }
  sleep 20
done

echo "$(date -u +%Y-%m-%dT%H:%M:%SZ) published $sha"
