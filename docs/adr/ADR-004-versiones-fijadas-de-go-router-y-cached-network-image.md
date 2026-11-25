# ADR-004: Mantener go_router 17 y cached_network_image 3

## Contexto

`go_router` tiene una versión 18 y `cached_network_image` una versión 4. Las dos
son cambios mayores: dejan de usar el Material que trae Flutter y pasan a un
paquete aparte, `material_ui`. La app usa el Material de Flutter.

## Problema

¿Actualizar estos dos paquetes o quedarse donde están?

## Opciones consideradas

- **Actualizar los dos y pasar toda la app a `material_ui`:** es el camino a
  futuro, pero es un trabajo aparte que no aporta nada de lo que pide el
  enunciado.
- **Actualizar solo uno:** deja la app con los dos Material mezclados, y eso
  puede dar errores de tipos.
- **Quedarse en las versiones actuales.**

## Decisión

Quedarse en `go_router ^17.5.0` y `cached_network_image ^3.4.1`. El `^` impide
que `pub` salte solo a la versión mayor siguiente. Se comprobó que estas
versiones resuelven y compilan con Flutter 3.47.8, que también está fijado
(`>=3.47.0 <3.48.0`) y no se actualiza antes de la entrega.

## Consecuencias

- No se reciben las novedades de las versiones nuevas, y con el tiempo la
  versión vieja podría dejar de recibir correcciones.
- Pasar a las versiones nuevas sería una tarea aparte: migrar toda la app a
  `material_ui`.
- Los cambios de las versiones nuevas se leyeron en sus registros de cambios. La
  migración no se probó en este proyecto.