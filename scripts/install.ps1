# Instala la skill codex-omega en Codex CLI, OpenCode y Claude Code (global)
$skillDir = Split-Path -Parent $PSScriptRoot
$targets = @(
  "C:\Users\USER\.codex\skills\codex-omega",
  "C:\Users\USER\.agents\skills\codex-omega"
)
foreach ($t in $targets) {
  New-Item -ItemType Directory -Force -Path (Split-Path -Parent $t) | Out-Null
  Copy-Item -Recurse -Force -Path $skillDir -Destination $t
  Write-Host "Instalada en: $t"
}
Write-Host "Listo. Reinicia Codex/OpenCode para detectar la skill."
