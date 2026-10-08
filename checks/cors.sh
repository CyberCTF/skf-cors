#!/bin/sh
# A cross-origin request to /confidential is allowed with credentials.
set -e
H=http://web:5000
J=/tmp/jar$$
curl -fsS -c $J -o /dev/null -d "username=admin&password=admin" "$H/login"
R=$(curl -fsS -b $J -D - -o /dev/null -H "Origin: http://elsewhere.example" "$H/confidential")
echo "$R" | grep -qi "^access-control-allow-credentials: true"
