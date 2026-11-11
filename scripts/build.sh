#!/usr/bin/env bash
# Builds the game against an AYLO Engine release: downloads the engine zip of this platform, checks the game with its
# runtime, exports it with aylo-export and zips the export.
#
#   scripts/build.sh <platform>          platform: linux-x86_64, macos-arm64 or windows-x86_64
#
# The engine release is the tag in engine-version.txt ("nightly", or "v0.1.0"). Needs gh (logged in or GH_TOKEN), cmake
# and bash. The zip is written to dist/.
set -euo pipefail

platform="${1:?usage: $0 <linux-x86_64|macos-arm64|windows-x86_64>}"
root="$(cd "$(dirname "$0")/.." && pwd)"
tag="$(tr -d '[:space:]' < "$root/engine-version.txt")"
name="aylo-example-circle"
exe=""
[[ "$platform" == windows-* ]] && exe=".exe"

rm -rf "$root/engine" "$root/exports"
mkdir -p "$root/engine" "$root/dist"

echo "== Engine release: $tag ($platform)"
gh release download "$tag" --repo EthanCharpentier667/Aylo-Engine --pattern "aylo-engine-*-${platform}.zip" --dir "$root/engine"
zip_file="$(ls "$root"/engine/aylo-engine-*-"${platform}".zip)"
(cd "$root/engine" && cmake -E tar xf "$zip_file")
engine="$(find "$root/engine" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
version="$(cat "$engine/VERSION")"
echo "== Engine version: $version"

# Unzipped by cmake: make sure the programs can run (a zip made on Windows keeps no mode).
chmod +x "$engine/runtime/aylo-runtime$exe" "$engine/tools/aylo-export$exe" 2>/dev/null || true

echo "== Check the game: the server side runs its scripts"
"$engine/runtime/aylo-runtime$exe" --server --ticks 60 "$root/game"

echo "== Export"
"$engine/tools/aylo-export$exe" "$root/game" "$root/exports" --name "$name"

# The version of the engine is in the name: a zip says what it was built with.
out="$name-engine-${version}-${platform}.zip"
(cd "$root/exports" && cmake -E tar cf "$root/dist/$out" --format=zip "$name")
echo "== Wrote dist/$out"
