#!/bin/sh

PORT=$(sed -n 's/.*"port": *\([0-9]*\).*/\1/p' /data/options.json)
export PORT="${PORT:-4096}"

exec opencode web --port "$PORT" --hostname 0.0.0.0
