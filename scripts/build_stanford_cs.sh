#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

export JEKYLL_ENV="${JEKYLL_ENV:-production}"

if bundle exec jekyll -v >/dev/null 2>&1; then
  bundle exec jekyll build --config _config.yml,_config_stanford_cs.yml
elif command -v jekyll >/dev/null 2>&1; then
  jekyll build --config _config.yml,_config_stanford_cs.yml
elif [[ -x "$HOME/.gem/ruby/2.6.0/bin/jekyll" ]]; then
  tmp_gemfile="$(mktemp "${TMPDIR:-/tmp}/brandomiranda-jekyll-gemfile.XXXXXX")"
  trap 'rm -f "$tmp_gemfile"' EXIT
  cat > "$tmp_gemfile" <<'GEMFILE'
source "https://rubygems.org"
gem "jekyll", "3.8.5"
gem "minima", "2.5.0"
gem "jekyll-feed", "0.11.0"
gem "jekyll-compose", "0.11.0"
GEMFILE
  BUNDLE_GEMFILE="$tmp_gemfile" "$HOME/.gem/ruby/2.6.0/bin/jekyll" build --config _config.yml,_config_stanford_cs.yml
else
  echo "Could not find Jekyll. Try: bundle install" >&2
  exit 1
fi
