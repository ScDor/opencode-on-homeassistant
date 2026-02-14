#!/bin/sh

echo "Starting OpenCode..."

PASSWORD=$(sed -n 's/.*"password": *"\([^"]*\)".*/\1/p' /data/options.json)
PORT=$(sed -n 's/.*"port": *\([0-9]*\).*/\1/p' /data/options.json)

echo "Read password: '$PASSWORD'"
echo "Read port: '$PORT'"

export OPENCODE_SERVER_PASSWORD="${PASSWORD:-change_me_immediately}"
export PORT="${PORT:-4096}"

echo "Using password: '$OPENCODE_SERVER_PASSWORD'"
echo "Using port: $PORT"

nginx -c /etc/nginx/nginx.conf &

exec opencode web --port "$PORT" --hostname 0.0.0.0 --cors "*"
