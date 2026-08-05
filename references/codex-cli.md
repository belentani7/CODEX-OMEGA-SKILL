# Codex CLI — Referencia verificada

Fuente: `https://developers.openai.com/codex/cli` · `https://github.com/openai/codex` · guías 2026.

## Qué es

Codex CLI es el agente de código local de OpenAI. Corresponde en terminal, lee y modifica archivos del directorio de trabajo, ejecuta comandos de shell y corre sobre los modelos de la familia GPT-5.x / Codex. Está incluido en ChatGPT Plus/Pro/Business/Edu/Enterprise. Código fuente abierto (Rust): `github.com/openai/codex`.

## Instalación (métodos oficiales)

1. **npm (recomendado, Node ≥20):**
   ```bash
   npm install -g @openai/codex
   ```
2. **Curl (macOS/Linux):**
   ```bash
   curl -fsSL https://codex.openai.com/install.sh | bash
   ```
3. **Homebrew (macOS):**
   ```bash
   brew install codex
   ```
4. **Binarios precompilados**: desde las releases de `github.com/openai/codex`.

## Autenticación

```bash
codex login
```
Abre el navegador para OAuth (cuenta de ChatGPT). O usa token de API:
```bash
codex login --api-key $OPENAI_API_KEY
```

## Comandos principales

| Comando | Función |
|---|---|
| `codex` | Inicia la sesión interactiva (TUI) en el directorio actual |
| `codex exec "tarea"` | Ejecución no interactiva (headless) |
| `codex install` / `codex uninstall` | Instala/desinstala el binario local |
| `codex mcp add <name> -- <cmd>` | Añade un servidor MCP |
| `codex mcp list` | Lista servidores MCP configurados |
| `codex login` / `codex logout` | Gestión de autenticación |
| `codex --version` / `codex --help` | Versión y ayuda |
| `/review` (en TUI) | Revisión de código inline sin modificar el árbol |
| `$skill` o `/skills` | Invocación explícita de una skill |

## Configuración

Archivo de configuración: `~/.codex/config.toml`.

```toml
model = "gpt-5-codex"          # o el modelo actual de la familia
approval_policy = "on-failure" # "never" | "on-failure" | "on-request" | "untrusted"
web_search = "live"            # búsqueda web en vivo
```

Opciones de `approval_policy`:
- `never` — no pedir confirmación (solo acciones seguras)
- `on-failure` — pedir solo cuando un comando falla (por defecto)
- `on-request` — pedir cuando el modelo lo solicita
- `untrusted` — sandbox + aprobación (requiere modo sandbox)

## Variables de entorno

- `OPENAI_API_KEY` — API key
- `CODEX_HOME` — carpeta base (por defecto `~/.codex`)
- `CODEX_MODEL` — modelo por defecto
- `PATH` — heredado para ejecutar comandos

## MCP (Model Context Protocol)

Configurable en `config.toml` o por CLI:

```toml
[mcp_servers.context7]
command = "npx"
args = ["-y", "@upstash/context7-mcp"]
```

MCPs populares documentados por OpenAI: Context7 (docs), Figma, Playwright, Chrome DevTools, GitHub, Sentry.

## Modos de trabajo

- **TUI interactiva**: `codex` — sesión con historial, edición de archivos, revisión.
- **Non-interactive**: `codex exec "..."` — scripts, CI, automatización.
- **Subagentes**: flag `multi_agent` para paralelizar tareas (consume más tokens).
- **Imágenes**: flag `-i` para adjuntar screenshots/specs al prompt.

## Notas de Windows

- Windows 11 + PowerShell: ejecutar MCPs con `-ExecutionPolicy Bypass` o `cmd.exe /c npx ...`.
- Soporte WSL disponible.
- Los hooks/scripts requieren rutas con comillas cuando hay espacios.

## Trampas comunes

- `codex` no debe confundirse con "Codex" el modelo antiguo (GPT-3 Codex, 2021, retirado). El Codex actual es el agente/CLI.
- Las skills NO se ponen en `.clinerules` ni `.cursorrules` (eso es Cline/Cursor). El formato de skill es `SKILL.md` con frontmatter.
