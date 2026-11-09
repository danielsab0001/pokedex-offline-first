# ADR-001: Organizar el código por funcionalidades, con capas dentro de cada una

## Contexto

La app es una Pokédex que irá creciendo: catálogo, detalle, favoritos, búsqueda,
trivia. El enunciado pide una arquitectura limpia, organizada por funcionalidades,
y el proyecto lo desarrolla una sola persona que tiene que poder explicarlo todo.

## Problema

¿Cómo ordenar el código para que agregar una funcionalidad nueva no obligue a
tocar todas las demás, y para que se pueda comprobar que las capas no se
mezclan?

## Opciones consideradas

- **Carpetas por capa en toda la app** (`presentation/`, `domain/`, `data/`
  globales): simple al principio, pero mezcla cosas que no tienen relación entre
  sí y se vuelve difícil de recorrer cuando crece.
- **Por funcionalidad, con tres capas dentro de cada una:** cada funcionalidad
  se entiende y se cambia por separado.
- **BLoC en lugar de Riverpod** para el estado: es válido, pero pide más piezas
  (eventos, estados, bloques) de las que este proyecto necesita.

## Decisión

Se eligió la segunda opción.

- `features/pokemon`, `features/favorites` y `features/connectivity`, cada una
  con `presentation`, `domain` y `data`.
- `app/` arranca la aplicación y conecta las piezas. `core/` solo guarda
  infraestructura compartida (base de datos, red, sincronización, errores).
- El dominio es mínimo: entidades, contratos de repositorio y errores.
  Los casos de uso se crearán solo cuando haya una regla de negocio real.
- El estado y la inyección de dependencias usan Riverpod, sin generación de
  código. Los providers que crean las implementaciones viven en `app/di`.
- Un test automático revisa los imports: el dominio no puede importar Flutter ni
  infraestructura, y presentación no puede importar la capa de datos.

## Consecuencias

- Cada funcionalidad se puede entender y probar por separado.
- Si alguien rompe la regla de dependencia, el test falla.
- El test solo mira imports directos. Presentación llega a los datos a través de
  `app/di`, y eso el test no lo detecta: es una regla de convención.
- La funcionalidad de conectividad lee el estado de sincronización del catálogo.
  Hoy es lo único que se sincroniza; si se sincronizara algo más, habría que
  generalizar ese contrato.
- `core/` puede convertirse en un cajón de sastre si no se vigila.