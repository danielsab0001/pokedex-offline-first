# ADR-003: Sincronizar el catálogo por páginas, con cursor y una transacción por página

## Contexto

PokeAPI tiene 1025 especies y un límite de 100 llamadas por hora por IP. La app
tiene que abrir de inmediato, descargar el catálogo en segundo plano, no
duplicar registros y no perder lo ya descargado si se corta la conexión.

## Problema

¿Cómo traer el catálogo completo sin bloquear la interfaz, sin duplicados, y de
forma que una interrupción se pueda retomar?

## Opciones consideradas

- **Una sola consulta con todo:** una prueba devolvió las 1025 filas, pero esa
  prueba solo pidió los números. Con nombres y tipos la respuesta sería grande, y
  un corte obligaría a empezar de cero.
- **Paginación con desplazamiento (offset):** si los datos cambian entre páginas
  se pueden saltar o repetir registros, y el servidor recorre filas de más.
- **Paginación por cursor:** cada página pide las especies con número mayor que
  el último recibido.

## Decisión

Paginación por cursor, con páginas de 100, y guardado página por página.

- Cada petición trae la página y el total de especies a la vez. Una instalación
  limpia gasta unas 11 llamadas, y cada arranque posterior gasta una.
- Cada página se guarda en **una sola transacción** junto con el cursor
  siguiente. Si algo falla, no queda nada a medias, y el cursor apunta a la
  última página completa.
- Hay dos recursos con el mismo mecanismo: `catalog_index` descarga el catálogo
  completo y se reanuda desde el cursor; `catalog_verify` revisa una página por
  vez y da la vuelta al terminar. Esa revisión sobrescribe los datos locales con
  los de PokeAPI, y por eso corrige cualquier cambio hecho a mano en la base.
- Una pieza (`SingleFlight`) impide que dos sincronizaciones del mismo recurso
  corran a la vez: la segunda recibe el resultado de la primera.
- Los errores de red, tiempo agotado, errores de GraphQL, respuestas inválidas y
  límite de peticiones se traducen a tipos de error propios. La sincronización
  nunca lanza errores a la pantalla: deja el resultado en `sync_metadata` y la
  pantalla lo observa.
- El cliente GraphQL no guarda caché (`noCache`) y espera como máximo 15 segundos.
- Se sincroniza al abrir la app (después del primer cuadro), al recuperar la red
  y al pulsar "Sincronizar ahora".

## Consecuencias

- Una descarga interrumpida se retoma donde quedó.
- Mientras no existan reintentos con espera creciente, un fallo detiene la
  descarga hasta el siguiente disparo.
- La revisión recorre el catálogo de a una página por disparo, así que tarda
  varios arranques en cubrirlo todo.
- Si PokeAPI elimina una especie, la app no la borra: esa limpieza queda
  pendiente.
- Todavía no hay sincronización periódica ni al abrir el detalle de un Pokémon.