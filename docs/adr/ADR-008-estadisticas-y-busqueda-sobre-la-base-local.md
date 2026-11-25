# ADR-008: Guardar las estadísticas con el catálogo y buscar sobre la base local

## Contexto

Hay que ordenar por algo que sale de las estadísticas (el total base) y buscar y
filtrar sin conexión. El detalle del Pokémon necesitará esas mismas estadísticas.

## Problema

¿De dónde sale el total para ordenar, y cómo se busca rápido sin conexión?

## Opciones consideradas

- **Sumar las seis estadísticas al ordenar:** no se puede indexar.
- **Guardar solo el total:** el detalle tendría que pedir las seis por separado,
  y las dos fuentes podrían quedar desfasadas.
- **Guardar las seis estadísticas y el total.**
- **Para buscar:** una columna extra con el nombre sin tildes, o buscar
  directamente en los nombres.

## Decisión

- El catálogo ya trae las seis estadísticas y se guardan en `pokemon_stat`. El
  total se calcula en la misma transacción y se guarda en
  `pokemon.base_stat_total`, con un índice. Es una copia a propósito, para
  ordenar rápido. Si faltan estadísticas, el total queda vacío y ese Pokémon se
  ordena al final.
- La migración a la versión 4 del esquema no calcula nada a mano: deja el
  catálogo marcado para descargarse otra vez, una sola vez (unas 11 llamadas).
- La búsqueda es por nombre, en español e inglés, sin distinguir mayúsculas, y
  `%` y `_` se buscan como texto. No usa índice (con el comodín al inicio no
  sirve) y recorre unas 1025 filas: una prueba mide menos de 100 ms.
- La búsqueda no ignora las tildes: "flabebe" no encuentra "Flabébé".
- Los filtros por tipo y por generación, y el orden por número, nombre o total
  (en ambos sentidos), se resuelven en SQL. La búsqueda, los filtros y el orden
  se guardan como preferencia y se recuperan al abrir la app.
- La región no tiene filtro propio: cada generación se muestra con el nombre de
  su región.

## Consecuencias

- Todo funciona igual con y sin conexión.
- El total es un dato repetido. Si alguien alterara una estadística a mano, el
  total quedaría desfasado hasta la próxima sincronización, que lo reescribe.
- Ignorar las tildes exigiría otra columna derivada, y por simplicidad no se hizo.