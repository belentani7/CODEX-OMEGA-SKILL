# AGENTS.md — Referencia verificada

Fuente: `https://developers.openai.com/codex/guides/agents-md` · `https://agents.md/` · guías 2026.

## Qué es

`AGENTS.md` es el archivo de instrucciones que Codex CLI lee antes de tocar el código. Da contexto de proyecto: estructura, arquitectura, convenciones de commits, restricciones de seguridad y pasos de despliegue. El formato está estandarizado por la **Agentic AI Foundation** (bajo la Linux Foundation) y es multiplataforma.

## Orden de descubrimiento (jerarquía)

1. `AGENTS.override.md` en `$CODEX_HOME` (si existe) → gana sobre todo
2. `AGENTS.md` en `$CODEX_HOME` (`~/.codex/AGENTS.md`) → instrucciones globales
3. Desde la raíz del repo hasta el directorio actual: leer el `AGENTS.md` de CADA nivel
4. **Regla de fusión: el archivo más cercano al CWD gana** (los de más abajo en el árbol tienen prioridad)

```
codex starts → AGENTS.override.md? → AGENTS.md global? → walk tree root→cwd → nearest wins
```

## Contenido efectivo (qué funciona)

- **Resumen del proyecto**: qué es, stack, estructura de directorios.
- **Convenciones**: formato de commits, naming, estilos.
- **Comandos**: build, test, lint, deploy (con las órdenes exactas).
- **Restricciones**: seguridad, archivos que no tocar, límites.
- **Mantenerlo corto**: máximo ~32 KiB; Codex lo lee completo.

## Formato de ejemplo (del estándar agents.md)

```markdown
# Mi Proyecto

- Stack: TypeScript, pnpm, Vitest
- Estructura: src/ (código), tests/ (espejo), docs/

## Commands
- Install: `pnpm install`
- Dev: `pnpm dev`
- Test: `pnpm test`
- Lint: `pnpm lint`

## Conventions
- Title format: `[<proyecto>] <Título>`
- Siempre ejecutar `pnpm lint` y `pnpm test` antes de commitear
```

## AGENTS.md + Skills (cómo se complementan)

- **AGENTS.md** = contexto SIEMPRE activo sobre el proyecto (siempre en prompt).
- **Skill** = experiencia bajo demanda para una tarea específica (se carga solo al usarla).

Ejemplo: AGENTS.md dice "monorepo TypeScript con pnpm, patrón Result". La skill `code-reviewer` dice "revisa seguridad → lógica → rendimiento → estilo". Preguntar "revisa el módulo auth" usa ambos.

## Diferencias con CLAUDE.md (para no confundir)

- `CLAUDE.md` es de Anthropic Claude Code (equivalente funcional).
- `AGENTS.md` es el estándar abierto multi-herramienta (Codex, Cursor, Copilot, etc.).
- Puedes tener ambos; cada agente lee el suyo.
