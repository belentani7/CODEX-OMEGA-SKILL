# Formato de Skills de Agente — Especificación verificada

Fuentes: `https://developers.openai.com/codex/skills` · Anthropic Claude Code skills docs · especificación `https://agentskills.io/specification` · skills.sh (Vercel).

## Definición

Una **skill** es un paquete reutilizable de instrucciones que extiende a un agente de IA (Codex, Claude Code, Cursor, Copilot, Antigravity, OpenCode…) con capacidad especializada. Formato abierto y multiplataforma: una skill hecha para Codex funciona en Claude Code sin cambios.

## Estructura de una skill

```
mi-skill/
├── SKILL.md            # OBLIGATORIO: instrucciones + metadatos (frontmatter YAML)
├── scripts/            # Opcional: código ejecutable (tareas deterministas)
├── references/         # Opcional: documentación larga (cargada bajo demanda)
├── assets/             # Opcional: plantillas, recursos, iconos
└── agents/
    └── openai.yaml     # Opcional (solo Codex): metadatos UI + dependencias MCP
```

## Frontmatter obligatorio

El `SKILL.md` DEBE tener `name` y `description` en frontmatter YAML, o la skill no se cargará:

```markdown
---
name: mi-skill
description: Explica exactamente CUÁNDO debe y NO debe disparar esta skill.
---

Instrucciones imperativas para el agente…
```

**Cómo escribir una buena `description`** (es el mecanismo de triggering):
- Front-load del caso de uso y palabras gatillo (por si se recortan descripciones).
- Escope y límites claros: "Dispara cuando el usuario mencione X. NO disparar para Y."
- Ser un poco "insistente": incluir contextos aunque no se nombre la skill explícitamente.
- Tono imperativo, con límites y ejemplos.

## Progressive disclosure (cómo se cargan)

1. **Stage 1 — Startup**: el agente escanea directorios de skills y parsea solo el frontmatter → ~50–100 tokens por skill en contexto.
2. **Stage 2 — Match**: el prompt del usuario coincide con la `description` → se carga el `SKILL.md` completo + scripts/references.
3. **Stage 3 — Ejecuta y libera**: el agente sigue las instrucciones, ejecuta scripts, y libera el contexto al terminar.

En Codex, la lista inicial de skills está capada a ~2% del contexto del modelo (u 8000 caracteres); con muchas skills se acortan descripciones primero.

## Invocación

- **Explícita**: `@skill` (ChatGPT), `$skill` o `/skills` (Codex CLI/IDE).
- **Implícita**: el agente elige la skill cuando la tarea coincide con su `description`.

## Ubicaciones de instalación (Codex)

| Alcance | Ruta | Uso |
|---|---|---|
| Repo (cwd) | `.agents/skills` | Skills del módulo/carpeta actual |
| Repo (root) | `$REPO_ROOT/.agents/skills` | Skills de toda la organización del repo |
| Usuario | `$HOME/.agents/skills` | Skills personales para cualquier repo |
| Admin | `/etc/codex/skills` | Skills de sistema/máquina |
| Sistema | Bundled con Codex | skill-creator, plan, etc. |

Nota: si dos skills comparten `name`, Codex no las fusiona; ambas pueden aparecer en selectores.

## Configuración en Codex

Desactivar una skill sin borrarla (`~/.codex/config.toml`):

```toml
[[skills.config]]
path = "/ruta/a/skill/SKILL.md"
enabled = false
```

## Metadatos opcionales (agents/openai.yaml, solo Codex)

```yaml
interface:
  display_name: "Nombre visible"
  short_description: "Descripción corta"
  icon_small: "./assets/small.svg"
  brand_color: "#3B82F6"
policy:
  allow_implicit_invocation: false   # false = solo invocación explícita
dependencies:
  tools:
    - type: "mcp"
      value: "openaiDeveloperDocs"
      description: "Docs MCP"
      transport: "streamable_http"
      url: "https://developers.openai.com/mcp"
```

## Buenas prácticas (oficiales)

- Una skill = un trabajo. Mantener enfocada.
- Preferir **instrucciones** sobre scripts, salvo que se necesite comportamiento determinista.
- Pasos imperativos con inputs y outputs explícitos.
- Probar prompts contra la description para confirmar el triggering correcto.
- Mantener `SKILL.md` < ~500 líneas; mover el resto a `references/`.

## Ejemplos de referencia oficiales

- `github.com/openai/skills` (repo oficial, incluye `.curated/gh-fix-ci`, `.curated/pdf`, `.curated/linear`)
- `skills.sh` (directorio y gestor de skills de Vercel)
- `agentskills.io/specification` (la especificación del estándar abierto)
