#!/bin/sh

PASSWORD=$(sed -n 's/.*"password": *"\([^"]*\)".*/\1/p' /data/options.json)
PORT=$(sed -n 's/.*"port": *\([0-9]*\).*/\1/p' /data/options.json)

export OPENCODE_SERVER_PASSWORD="${PASSWORD:-change_me_immediately}"
export PORT="${PORT:-4096}"

mkdir -p /data/config
cat > /data/config/opencode.json << EOF
{
  "server": {
    "hostname": "127.0.0.1",
    "port": $PORT
  }
}
EOF

export OPENCODE_CONFIG="/data/config/opencode.json"

nginx -c /etc/nginx/nginx.conf &

exec opencode web --port "$PORT" --hostname 127.0.0.1 --cors "*"
