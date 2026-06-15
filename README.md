# El Taller de Máscaras

Videojuego en 3D de exploración y alquimia desarrollado en **Godot Engine 4.6** con GDScript.

Eres un aprendiz de alquimista en un taller misterioso. Explora el escenario, recolecta ingredientes, combínalos en el caldero y descubre nuevas sustancias.

## Requisitos

- Godot Engine 4.6+ (mono no requerido)

## Cómo ejecutar

1. Abre Godot Engine.
2. Importa el proyecto desde `Game/el-taller-de-mascaras/project.godot`.
3. Presiona **F5** (Play) o haz clic en el botón de reproducción.

## Controles

| Tecla | Acción |
|-------|--------|
| WASD | Moverse |
| Shift | Correr |
| Ctrl | Agacharse |
| E | Interactuar |
| Tab | Abrir/cerrar inventario |
| M | Instrucciones |
| Ratón | Mirar alrededor |
| Click izquierdo | Diálogos / Interacción |

## Estructura del proyecto

```
Game/el-taller-de-mascaras/   → Proyecto principal de Godot
├── Objects/
│   ├── Scripts/               → Lógica del juego
│   │   ├── Assets/Caldero/    → Sistema de alquimia y mezclas
│   │   ├── Assets/Potions/    → Ítems y pociones
│   │   ├── Escenes/           → Menú y escena principal
│   │   └── global.gd          → Estado global
│   ├── Escenes/               → Escenas del juego
│   └── assets/                → Recursos (HUD, sonido, modelos)
├── test/                      → Pruebas TDD y ATDD
└── addons/                    → Plugins (Dialogic, FPC)

Tests_Automatizados/           → Pruebas extendidas y BDD
├── features/                  → Escenarios Gherkin (BDD)
├── test_caldero_extended.gd
├── test_pociones_extended.gd
├── test_inventory_extended.gd
└── test_atdd_extended.gd

TestRunner/                    → Ejecutor de pruebas automatizado
└── run_all_tests.gd
```

## Pruebas

El proyecto implementa **TDD**, **BDD** y **ATDD** con **102 pruebas automatizadas** distribuidas en 6 suites.

### Ejecutar todas las pruebas

```bash
# Desde la terminal, usando Godot en modo headless:
godot --headless --script TestRunner/run_all_tests.gd

# O desde una suite individual:
godot --headless --script Game/el-taller-de-mascaras/test/test_all.gd
```

También puedes ejecutar las pruebas desde el editor de Godot:
1. Abre el proyecto en Godot.
2. En el menú **Editor → Editor Settings → Test → Run Tests** selecciona el archivo deseado.
3. O ejecuta directamente un script desde el panel de archivos con clic derecho → **Run**.

### Suites de prueba

| Suite | Archivo | Pruebas | Cobertura |
|-------|---------|---------|-----------|
| TDD Original | `test/test_all.gd` | 18 | 19.5% |
| ATDD Original | `test/test2_all.gd` | 9 | 26.5% criterios |
| TDD Caldero | `Tests_Automatizados/test_caldero_extended.gd` | 11 | Caldero |
| TDD Pociones | `Tests_Automatizados/test_pociones_extended.gd` | 21 | Pociones |
| TDD Inventario | `Tests_Automatizados/test_inventory_extended.gd` | 24 | Inventario |
| ATDD Extendido | `Tests_Automatizados/test_atdd_extended.gd` | 19 | Todos los módulos |
| BDD | `Tests_Automatizados/features/*.feature` | 6 archivos | 31 escenarios Gherkin |

**Resultado: 102/102 pruebas pasadas (100% éxito).**

### Módulos probados

- **ItemData** - Creación, asignación de propiedades, recursos
- **Caldero** - Lógica de mezcla, detección de combinaciones, lanzamiento físico
- **Inventario** - Apertura/cierre, arrastre de ítems, slots, tooltips
- **Estado Global** - Variables de estado del juego
- **Menú** - Navegación, botones
- **Diálogos** - Sistema de diálogos con Dialogic
- **Diario/Instrucciones** - Sistema de ayuda
- **Pociones** - World drops, físicas, interacción

## Licencia

GNU General Public License v3. Ver [LICENSE](LICENSE).
