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

exec python3 - "$here" "$port" <<'PY'
import functools
import http.server
import sys

directory, port = sys.argv[1], int(sys.argv[2])


class Handler(http.server.SimpleHTTPRequestHandler):
    """Serve files and forbid caching.

    `python3 -m http.server` sends no cache headers, which leaves the browser
    to guess -- and it guesses that an edited slides.md need not be fetched
    again. Saying so outright means a reload always shows what is on disk.
    """

    def end_headers(self):
        self.send_header("Cache-Control", "no-store, must-revalidate")
        self.send_header("Pragma", "no-cache")
        self.send_header("Expires", "0")
        super().end_headers()


handler = functools.partial(Handler, directory=directory)

try:
    http.server.ThreadingHTTPServer(("", port), handler).serve_forever()
except KeyboardInterrupt:
    pass
PY
