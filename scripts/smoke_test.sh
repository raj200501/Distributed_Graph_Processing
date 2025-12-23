#!/usr/bin/env bash
set -euo pipefail

if ! command -v julia >/dev/null 2>&1; then
  echo "Julia is required but not found on PATH. Install Julia >= 1.9 and retry." >&2
  exit 1
fi

julia --project=. -e 'using Pkg; Pkg.instantiate()'

julia --project=. scripts/smoke_test.jl
