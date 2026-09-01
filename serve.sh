#!/usr/bin/env bash
#
# Serve these slides over HTTP.
#
#     ./serve.sh [port]
#
# The slides fetch course.json and each slides.md at run time, which a browser
# refuses to do over file://, so they need a server rather than a double click.
#
# Serves the directory this script is in, wherever that is, so the script can
# be copied into any course without editing.

set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
port="${1:-8000}"

echo "Serving $here at http://localhost:$port"
echo "Press Ctrl-C to stop."

exec python3 -m http.server "$port" --directory "$here"
