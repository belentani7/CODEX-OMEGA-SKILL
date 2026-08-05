# Codex Omega — Skill verificada y real

Skill de ingeniería para operar **OpenAI Codex CLI** con criterio senior, incluyendo autoría de skills y AGENTS.md según el formato oficial.

## Veredicto de la verificación (varias fuentes)

| Reclamación de la skill antigua | Realidad verificada |
|---|---|
| "Códice Ω, 9 libros, 12 mandamientos" | Texto creativo, NO es una skill: sin frontmatter YAML, sin formato `SKILL.md` |
| Instalación en `.clinerules` / `.cursorrules` | INCORRECTO: eso es de Cline/Cursor. El formato de skill es `SKILL.md` con frontmatter `name`+`description` en `~/.codex/skills/` o `.agents/skills/` |
| "Codex" como sistema maestro filosófico | Codex real = CLI de agente de código de OpenAI (Rust, open-source) |

## Estructura

```
CODEX-OMEGA-SKILL/
├── SKILL.md                  # Skill real con frontmatter válido
├── references/
│   ├── codex-cli.md          # Instalación, comandos, config de Codex CLI (verificado)
│   ├── agents-md.md          # Cómo escribir AGENTS.md (verificado)
│   └── skill-format.md       # Especificación de skills de agente (verificado)
├── scripts/
│   └── install.ps1           # Instala la skill en Codex/OpenCode/Claude
└── README.md
```

## Instalación

```powershell
.\scripts\install.ps1
```

O manualmente:

```powershell
Copy-Item -Recurse "$PWD" "C:\Users\USER\.codex\skills\codex-omega"
Copy-Item -Recurse "$PWD" "C:\Users\USER\.agents\skills\codex-omega"
```

## Fuentes

- `https://developers.openai.com/codex/` — docs oficiales Codex
- `https://github.com/openai/codex` — repositorio open-source
- `https://developers.openai.com/codex/skills` — formato de skills
- `https://developers.openai.com/codex/guides/agents-md` — AGENTS.md
- `https://agentskills.io/specification` — especificación del estándar abierto
- `https://agents.md/` — estándar AGENTS.md (Agentic AI Foundation)
