#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

export JEKYLL_ENV="${JEKYLL_ENV:-production}"

# Homebrew-ruby standalone jekyll (gems: jekyll, minima, jekyll-feed).
# JEKYLL_NO_BUNDLER_REQUIRE skips the repo Gemfile — the github-pages bundle is
# not installed locally, and the legacy ~/.gem/ruby/2.6.0 shims are dead (their
# shebang points at Homebrew ruby, which has moved past the gems they were built for).
brew_ruby_gem="${BREW_RUBY_GEM:-/usr/local/opt/ruby/bin/gem}"
brew_ruby_jekyll=""
if [[ -x "$brew_ruby_gem" ]]; then
  brew_ruby_jekyll="$("$brew_ruby_gem" environment gemdir 2>/dev/null)/bin/jekyll"
fi
if [[ -n "$brew_ruby_jekyll" && -x "$brew_ruby_jekyll" ]]; then
  JEKYLL_NO_BUNDLER_REQUIRE=true "$brew_ruby_jekyll" build --config _config.yml,_config_stanford_cs.yml
elif bundle exec jekyll -v >/dev/null 2>&1; then
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
