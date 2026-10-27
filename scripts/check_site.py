#!/usr/bin/env python3
"""Check Brando's personal site: key pages exist and no internal link or asset is broken.

Two modes (standard library only):
  python3 scripts/check_site.py --dir _site                         # built site on disk (CI, before publishing)
  python3 scripts/check_site.py --url https://cs.stanford.edu/people/brando9/   # live site (uptime check)

Exit code 0 when everything passes, 1 when anything fails; every failure is printed.
"""
import argparse
import html.parser
import http.client
import os
import re
import sys
import urllib.error
import urllib.parse
import urllib.request

# Publish gate: the built tree must hold no private-looking file. Only these professional_documents/ folders
# are meant to be public; anything else there (or a private-looking name anywhere) fails the build.
PUBLIC_PROFESSIONAL_DOCUMENTS = ("papers", "posters", "cvs", "awards")
PRIVATE_NAME_WORDS = {"application", "applications", "recommendation", "letter", "transcript", "password", "passwords",
                      "secret", "secrets", "credential", "credentials", "token", "env", "private", "invoice", "passport",
                      "ssn", "salary", "visa"}
ALLOWED_PRIVATE_LOOKING = ()  # list a public file here on purpose, with a reason; empty today


def private_files(root):
    """Return built files that look private: unlisted professional_documents/ content or a private-looking name."""
    found = []
    for dirpath, _, names in os.walk(root):
        for n in names:
            rel = os.path.relpath(os.path.join(dirpath, n), root).replace(os.sep, "/")
            low = rel.lower()
            if any(rel.startswith(a) or "/" + a in rel for a in ALLOWED_PRIVATE_LOOKING):
                continue
            parts = rel.split("/")
            if "professional_documents" in parts:
                after = parts[parts.index("professional_documents") + 1:]
                if len(after) < 2 or after[0] not in PUBLIC_PROFESSIONAL_DOCUMENTS:
                    found.append(rel)
                    continue
            if PRIVATE_NAME_WORDS & set(re.split(r"[^a-z0-9]+", low)):
                found.append(rel)
    return found


KEY_PAGES = ["", "blog.html", "prospective-collaborations.html", "404.html"]
MUST_CONTAIN = {"": ["Brando Miranda", 'href="https://github.com/brando90"']}


class Links(html.parser.HTMLParser):
    def __init__(self):
        super().__init__()
        self.links = []

    def handle_starttag(self, tag, attrs):
        a = dict(attrs)
        for key in ("href", "src"):
            if a.get(key):
                self.links.append(a[key])


def internal(link, page, base):
    """Return the path under base for an internal link found on page, else None."""
    link = link.split("#")[0]
    if not link or link.startswith(("mailto:", "tel:", "javascript:", "data:")):
        return None
    absolute = urllib.parse.urljoin(page, link)
    if not absolute.startswith(base):
        return None
    return absolute[len(base):].split("?")[0]


def read_dir(root, path):
    full = os.path.join(root, urllib.parse.unquote(path))
    if os.path.isdir(full):
        full = os.path.join(full, "index.html")
    if os.path.exists(full):
        return open(full, encoding="utf-8", errors="replace").read()
    return None


def read_url(base, path):
    try:
        with urllib.request.urlopen(urllib.request.Request(base + urllib.parse.quote(path, safe="/%"), headers={"User-Agent": "site-check"}), timeout=30) as r:
            return r.read().decode("utf-8", "replace") if r.status == 200 else None
    except (urllib.error.URLError, OSError, http.client.HTTPException, ValueError):
        return None


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--dir")
    ap.add_argument("--url")
    ap.add_argument("--base", default="/people/brando9/", help="site path prefix inside the built pages")
    args = ap.parse_args()
    if bool(args.dir) == bool(args.url):
        sys.exit("give exactly one of --dir or --url")
    base = "https://cs.stanford.edu" + args.base
    fetch = (lambda p: read_dir(args.dir, p)) if args.dir else (lambda p: read_url(args.url.rstrip("/") + "/", p))
    failures, seen, queue = [], set(), list(KEY_PAGES)
    while queue:
        path = queue.pop()
        if path in seen:
            continue
        seen.add(path)
        body = fetch(path)
        if body is None:
            failures.append(f"missing or not 200: /{path}")
            continue
        for needle in MUST_CONTAIN.get(path, []):
            if needle not in body:
                failures.append(f"/{path} lacks '{needle}'")
        if path == "" or path.endswith((".html", "/")):
            parser = Links()
            parser.feed(body)
            for link in parser.links:
                target = internal(link, urllib.parse.urljoin(base, path), base)
                if target is not None and target not in seen:
                    if args.url and target and not target.endswith((".html", "/")):
                        seen.add(target)  # live mode: only crawl pages, assets are checked below
                        if fetch_head(args.url.rstrip("/") + "/" + target) is False:
                            failures.append(f"broken asset /{target} (linked from /{path})")
                    else:
                        queue.append(target)
    if args.dir:
        failures += [f"private-looking file in the built site: {p}" for p in private_files(args.dir)]
    for f in failures:
        print("FAIL", f)
    print(f"checked {len(seen)} paths, {len(failures)} failures")
    return 1 if failures else 0


def fetch_head(url):
    try:
        url = urllib.parse.quote(url, safe=":/%")
        req = urllib.request.Request(url, method="HEAD", headers={"User-Agent": "site-check"})
        with urllib.request.urlopen(req, timeout=30) as r:
            return r.status == 200
    except (urllib.error.URLError, OSError, http.client.HTTPException, ValueError):
        return False


if __name__ == "__main__":
    sys.exit(main())
