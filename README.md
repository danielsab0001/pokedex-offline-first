# Pokédex Offline-First

Pokédex móvil hecha con Flutter que consume la API GraphQL de PokeAPI y funciona
sin Internet. Proyecto de **Desarrollo de Aplicaciones Móviles** (PUCMM, Escuela
de Ingeniería en Computación y Telecomunicaciones). Este README refleja el
estado actual del **proyecto final** (ver [Estado del proyecto](#2-estado-del-proyecto)).

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

## 2. Estado del proyecto

El avance ya se presentó. Así está el proyecto frente al enunciado final:

| Área | Estado |
|---|---|
| Offline-First, sincronización, reintentos y presupuesto de llamadas | Hecho |
| Indicador global de conexión en todas las pantallas | Hecho |
| Catálogo con búsqueda, filtros y orden, guardados entre sesiones | Hecho |
| Favoritos: corazón, pantalla y funcionamiento sin conexión | Hecho |
| Herramientas de depuración para las demostraciones | Hecho |
| Detalle del Pokémon | Pendiente |
| Trivia | Pendiente |
| Animaciones y tarjeta para compartir | Pendiente |
| Pulido final: evidencias, rendimiento y contraste | Pendiente |

### Cómo demostrar en vivo los escenarios del enunciado

El panel de depuración se abre con el icono de insecto del catálogo (ver
[Instalación y ejecución](#4-instalación-y-ejecución)).

| Escenario | Cómo se demuestra |
|---|---|
| PA-01 Primera ejecución con Internet | Borrar los datos de la app y abrirla. Se puede navegar mientras descarga. El indicador pasa a "Sincronizando" y luego a "En línea" |
| PA-02 Consultar un Pokémon no guardado | Pendiente: necesita la pantalla de detalle. El refresco por especie ya existe |
| PA-03 Consultar sin Internet | Con el catálogo descargado, activar el modo avión. Catálogo y favoritos siguen ahí y el indicador dice "Sin conexión" |
| PA-04 Reinicio sin Internet | Con el modo avión activo, cerrar la app desde las recientes y abrirla |
| PA-05 Búsqueda y filtros sin conexión | Con el modo avión: buscar, filtrar por tipo y generación, y cambiar el orden |
| PA-06 Favoritos sin conexión | Con el modo avión: agregar y quitar, abrir Favoritos y reiniciar la app |
| PA-07 Recuperación automática | Quitar el modo avión sin tocar la app: pasa a "Sincronizando" y luego a "En línea" |
| PA-08 API caída con red activa | Panel de depuración, modo "503". El indicador dice "Sin servicio" y la consola muestra los reintentos |
| PA-09 Interrupción durante la sincronización | Panel: modo "Lenta" y "Sincronización completa"; activar el modo avión a mitad. Los metadatos se ven en el panel |
| PA-10 Imágenes sin conexión | Reiniciar sin conexión: las ya vistas se muestran y las otras usan el ícono de respaldo |
| PA-11 Trivia sin conexión | Pendiente |
| PA-12 Los cuatro estados en dos pantallas | Alternar entre Catálogo y Favoritos mientras se provocan los estados (modo avión, "503", "Lenta") |
| PA-13 Sin duplicados tras varias sincronizaciones | Panel: "Guardar referencia", "Completa x3" y "Actualizar". Todo debe decir "igual" |
| PA-14 Navegación fluida durante la sincronización | Panel: modo "Lenta" y sincronización completa, navegando mientras tanto. Mejor en modo profile |
| PA-15 Estados vacíos sin datos | Instalación limpia con modo avión: catálogo y favoritos explican qué hacer. La trivia está pendiente |
| PA-16 Restauración de datos alterados | Panel: renombrar un Pokémon y "Restaurar desde PokeAPI" (una llamada), o "Sincronización completa" |

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
limpia usa unas 11, y cada arranque posterior usa 1. La app lleva la cuenta de las
llamadas de la última hora y frena las automáticas a las 80, para dejar las otras
20 a lo que pida el usuario (ver
[ADR-006](docs/adr/ADR-006-una-sola-puerta-para-las-llamadas-a-pokeapi.md)).

**Herramientas de depuración** (simular la caída de la API, contar registros,
alterar un dato y restaurarlo, ver el contador de llamadas):

```bash
flutter run                                           # modo debug: activas
flutter run --profile --dart-define=DEBUG_TOOLS=true  # modo profile, para medir fluidez
```

En el catálogo aparece un icono de insecto que abre el panel. En una compilación
release normal no se activan.

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
| `go_router` | Navegación con pestañas (catálogo y favoritos) y la pantalla de depuración | Es el router recomendado. Se mantiene en la versión 17 ([ADR-004](docs/adr/ADR-004-versiones-fijadas-de-go-router-y-cached-network-image.md)) |
| `cached_network_image` y `flutter_cache_manager` | Imágenes con caché en disco acotada | Permiten ver offline las imágenes ya descargadas y limitar el espacio. Se mantiene `cached_network_image` en la versión 3 ([ADR-004](docs/adr/ADR-004-versiones-fijadas-de-go-router-y-cached-network-image.md)) |
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
- [ADR-004: mantener go_router 17 y cached_network_image 3](docs/adr/ADR-004-versiones-fijadas-de-go-router-y-cached-network-image.md)
- [ADR-005: el indicador de conexión mira si la API responde](docs/adr/ADR-005-indicador-de-conexion-basado-en-la-api.md)
- [ADR-006: una sola puerta para las llamadas a PokeAPI](docs/adr/ADR-006-una-sola-puerta-para-las-llamadas-a-pokeapi.md)
- [ADR-007: cuándo se sincroniza y cómo se restauran los datos](docs/adr/ADR-007-cuando-sincronizar-y-restaurar-datos.md)
- [ADR-008: estadísticas con el catálogo y búsqueda sobre la base local](docs/adr/ADR-008-estadisticas-y-busqueda-sobre-la-base-local.md)

## 7. Estructura del proyecto

```
lib/
├── app/             arranque, inyección de dependencias, tema, router y pestañas
├── core/            base de datos, red, sincronización, preferencias, errores y widgets comunes
├── features/
│   ├── pokemon/         catálogo, búsqueda y filtros (presentation, domain y data)
│   ├── connectivity/    indicador de conexión (presentation, domain y data)
│   ├── favorites/       favoritos (presentation, domain y data)
│   └── debug_tools/     herramientas de depuración, solo en modo debug
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
- **Favoritos y búsqueda:** el corazón, la pantalla de favoritos, la búsqueda, los
    filtros y el orden son consultas sobre la base local. Funcionan igual con y sin
    conexión.
- **Con red pero con la API caída:** el indicador dice "Sin servicio", nunca "En
  línea". Se siguen mostrando los datos locales y la app vuelve a comprobar la API
  con espera creciente hasta que responda.

## 9. Uso de GraphQL y paginación

- **Endpoint:** `https://graphql.pokeapi.co/v1beta2`, por POST.
- **Consulta:** una sola por página. Pide las especies con `id > cursor`, ordenadas
  por `id`, con su nombre en español e inglés, la generación, los tipos y las seis
  estadísticas base del Pokémon por defecto. En la misma petición pide el total de
  especies.
- **Paginación por cursor,** con páginas de 100. El cursor es el último número de
  Pokédex recibido. Se descartó el desplazamiento (offset) porque puede saltar o
  repetir registros si los datos cambian entre páginas.
- **Solo se piden los campos necesarios.** El catálogo no trae habilidades,
  evoluciones ni movimientos.
- **Sin caché del cliente** (`noCache`): la única fuente de verdad es la base.
- **Tiempo máximo de espera:** 15 segundos.
- **DTO y conversión:** la respuesta se valida y se convierte a un registro de la
  capa data. Si falta un campo obligatorio, es un error de respuesta inválida y
  no se guarda nada.
- **Errores diferenciados:** sin red, tiempo agotado, error de GraphQL, respuesta
  inválida, límite de peticiones (429), cualquier otro estado HTTP no exitoso y
  error de almacenamiento. Son tipos de error propios (`Failure`), y fuera de la
  capa data nadie ve excepciones de `graphql` ni de `http`.
- **Reintentos y límites:** todas las llamadas pasan por una sola puerta
    (`ApiGate`) que reintenta con espera creciente, guarda la pausa cuando
    PokeAPI responde 429 y respeta un presupuesto de llamadas por hora. Ver
    [ADR-006](docs/adr/ADR-006-una-sola-puerta-para-las-llamadas-a-pokeapi.md).

## 10. Estrategia de sincronización

Es unidireccional: remoto a local. PokeAPI es la autoridad del catálogo. Si un dato
del catálogo se altera en la base local, la siguiente comprobación lo restaura con
el de PokeAPI. Los datos del usuario (favoritos y preferencias) no se tocan.

**Tres formas de traer datos, con el mismo mecanismo:**

- `catalog_index`: descarga el catálogo completo, página por página, y se reanuda
  desde el cursor guardado.
- `catalog_verify`: revisa una página por disparo y da la vuelta al terminar.
  Sobrescribe lo local con lo de PokeAPI.
- **Refresco por especie:** una sola llamada que restaura un Pokémon. Lo usará la
  pantalla de detalle. Hoy se usa desde las herramientas de depuración.

**Garantías:**

- Cada página se guarda en una **sola transacción** (Pokémon, tipos y estadísticas),
  junto con el cursor y el estado. Si algo falla, no queda nada a medias.
- **Sin duplicados:** la clave es el número de la Pokédex y se escribe con
  "insertar o actualizar". Los tipos y las estadísticas de un Pokémon se reemplazan
  completos.
- **Una sola ejecución por recurso a la vez** (`SingleFlight`): una segunda
  petición recibe el resultado de la primera. Vale también para el refresco de una
  misma especie.
- **La sincronización nunca lanza errores a la pantalla:** guarda el resultado en
  `sync_metadata` y la pantalla lo observa.
- **Recuperación:** al abrir la app, un recurso que quedó en `syncing` se marca
  como `interrupted` y se continúa desde su cursor.
- **Reintentos con espera creciente,** pausa guardada tras un 429 y presupuesto de
  80 llamadas por hora para lo automático (ver
  [ADR-006](docs/adr/ADR-006-una-sola-puerta-para-las-llamadas-a-pokeapi.md)).

**Cuándo se sincroniza:**

| Disparador | Prioridad | Estado |
|---|---|---|
| Al abrir la app, después del primer cuadro | Fondo | Hecho |
| Al recuperar la red (con espera de 2 segundos) | Fondo | Hecho |
| Cada 15 minutos con la app abierta, una página | Fondo | Hecho |
| Mientras el servicio esté caído: a los 30 s, 1, 2 y 4 min, y luego cada 5 min | Fondo | Hecho |
| Botón "Sincronizar ahora" y "Reintentar" | Usuario | Hecho |
| Descarga del catálogo cuando no hay datos o está incompleto | Usuario | Hecho |
| Al abrir el detalle de un Pokémon | Usuario | La capacidad existe. Falta la pantalla |

Decisiones de persistencia y sincronización pedidas por el enunciado:

| Código | Decisión |
|---|---|
| PS-01 | Modelo de datos en [Persistencia local](#11-persistencia-local) y en `docs/arquitectura.md` |
| PS-02 | La descarga completa se hace en segundo plano. La app no la espera para abrirse |
| PS-03 | Los datos se consideran al día si se actualizaron hace menos de 1 hora (valor provisional). Pasado ese plazo, el indicador avisa que pueden estar desactualizados |
| PS-04 | Disparadores de la tabla anterior |
| PS-05 | La clave de cada Pokémon es su número de Pokédex |
| PS-06 | "Insertar o actualizar" sobre esa clave |
| PS-07 | El cursor se guarda con cada página, y se continúa desde él |
| PS-08 | Sprites en caché de disco: hasta 1100 archivos, y se limpian pasados 90 días sin usarse |
| PS-09 | Tabla `sync_metadata`, que el indicador muestra en su hoja de detalles |
| PS-10 | Estados `failed` e `interrupted` guardados, reintentos con espera creciente, pausa tras un 429 y migraciones del esquema (hoy versión 4) |
| PS-11 | Favoritos y preferencias no tienen relación con las tablas del catálogo, y una prueba comprueba que ninguna sincronización las modifica |
| PS-12 | La verificación y el refresco por especie sobrescriben los datos locales con los de PokeAPI. Cada ciclo revisa una página, y la comprobación completa está en las herramientas de depuración |

## 11. Persistencia local

SQLite con Drift, en una sola base (`AppDatabase`), versión 4 del esquema, con ocho
tablas:

| Tabla | Contenido | Clave |
|---|---|---|
| `pokemon` | Nombre en inglés, nombre en español (puede faltar), generación, total de estadísticas base (vacío hasta que llegan las seis) y fecha de sincronización | `id` (número de Pokédex) |
| `type` | Tipos (fuego, agua...) | `id` |
| `pokemon_type` | Tipos de cada Pokémon, con la posición (1 o 2) | (`pokemon_id`, `slot`) |
| `pokemon_stat` | Las seis estadísticas base de cada Pokémon | (`pokemon_id`, `stat_id`) |
| `favorite` | Favoritos del usuario | `pokemon_id` |
| `sync_metadata` | Estado de cada recurso: cursor, total remoto, fechas, fallos, último error y pausa por límite de peticiones | `resource_key` |
| `user_preference` | Preferencias, como JSON en texto. Hoy guarda la búsqueda, los filtros y el orden del catálogo | `key` |
| `api_call` | Cada llamada real a PokeAPI de la última hora, para el presupuesto | `id` |

- **Índices:** por nombre, por (generación, id), por (tipo, Pokémon) y por total
  base. Un test con `EXPLAIN QUERY PLAN` comprueba que se usan los de tipo,
  generación y total. La búsqueda por texto recorre la tabla (unas 1025 filas) y
  una prueba mide que tarda menos de 100 ms. Ver
  [ADR-008](docs/adr/ADR-008-estadisticas-y-busqueda-sobre-la-base-local.md).
- Claves foráneas activadas al abrir la base. `pokemon_type` y `pokemon_stat`
  borran en cascada.
- `favorite` y `user_preference` no tienen clave foránea hacia el catálogo.
- El nombre en español puede faltar: la interfaz cae al inglés.
- **Migraciones:** v2 agregó la pausa por límite de peticiones, v3 el registro de
  llamadas y v4 las estadísticas con el total (y deja el catálogo marcado para
  descargarse otra vez, una sola vez). Un test migra desde cada versión anterior
  y comprueba el esquema.

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

**Indicador:** un chip en la barra superior de todas las pantallas principales
(`IndicatorAppBar`; un test falla si una pantalla no lo usa), con ícono y una
palabra, que se distingue sin depender del color. Al tocarlo abre una hoja con la
explicación del estado, el origen de los datos (siempre "guardados en este
dispositivo"), su vigencia (nunca sincronizados, actualizados desde PokeAPI o
pueden estar desactualizados), la última sincronización, el progreso del catálogo,
el último error traducido y el botón "Sincronizar ahora". Las razones del diseño
están en [ADR-005](docs/adr/ADR-005-indicador-de-conexion-basado-en-la-api.md).

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

- **Catálogo** con número, nombre, imagen y tipos, con carga progresiva: la lista
  pide más datos a la base al acercarse al final, y nunca construye el catálogo
  entero.
- **Búsqueda por nombre** (español e inglés, con espera de 400 ms al teclear),
  **filtros** por tipo y generación y **orden** por número, nombre o total base, en
  ambos sentidos. Se guardan entre sesiones y funcionan sin conexión. Si el
  catálogo local está incompleto, la pantalla lo avisa.
- **Favoritos:** corazón en cada tarjeta, pantalla de favoritos y funcionamiento
  sin conexión. El guardado muestra su tiempo en la consola en modo depuración.
- **Navegación con pestañas** (Catálogo y Favoritos), que conserva el desplazamiento
  de cada una.
- **Estados** de carga, contenido, vacío, sin resultados y error, con "Reintentar".
- **Funcionamiento offline,** también después de reiniciar.
- **Indicador global de conectividad** con hoja de detalles, en todas las pantallas
  principales.
- **Sincronización automática** al abrir la app, al recuperar la red y de forma
  periódica; manual con "Sincronizar ahora". Con reintentos, pausa tras un 429 y
  presupuesto de llamadas.
- **Herramientas de depuración** (solo en modo debug): simulación de la API caída,
  lenta o con límite de peticiones; contador de llamadas; conteo de registros por
  tabla con referencia; editor de un Pokémon y restauración desde PokeAPI.
- **Español e inglés** en todo lo hecho hasta ahora (los nombres de los tipos y de
  las generaciones se traducen).
- **Tema claro y oscuro** (sigue al sistema).
- **Accesibilidad:** cada tarjeta se lee como una frase, el estado de conexión y el
  corazón no dependen del color, los objetivos táctiles miden al menos 48 dp y hay
  pruebas con el texto al 200%.

## 14. Limitaciones conocidas

**Todavía no implementado:**

- Detalle del Pokémon, trivia, animaciones y tarjeta para compartir.
- Las capturas de pantalla (ENT-11) y las pruebas de rendimiento con Flutter
  DevTools (RNF-REN-05) se agregarán con la entrega final.
- El contraste de colores no se ha medido todavía (RNF-ACC-02).
- El refresco al abrir el detalle existe como capacidad, pero falta la pantalla.

**Limitaciones de la solución actual:**

- **iOS no se ha compilado ni probado.** Se mantiene la carpeta `ios/` que genera
  Flutter, pero no hay un Mac disponible.
- **`go_router` (17.5) y `cached_network_image` (3.4.1) están en versiones
  anteriores a las últimas** (hay un 18 y un 4). Ver
  [ADR-004](docs/adr/ADR-004-versiones-fijadas-de-go-router-y-cached-network-image.md).
- **La búsqueda no ignora las tildes** y no usa índice: recorre la tabla. Con unas
  1025 filas tarda menos de 100 ms.
- **No hay un filtro de región propio:** cada generación se muestra con el nombre
  de su región. Tampoco hay filtro por habilidad.
- Si PokeAPI elimina una especie, la app no la borra de la base.
- La verificación revisa una página cada 15 minutos, así que cubrir las 1025
  especies lleva unas 3 horas con la app abierta. Un dato alterado se restaura
  antes si se refresca esa especie.
- **El contador de llamadas es del dispositivo y la cuota de PokeAPI es por IP.** Si
  varios dispositivos comparten red, el límite real puede llegar antes de lo que
  cuenta la app. Además, con llamadas simultáneas se puede pasar por una o dos.
- Si la red no cambia pero el acceso a Internet vuelve (por ejemplo, un Wi-Fi con
  portal cautivo), no hay un evento que lo detecte: el indicador se actualiza con
  la siguiente llamada.
- El indicador tarda unos 2 segundos en mostrar un corte de red. Es intencional.
- El plazo de una hora para considerar los datos "al día" es provisional.
- Tras actualizar a la versión 4 del esquema, el catálogo se descarga otra vez una
  sola vez, y mientras tanto el orden por total base deja al final a los Pokémon
  sin estadísticas.
- La regla de capas se comprueba con un test que mira imports directos. No detecta
  que presentación llegue a la capa data pasando por `app/di`.
- Las herramientas de depuración no están traducidas a propósito.

## 15. Pruebas

Más de 300 pruebas automáticas, todas con `flutter test`. No usan Internet ni un
dispositivo: simulan PokeAPI con un cliente HTTP falso y usan una base SQLite en
memoria (o en un archivo temporal).

| Qué se prueba | Dónde |
|---|---|
| Regla de dependencia entre capas, aislamiento de las herramientas de depuración e indicador en toda pantalla principal | `test/architecture/` |
| Base de datos, índices, migraciones desde cada versión, upsert y transacciones | `test/core/database/`, `test/features/pokemon/pokemon_local_data_source_test.dart` |
| Cliente GraphQL, traducción de errores y estadísticas | `test/features/pokemon/pokemon_remote_data_source_test.dart`, `pokemon_stats_*_test.dart` |
| Sincronización: páginas, reanudación, concurrencia, sin duplicados, refresco por especie y datos del usuario intactos | `test/features/pokemon/catalog_sync*_test.dart`, `user_data_untouched_test.dart`, `test/core/sync/` |
| Reintentos, pausa tras un 429 y presupuesto de llamadas | `test/core/sync/api_gate*_test.dart`, `call_budget_test.dart` |
| Verificación periódica y reconexión | `test/app/` |
| Búsqueda, filtros, orden y su persistencia | `test/features/pokemon/pokemon_catalog_query_test.dart`, `catalog_filters*_test.dart`, `catalog_toolbar_test.dart` |
| Favoritos | `test/features/favorites/` |
| Funcionamiento offline tras reiniciar | `test/features/pokemon/offline_restart_test.dart` |
| Pantalla del catálogo y estados | `test/features/pokemon/catalog_state_test.dart`, `catalog_page_test.dart` |
| Conectividad e indicador | `test/features/connectivity/` |
| Herramientas de depuración | `test/features/debug_tools/` |
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
  aplicación en un teléfono real, corregí los errores que fueron apareciendo, y aprobé las decisiones antes de aplicarlas.
- Los datos del esquema de PokeAPI (nombres de campos, total de especies, ids de
  idioma y estadísticas base) los verifiqué en su consola GraphQL y no se tomaron
  de memoria. Las versiones de los paquetes se comprobaron en sus registros de
  cambios.
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