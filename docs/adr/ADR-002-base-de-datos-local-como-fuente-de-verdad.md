# ADR-002: La base de datos local es la fuente de verdad

## Contexto

La app debe funcionar sin Internet y seguir funcionando al cerrarla y abrirla
de nuevo. El enunciado aclara que guardar respuestas de red en una caché no
cumple: se pide una base estructurada que se pueda consultar, filtrar y ordenar.

## Problema

¿Dónde viven los datos que ve el usuario para que la app no dependa de la red,
no duplique registros y no deje datos a medias?

## Opciones consideradas

- **Caché de respuestas GraphQL o HTTP:** sirve solo para repetir consultas ya
  hechas. No permite búsquedas nuevas sin conexión, y el enunciado la descarta.
- **Base NoSQL (Hive, Isar):** funciona, pero las relaciones, los índices y los
  filtros son menos directos que en SQL.
- **SQLite sin Drift (sqflite):** también sirve, pero sin consultas tipadas ni
  datos observables en tiempo real.
- **SQLite con Drift:** consultas tipadas, transacciones, índices y listas que se
  actualizan solas cuando cambia la base.

## Decisión

SQLite con Drift, en una sola base (`AppDatabase`).

- La interfaz **solo lee** de la base. La red **solo escribe** en la base, y la
  pantalla se entera porque la base avisa de los cambios.
- La clave de cada Pokémon es su número en la Pokédex nacional. Así, recibir el
  mismo Pokémon dos veces actualiza la misma fila y no crea otra.
- Se escribe con "insertar o actualizar" y nunca con "insertar o reemplazar":
  este último borra la fila y la vuelve a crear, y con ella se perderían sus
  tipos.
- Las claves foráneas se activan al abrir la base, porque SQLite las trae
  apagadas.
- Los favoritos y las preferencias **no tienen relación** con las tablas del
  catálogo. Así, sincronizar el catálogo nunca puede borrarlos ni modificarlos.
- El esquema inicial tiene seis tablas (`pokemon`, `type`, `pokemon_type`,
  `favorite`, `sync_metadata`, `user_preference`). Los cambios futuros se hacen
  subiendo la versión del esquema, con una migración.

## Consecuencias

- La app abre al instante y funciona sin conexión.
- Una búsqueda o un filtro nuevos funcionan sin red, porque consultan la base.
- Un favorito podría apuntar a un Pokémon que todavía no se descargó. La
  interfaz tiene que tolerarlo.
- Drift genera código. Los archivos generados se guardan en el repositorio para
  que quien lo clone pueda ejecutar la app sin generarlos.
- El Database Inspector de Android Studio no muestra esta base. Para
  inspeccionarla se usa `adb` con DB Browser for SQLite.