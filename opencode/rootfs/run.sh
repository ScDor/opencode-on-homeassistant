#!/bin/sh

PASSWORD=$(sed -n 's/.*"password": *"\([^"]*\)".*/\1/p' /data/options.json)
PORT=$(sed -n 's/.*"port": *\([0-9]*\).*/\1/p' /data/options.json)
export OPENCODE_SERVER_PASSWORD="${PASSWORD:-change_me_immediately}"
export PORT="${PORT:-4096}"

nginx -c /etc/nginx/nginx.conf &

exec opencode web --port "$PORT" --hostname 0.0.0.0 --cors "*"
