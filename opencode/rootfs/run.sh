#!/bin/sh

PORT=$(sed -n 's/.*"port": *\([0-9]*\).*/\1/p' /data/options.json)
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
