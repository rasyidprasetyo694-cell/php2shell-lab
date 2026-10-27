#!/usr/bin/env bash
set -euo pipefail

halim_action="${1:-start}"
halim_directory="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd -- "$halim_directory"

if ! command -v docker >/dev/null 2>&1; then
    printf '%s\n' 'Docker tidak ditemukan. Gunakan Linux/WSL2 dengan Docker dan Compose v2.' >&2
    exit 1
fi
docker compose version

case "$halim_action" in
    start)
        mkdir -p out/patched out/mitigated
        docker compose -f lab/compose.yaml up -d --wait
        printf '%s\n' 'Lab rentan: http://127.0.0.1:8088/' 'Kontrol patch: http://127.0.0.1:8089/' 'Kontrol mitigasi: http://127.0.0.1:8090/'
        ;;
    stop)
        docker compose -f lab/compose.yaml down
        ;;
    status)
        docker compose -f lab/compose.yaml ps
        ;;
    *)
        printf '%s\n' 'Penggunaan: bash ./lab.sh start|stop|status' >&2
        exit 2
        ;;
esac
