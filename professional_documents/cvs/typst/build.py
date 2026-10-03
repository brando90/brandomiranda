#!/usr/bin/env python3
"""Build the Typst CVs.

Prefers the `typst` CLI; falls back to the `typst` Python wheel
(`pip install typst`) so this works without a system install.

Usage (from professional_documents/cvs/typst/):
    python3 build.py            # build every *.typ that is a document
    python3 build.py cv_short   # build one
"""

import pathlib
import shutil
import subprocess
import sys

HERE = pathlib.Path(__file__).resolve().parent
# cv.typ is a template module, not a standalone document.
TEMPLATES = {"cv.typ"}


def documents(argv):
    if argv:
        return [HERE / (a if a.endswith(".typ") else a + ".typ") for a in argv]
    return sorted(p for p in HERE.glob("*.typ") if p.name not in TEMPLATES)


def build(src: pathlib.Path) -> pathlib.Path:
    out = src.with_suffix(".pdf")
    if shutil.which("typst"):
        subprocess.run(["typst", "compile", str(src), str(out)], check=True)
    else:
        import typst  # type: ignore

        typst.compile(str(src), output=str(out))
    return out


def main() -> int:
    for src in documents(sys.argv[1:]):
        if not src.exists():
            print(f"missing: {src}", file=sys.stderr)
            return 1
        out = build(src)
        print(f"{src.name} -> {out.name} ({out.stat().st_size:,} bytes)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
