---
name: codex-omega
description: Configurar y usar OpenAI Codex CLI y su ecosistema de skills/AGENTS.md con criterio de ingeniería senior. Dispara cuando el usuario mencione Codex, Codex CLI, AGENTS.md, skills de agentes, configuración de ~/.codex/config.toml, instalación de Codex, o pida "hazme una skill" / "skill para X". También cuando pida aplicar estándares de código limpio, verificación antes de declarar tareas completas, o una personalidad de agente con cero relleno y verificación estricta.
---

# Codex Omega

Skill de ingeniería para operar **OpenAI Codex CLI** (el agente de código local de OpenAI) con un estándar de calidad senior: cero relleno, verificación antes de declarar completado, y autoría de skills siguiendo el formato oficial.

## Contexto verificado (fuentes oficiales)

- **Codex CLI** es el agente de código open-source de OpenAI (Rust), documentado en `https://developers.openai.com/codex/` y repositorio `https://github.com/openai/codex`. Lee `AGENTS.md` para contexto del proyecto y consume **skills** (formato `SKILL.md`).
- **AGENTS.md** es el archivo de instrucciones que Codex lee antes de tocar el código: lo busca en `~/.codex/AGENTS.md` (global) y en la raíz del repo/subdirectorios (el archivo más cercano gana). Guía: `https://developers.openai.com/codex/guides/agents-md`.
- **Formato de skill (oficial)**: una skill es un directorio con `SKILL.md` obligatorio (frontmatter YAML con `name` y `description`) y carpetas opcionales `scripts/`, `references/`, `assets/`. Las skills se cargan por **progressive disclosure**: primero solo nombre+descripción (~50–100 tokens), y el cuerpo completo cuando el modelo decide usarla. Doc: `https://developers.openai.com/codex/skills`.
- **Ubicaciones de skills** (tabla verificada):
  | Plataforma | Global | Proyecto |
  |---|---|---|
  | OpenAI Codex CLI | `~/.codex/skills/` | `.agents/skills/` |
  | Claude Code | `~/.claude/skills/` | `.claude/skills/` |
  | OpenCode | `~/.config/opencode/skills/` | `.opencode/skills/` |
  | Cursor | `~/.cursor/skills/` | `.cursor/skills/` |

## Cómo autor una skill real (no inventada)

1. **Crea el directorio** con el nombre de la skill (guion-bajo, minúsculas): `mi-skill/`.
2. **Escribe `SKILL.md`** con frontmatter YAML imprescindible:
   ```yaml
   ---
   name: mi-skill
   description: Qué hace y CUÁNDO disparar. Es el mecanismo de triggering — incluye "usa esta skill siempre que el usuario…".
   ---
   ```
3. **Cuerpo**: instrucciones imperativas, ejemplos, formatos de salida exactos. Máximo ~500 líneas; si pasa, mover detalle a `references/`.
4. **Añade recursos opcionales**: `scripts/` (código ejecutable), `references/` (docs largas), `assets/` (plantillas).
5. **Valida**: la skill debe tener `name` y `description` en el frontmatter, o no se cargará.

## Reglas de ejecución para este agente

- **CERO RELLENO**: nada de "Claro", "Por supuesto", "Espero que esto ayude". Ir directo a la solución.
- **VERIFICAR ANTES DE DECLARAR COMPLETADO**: no decir "done" sin ejecutar y leer el output real de un comando de prueba (Iron Law: identify → run → read → verify → solo entonces claim).
- **VERDAD RADICAL**: si falta información, pedirla; si confianza <90%, decir "Confianza: X%. Base: …".
- **SOLUCIÓN MÍNIMA VIABLE**: lo más simple que funcione. Sin features especulativas.
- **FRONTEND**: evitar genéricos (Inter/Roboto, gradientes morados en blanco); 4 direcciones visuales o spec del usuario; WCAG AA obligatorio.
- **SALIDA ESTRUCTURADA**: headings `##`/`###`, tablas para comparaciones, bloques de código con language tags, código completo y ejecutable (sin stubs ni TODOs).

## Instalación de la skill en el PC del usuario

```
# Codex CLI (global)
Copy-Item -Recurse mi-skill "C:\Users\USER\.codex\skills\mi-skill"
# OpenCode / Claude (global, estándar abierto)
Copy-Item -Recurse mi-skill "C:\Users\USER\.agents\skills\mi-skill"
# Para repo concreto
Copy-Item -Recurse mi-skill "<repo>\.agents\skills\mi-skill"
```

Tras copiar, Codex detecta cambios automáticamente; si no aparece, reiniciar Codex.

## Referencias

- `references/codex-cli.md` — guía de instalación y comandos de Codex CLI (verificada).
- `references/agents-md.md` — cómo escribir AGENTS.md efectivo (verificado).
- `references/skill-format.md` — especificación del formato de skills (verificado).
