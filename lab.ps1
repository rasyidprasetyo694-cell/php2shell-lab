param(
    [ValidateSet('start', 'stop', 'status')]
    [string]$Action = 'start'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    throw 'Docker tidak ditemukan. Gunakan Docker Desktop dengan Linux containers atau jalankan paket dari Linux/WSL2 yang memiliki Docker.'
}

Push-Location -LiteralPath $PSScriptRoot
try {
    & docker compose version
    if ($LASTEXITCODE -ne 0) { throw 'Docker Compose v2 tidak tersedia.' }

    if ($Action -eq 'start') {
        foreach ($halimDirectory in @('out', 'out/patched', 'out/mitigated')) {
            [System.IO.Directory]::CreateDirectory((Join-Path $PSScriptRoot $halimDirectory)) | Out-Null
        }
        & docker compose -f lab/compose.yaml up -d --wait
        if ($LASTEXITCODE -ne 0) { throw 'Lab belum berhasil dimulai. Periksa Docker dan konflik port/container dengan lab lama.' }
        Write-Host 'Lab rentan: http://127.0.0.1:8088/'
        Write-Host 'Kontrol patch: http://127.0.0.1:8089/'
        Write-Host 'Kontrol mitigasi: http://127.0.0.1:8090/'
    } elseif ($Action -eq 'stop') {
        & docker compose -f lab/compose.yaml down
        if ($LASTEXITCODE -ne 0) { throw 'Penghentian lab gagal.' }
    } else {
        & docker compose -f lab/compose.yaml ps
        if ($LASTEXITCODE -ne 0) { throw 'Status lab tidak dapat dibaca.' }
    }
} finally {
    Pop-Location
}
