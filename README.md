# Pokédex Offline-First

Pokédex móvil hecha con Flutter que consume la API GraphQL de PokeAPI y funciona
sin Internet. Proyecto de **Desarrollo de Aplicaciones Móviles** (PUCMM, Escuela
de Ingeniería en Computación y Telecomunicaciones). Este README corresponde al
**avance del proyecto final**.

## Contenido

1. [Descripción](#1-descripción)
2. [Estado del avance](#2-estado-del-avance)
3. [Requisitos de ejecución](#3-requisitos-de-ejecución)
4. [Instalación y ejecución](#4-instalación-y-ejecución)
5. [Tecnologías y su justificación](#5-tecnologías-y-su-justificación)
6. [Arquitectura](#6-arquitectura)
7. [Estructura del proyecto](#7-estructura-del-proyecto)
8. [Estrategia Offline-First](#8-estrategia-offline-first)
9. [Uso de GraphQL y paginación](#9-uso-de-graphql-y-paginación)
10. [Estrategia de sincronización](#10-estrategia-de-sincronización)
11. [Persistencia local](#11-persistencia-local)
12. [Gestión de conectividad](#12-gestión-de-conectividad)
13. [Funcionalidades implementadas](#13-funcionalidades-implementadas)
14. [Limitaciones conocidas](#14-limitaciones-conocidas)
15. [Pruebas](#15-pruebas)
16. [Uso de inteligencia artificial](#16-uso-de-inteligencia-artificial)
17. [Autoría y créditos](#17-autoría-y-créditos)

## 1. Descripción

La aplicación muestra el catálogo de Pokémon (nombre, número de la Pokédex
nacional, imagen y tipos) y sigue funcionando sin conexión, incluso después de
cerrarla y abrirla de nuevo.

La idea central es que **la base de datos local es la fuente de verdad**. La
pantalla solo lee de ella, y la red solo escribe en ella. Cuando hay servicio, la
app se actualiza desde PokeAPI en segundo plano sin bloquear la interfaz, y un
indicador global informa del estado de la conexión.

Esto no es una caché de respuestas: los datos se guardan en tablas con claves,
relaciones e índices, y se pueden consultar, filtrar y ordenar sin red.

## 2. Estado del avance

El enunciado del avance pide nueve entregables. Así se cubren:

| # | Entregable | Dónde está y cómo se comprueba |
|---|---|---|
| 1 | Estructura por funcionalidades con capas | `lib/features/*` con `presentation`, `domain` y `data`. El test `test/architecture/layer_dependencies_test.dart` revisa las dependencias entre capas. La feature `favorites` solo tiene capa `data` por ahora |
| 2 | Modelo de datos local (catálogo, favoritos y metadatos) | `lib/core/database/tables.dart`. Detalle en [Persistencia local](#11-persistencia-local) |
| 3 | Integración GraphQL con paginación, sin duplicados | `pokemon_remote_data_source.dart` y `catalog_sync.dart`. El test `catalog_sync_test.dart` repite la sincronización varias veces y comprueba que no hay duplicados |
| 4 | La interfaz observa la base local | La pantalla lee `catalogStateProvider`, que sale de `PokemonRepository`, que lee de Drift. Ningún widget importa GraphQL ni la base. Lo comprueba el test de capas |
| 5 | Interfaz sin bloqueos | La sincronización arranca tras el primer cuadro (`lib/app/app.dart`). `app_smoke_test.dart` comprueba que una sincronización que nunca termina no bloquea la interfaz |
| 6 | Catálogo funcional con estados y "Reintentar" | `catalog_page.dart` muestra carga, contenido, vacío y error. Lo cubre `catalog_page_test.dart` |
| 7 | Funcionamiento offline, también tras reiniciar | `offline_restart_test.dart` cierra la base, la reabre sin red y comprueba los datos. Además se probó en un teléfono real |
| 8 | Indicador de conectividad con texto e ícono | `lib/features/connectivity/`. Implementa los cuatro estados: Sin conexión, Sin servicio, Sincronizando y En línea (más Verificando) |
| 9 | README, ADR e historial de commits | Este README, `docs/arquitectura.md` y `docs/adr/` |

Cómo demostrar en vivo los escenarios que pide el avance:

- **PA-03 (consultar sin Internet):** con el catálogo ya descargado, activar el
  modo avión y abrir la app. El catálogo aparece, y el indicador muestra
  "Sin conexión".
- **PA-04 (reinicio sin Internet):** con el modo avión activo, cerrar la app desde
  las apps recientes y abrirla de nuevo. El catálogo y las imágenes ya vistas
  siguen ahí.

## 3. Requisitos de ejecución

Probado con:

| Herramienta | Versión |
|---|---|
| Flutter | 3.47.8 (canal estable) |
| Dart | 3.13.7 |
| Android SDK | plataforma 37, build-tools 37.0.0 |
| Android NDK | 28.2.13676358 |
| JDK | el que incluye Android Studio |
| Dispositivo | Samsung SM-A546E, Android 16, por USB |

Notas:

- La ruta del SDK de Android no debe tener espacios. Con espacios, `flutter doctor`
  avisa y las herramientas del NDK pueden fallar.
- Gradle puede pedir el NDK 28.2.13676358 y no instalarlo solo. Si pasa, se
  instala a mano desde Android Studio (SDK Manager, pestaña SDK Tools, con
  "Show Package Details").
- El proyecto fija `flutter: '>=3.47.0 <3.48.0'` en `pubspec.yaml`. No se debe
  actualizar Flutter sin revisar las dependencias.
- **iOS no se ha compilado ni probado** (ver [Limitaciones](#14-limitaciones-conocidas)).

## 4. Instalación y ejecución

```bash
git clone https://github.com/danielsab0001/pokedex-offline-first.git
cd pokedex-offline-first
flutter pub get
flutter run
```

Otros comandos:

```bash
flutter analyze          # análisis estático, debe terminar sin problemas
flutter test             # pruebas automáticas
dart format .            # formato
flutter build apk --release
```

Los archivos generados por Drift (`*.g.dart`) están en el repositorio, así que
la app se ejecuta sin generar nada. Solo hay que regenerarlos si se cambian las
tablas:

```bash
dart run build_runner build
```

Los textos traducidos (`lib/l10n/app_localizations*.dart`) se generan solos con
`flutter pub get` o al compilar.

**Cuota de la API:** PokeAPI permite 100 llamadas por hora por IP. Una instalación
limpia usa unas 11, y cada arranque posterior usa 1. Con muchos reinicios
seguidos conviene espaciarlos.

## 5. Tecnologías y su justificación

| Dependencia | Para qué se usa | Por qué esta y no otra |
|---|---|---|
| `flutter_riverpod` | Estado e inyección de dependencias | Providers que se pueden sustituir en los tests, sin generación de código. BLoC añade más piezas de las necesarias |
| `drift` y `drift_dev` | Base SQLite tipada, con transacciones y consultas observables | Cumple la fuente de verdad observable. Hive e Isar son NoSQL, con filtros y relaciones menos directos |
| `drift_flutter` | Abre el archivo SQLite en el dispositivo | Es la forma recomendada de abrir Drift en Flutter |
| `build_runner` | Genera el código de Drift | Solo lo usa Drift |
| `graphql` | Cliente GraphQL | Es Dart puro. `graphql_flutter` añade widgets que no se necesitan, porque la interfaz nunca consume GraphQL directamente |
| `http` | Tipos de red y cliente falso en las pruebas | El cliente GraphQL lo usa por debajo, y las pruebas simulan la API con él |
| `connectivity_plus` | Saber si el dispositivo tiene red | Es el plugin estándar. No basta para decidir que la API responde (ver [conectividad](#12-gestión-de-conectividad)) |
| `go_router` | Navegación | Es el router recomendado. Hoy solo hay una ruta, y crecerá con el detalle |
| `cached_network_image` y `flutter_cache_manager` | Imágenes con caché en disco acotada | Permiten ver offline las imágenes ya descargadas y limitar el espacio |
| `flutter_localizations` e `intl` | Español e inglés con archivos ARB | `intl` lo exige la generación de textos. Los textos se generan con `gen-l10n`, sin paquetes extra |
| `flutter_lints` | Reglas de análisis | Además se activan `always_use_package_imports`, `prefer_single_quotes` y `unawaited_futures` |

## 6. Arquitectura

Arquitectura limpia organizada por funcionalidades. Las dependencias apuntan hacia
el dominio:

- **Presentation:** pantallas, widgets, estado y navegación. No accede a GraphQL
  ni a la base de datos.
- **Domain:** entidades, contratos de repositorio y reglas puras. No depende de
  Flutter ni de la infraestructura.
- **Data:** implementa los contratos, con las fuentes de datos local y remota,
  los DTO, la sincronización y la traducción de errores.
- **`app/`** conecta las piezas (`di/providers.dart`) y arranca la aplicación.
- **`core/`** contiene solo infraestructura compartida.

El diagrama de arquitectura, el flujo de datos y el resto de los diagramas están
en [`docs/arquitectura.md`](docs/arquitectura.md). Las decisiones, en
[`docs/adr/`](docs/adr/):

- [ADR-001: organización por funcionalidades con capas](docs/adr/ADR-001-arquitectura-por-funcionalidades.md)
- [ADR-002: la base de datos local es la fuente de verdad](docs/adr/ADR-002-base-de-datos-local-como-fuente-de-verdad.md)
- [ADR-003: sincronización por páginas con cursor](docs/adr/ADR-003-sincronizacion-por-paginas-con-cursor.md)

## 7. Estructura del proyecto

```
lib/
├── app/             arranque, inyección de dependencias, tema y router
├── core/            base de datos, red, sincronización, errores y widgets comunes
├── features/
│   ├── pokemon/         catálogo (presentation, domain y data)
│   ├── connectivity/    indicador de conexión (presentation, domain y data)
│   └── favorites/       solo la capa data por ahora
└── l10n/            textos en español e inglés
test/                refleja la estructura de lib/
docs/                ADR, arquitectura y evidencias
```

El árbol completo, con la responsabilidad de cada archivo, está en
[`docs/arquitectura.md`](docs/arquitectura.md#2-estructura-del-proyecto).

## 8. Estrategia Offline-First

- **La interfaz solo lee de la base local.** Las respuestas de PokeAPI nunca se
  muestran directamente: se validan, se guardan en SQLite, y la pantalla se
  entera porque la base avisa del cambio.
- **Primera ejecución con Internet:** la app abre al instante con un estado de
  carga. La descarga ocurre en segundo plano y las tarjetas van apareciendo a
  medida que se guardan las páginas.
- **Primera ejecución sin Internet:** no hay datos que mostrar, así que la
  pantalla explica el problema y ofrece "Reintentar".
- **Con datos locales y sin Internet:** el catálogo funciona igual. Un fallo de
  sincronización no oculta los datos, solo se refleja en el indicador.
- **Al reiniciar sin Internet:** los datos siguen en la base y las imágenes ya
  vistas siguen en la caché de disco. Las que no se descargaron muestran un ícono
  de respaldo.
- **Al volver la red:** la app lo detecta sola, vuelve a comprobar la API y
  sincroniza, sin que el usuario haga nada.

## 9. Uso de GraphQL y paginación

- **Endpoint:** `https://graphql.pokeapi.co/v1beta2`, por POST.
- **Consulta:** una sola por página. Pide las especies con `id > cursor`, ordenadas
  por `id`, con su nombre en español e inglés, la generación y los tipos del
  Pokémon por defecto. En la misma petición pide el total de especies.
- **Paginación por cursor,** con páginas de 100. El cursor es el último número de
  Pokédex recibido. Se descartó el desplazamiento (offset) porque puede saltar o
  repetir registros si los datos cambian entre páginas.
- **Solo se piden los campos necesarios.** No se descarga el detalle de cada
  Pokémon.
- **Sin caché del cliente** (`noCache`): la única fuente de verdad es la base.
- **Tiempo máximo de espera:** 15 segundos.
- **DTO y conversión:** la respuesta se valida y se convierte a un registro de la
  capa data. Si falta un campo obligatorio, es un error de respuesta inválida y
  no se guarda nada.
- **Errores diferenciados:** sin red, tiempo agotado, error de GraphQL, respuesta
  inválida, límite de peticiones (429), cualquier otro estado HTTP no exitoso y
  error de almacenamiento. Son tipos de error propios (`Failure`), y fuera de la
  capa data nadie ve excepciones de `graphql` ni de `http`.

## 10. Estrategia de sincronización

Es unidireccional: remoto a local. PokeAPI es la autoridad del catálogo. Los
datos del usuario (favoritos y preferencias) no se tocan.

**Dos recursos con el mismo mecanismo:**

- `catalog_index`: descarga el catálogo completo, página por página, y se reanuda
  desde el cursor guardado.
- `catalog_verify`: revisa una página por disparo y da la vuelta al terminar.
  Sobrescribe los datos locales con los de PokeAPI.

**Garantías:**

- Cada página se guarda en una **sola transacción**, junto con el cursor y el
  estado. Si algo falla, no queda nada a medias.
- **Sin duplicados:** la clave es el número de la Pokédex y se escribe con
  "insertar o actualizar". Los tipos de un Pokémon se reemplazan completos.
- **Una sola ejecución por recurso a la vez** (`SingleFlight`): una segunda
  petición recibe el resultado de la primera.
- **La sincronización nunca lanza errores a la pantalla:** guarda el resultado en
  `sync_metadata` y la pantalla lo observa.
- **Recuperación:** al abrir la app, un recurso que quedó en `syncing` se marca
  como `interrupted` y se continúa desde su cursor.

**Cuándo se sincroniza:**

| Disparador | Estado |
|---|---|
| Al abrir la app, después del primer cuadro | Implementado |
| Al recuperar la red (con espera de 2 segundos) | Implementado |
| Botón "Sincronizar ahora" y "Reintentar" | Implementado |
| Periódico, mientras el servicio esté disponible | Pendiente |
| Al abrir el detalle de un Pokémon | Pendiente |

Decisiones de persistencia y sincronización pedidas por el enunciado:

| Código | Decisión |
|---|---|
| PS-01 | Modelo de datos en [Persistencia local](#11-persistencia-local) y en `docs/arquitectura.md` |
| PS-02 | La descarga completa se hace en segundo plano. La app no la espera para abrirse |
| PS-03 | Los datos se consideran vigentes hasta su próxima verificación. No hay caducidad por tiempo todavía |
| PS-04 | Disparadores de la tabla anterior |
| PS-05 | La clave de cada Pokémon es su número de Pokédex |
| PS-06 | "Insertar o actualizar" sobre esa clave |
| PS-07 | El cursor se guarda con cada página, y se continúa desde él |
| PS-08 | Sprites en caché de disco: hasta 1100 archivos, y se limpian pasados 90 días sin usarse |
| PS-09 | Tabla `sync_metadata`, que el indicador muestra en su hoja de detalles |
| PS-10 | Estados `failed` e `interrupted` guardados. Versión del esquema para las migraciones. Reintentos con espera creciente pendientes |
| PS-11 | Las tablas del usuario no tienen relación con las del catálogo |
| PS-12 | La verificación sobrescribe los datos locales con los de PokeAPI |

## 11. Persistencia local

SQLite con Drift, en una sola base (`AppDatabase`) con seis tablas:

| Tabla | Contenido | Clave |
|---|---|---|
| `pokemon` | Nombre en inglés, nombre en español (puede faltar), generación y fecha de sincronización | `id` (número de Pokédex) |
| `type` | Tipos (fuego, agua...) | `id` |
| `pokemon_type` | Tipos de cada Pokémon, con la posición (1 o 2) | (`pokemon_id`, `slot`) |
| `favorite` | Favoritos del usuario | `pokemon_id` |
| `sync_metadata` | Estado de cada recurso: cursor, total remoto, fechas, fallos y último error | `resource_key` |
| `user_preference` | Preferencias, como JSON en texto | `key` |

- Índices por nombre, por (generación, id) y por (tipo, Pokémon). Un test con
  `EXPLAIN QUERY PLAN` comprueba que se usan.
- Claves foráneas activadas al abrir la base. `pokemon_type` borra en cascada.
- `favorite` y `user_preference` no tienen clave foránea hacia el catálogo.
- El nombre en español puede faltar: la interfaz cae al inglés.
- Cambios futuros del esquema: subir `schemaVersion` y escribir la migración.

El diagrama completo está en [`docs/arquitectura.md`](docs/arquitectura.md#5-modelo-de-datos-local).

## 12. Gestión de conectividad

"Hay Wi-Fi" no significa que la API responda. Por eso el estado se calcula con
dos señales:

- **La red del dispositivo** (`connectivity_plus`), con una espera de 2 segundos
  para que un corte breve no haga parpadear el indicador.
- **El resultado de la última llamada real a GraphQL.** Sin una llamada exitosa,
  nunca se muestra "En línea".

Y con dos dimensiones separadas: disponibilidad del servicio y actividad de
sincronización. Así existe "en línea y sincronizando", y no existe "sin conexión
y con API accesible".

**Indicador:** un chip en la barra superior, con ícono y una palabra, que se
distingue sin depender del color. Al tocarlo abre una hoja con la explicación del
estado, el origen de los datos (siempre "guardados en este dispositivo"), la
última sincronización, el progreso del catálogo y el botón "Sincronizar ahora".

| Estado | Ícono | Texto |
|---|---|---|
| Sin red, o sin salida a Internet | nube tachada | Sin conexión |
| Red activa y la API falla | triángulo de aviso | Sin servicio |
| Actualizando el catálogo | flechas circulares | Sincronizando |
| Comprobando la API | reloj de arena | Verificando |
| La API responde | nube con visto | En línea |

La tabla de decisión completa está en
[`docs/arquitectura.md`](docs/arquitectura.md#6-cómo-se-calcula-el-indicador-de-conectividad).

## 13. Funcionalidades implementadas

- Catálogo con número, nombre, imagen y tipos, con carga progresiva: la lista pide
  más datos a la base al acercarse al final, y nunca construye el catálogo entero.
- Estados de carga, contenido, vacío y error, con "Reintentar".
- Funcionamiento offline, también después de reiniciar.
- Indicador global de conectividad con hoja de detalles.
- Sincronización automática al abrir la app y al recuperar la red, y manual.
- Español e inglés en el catálogo y el indicador (los nombres de los tipos se
  traducen).
- Tema claro y oscuro (sigue al sistema).
- Accesibilidad: cada tarjeta se lee como una frase, el estado de conexión no
  depende del color, los objetivos táctiles miden al menos 48 dp y hay pruebas
  con el texto al 200%.

## 14. Limitaciones conocidas

**Fuera del alcance del avance** (el propio enunciado del avance las deja para la
entrega final):

- Detalle de Pokémon, pantalla de favoritos, búsqueda, filtros, ordenación y
  trivia. Los favoritos tienen persistencia y pruebas, pero todavía no hay
  pantalla.
- Reintentos con espera creciente y límite de intentos.
- Sincronización periódica y al abrir el detalle.
- Mecanismo para simular "Servicio no disponible" con red activa (escenario
  PA-08). La lógica de ese estado está probada con tests, pero todavía no se
  puede provocar en el teléfono.
- Inspector de base de datos dentro de la app, para las demostraciones PA-13 y
  PA-16. Mientras tanto se inspecciona con `adb` y DB Browser for SQLite, porque
  el Database Inspector de Android Studio no muestra esta base.
- Las capturas de pantalla (ENT-11) se agregarán a `docs/evidence` con la entrega
  final.

**Limitaciones de la solución actual:**

- **iOS no se ha compilado ni probado.** Se mantiene la carpeta `ios/` que genera
  Flutter, pero no hay un Mac disponible.
- **`go_router` (17.5) y `cached_network_image` (3.4.1) están en versiones
  anteriores a las últimas** (hay un 18 y un 4). Se mantienen los imports
  tradicionales de Material, y se pasaría a las versiones nuevas migrando a
  `material_ui`. Se comprobó que las versiones fijadas resuelven y compilan sobre
  Flutter 3.47.8.
- Si PokeAPI elimina una especie, la app no la borra de la base.
- La verificación revisa una página por disparo, así que cubrir las 1025 especies
  lleva varios arranques.
- Si la red no cambia pero el acceso a Internet vuelve (por ejemplo, un Wi-Fi con
  portal cautivo), no hay un evento que lo detecte: el indicador se actualiza con
  la siguiente llamada.
- El indicador tarda unos 2 segundos en mostrar un corte de red. Es intencional.
- El último error de sincronización se muestra con su texto técnico, sin traducir.
- La regla de capas se comprueba con un test que mira imports directos. No detecta
  que presentación llegue a la capa data pasando por `app/di`.
- Las pruebas de rendimiento con Flutter DevTools (RNF-REN-05) todavía no se han
  hecho.

## 15. Pruebas

Más de 160 pruebas automáticas, todas con `flutter test`. No usan Internet ni un
dispositivo: simulan PokeAPI con un cliente HTTP falso y usan una base SQLite en
memoria (o en un archivo temporal).

| Qué se prueba | Dónde |
|---|---|
| Regla de dependencia entre capas | `test/architecture/` |
| Base de datos, índices, upsert, transacciones y favoritos | `test/core/database/`, `test/features/pokemon/pokemon_local_data_source_test.dart`, `test/features/favorites/` |
| Cliente GraphQL y traducción de errores | `test/features/pokemon/pokemon_remote_data_source_test.dart` |
| Sincronización: páginas, reanudación, concurrencia y sin duplicados | `test/features/pokemon/catalog_sync_test.dart`, `test/core/sync/` |
| Funcionamiento offline tras reiniciar | `test/features/pokemon/offline_restart_test.dart` |
| Estado de la pantalla y pantalla del catálogo | `test/features/pokemon/catalog_state_test.dart`, `catalog_page_test.dart` |
| Conectividad, indicador y reconexión | `test/features/connectivity/`, `test/app/` |
| Arranque de la app en español e inglés | `test/app_smoke_test.dart` |

También se probó la app a mano en un teléfono real: instalación limpia con y sin
Internet, modo avión, reinicio sin conexión, recuperación automática de la red,
modo oscuro y texto ampliado.

## 16. Uso de inteligencia artificial

Este proyecto se desarrolló con la ayuda de **Claude (Anthropic)**, un asistente
de IA, que se usó como guía paso a paso durante todo el trabajo. Según lo que
exige el enunciado (§17.6), declaro cómo:

- El asistente propuso las decisiones de diseño y las alternativas, escribió la
  mayor parte del código, de las pruebas y de los borradores de la documentación,
  y explicó cada pieza.
- Yo ejecuté cada paso en mi equipo, corrí el análisis y las pruebas, probé la
  aplicación en un teléfono real, corregí los errores que fueron apareciendo junto
  con el asistente, y aprobé las decisiones antes de aplicarlas.
- Los datos del esquema de PokeAPI (nombres de campos, total de especies, ids de
  idioma) los verifiqué en su consola GraphQL y no se tomaron de memoria.
- No se incorporó código de terceros aparte de las dependencias declaradas en
  `pubspec.yaml`.

Soy responsable de todo el código entregado y estoy preparado para explicarlo.

## 17. Autoría y créditos

- **Autor:** Daniel Almonte 10149898. Trabajo individual.
- **Docente:** Freddy Peña.
- **Datos:** [PokeAPI](https://pokeapi.co). Las imágenes provienen del
  repositorio [PokeAPI/sprites](https://github.com/PokeAPI/sprites).
- Pokémon y los nombres de los personajes son marcas de Nintendo, Game Freak y
  Creatures. Este es un proyecto académico sin fines comerciales.