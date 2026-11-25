# ADR-007: Cuándo se sincroniza y cómo se restauran los datos alterados

## Contexto

El enunciado dice que PokeAPI manda: si un dato del catálogo se cambia en la base
local, la app debe detectarlo y restaurarlo. Debe comprobarlo al iniciar, al
reconectar, al abrir el detalle y de forma periódica. Los datos del usuario no se
tocan.

## Problema

¿Cómo cumplirlo sin pedir todo el catálogo cada vez (unas 11 llamadas)?

## Opciones consideradas

- **Comparar campo por campo contra PokeAPI:** pide los mismos datos de todos
  modos y añade código.
- **Descargar todo en cada comprobación:** gasta unas 11 llamadas cada vez.
- **Sobrescribir lo local con lo que llega, en lotes pequeños.**

## Decisión

La tercera opción.

- Cada comprobación revisa una página de 100 Pokémon y escribe el valor de
  PokeAPI sobre el local. Cualquier diferencia queda corregida.
- Se dispara al abrir la app, al volver la red, cada 15 minutos con la app
  abierta y a mano. Sin red, la comprobación periódica no hace nada.
- Si el servicio está caído, se comprueba otra vez a los 30 segundos y luego a
  1, 2 y 4 minutos, y después cada 5, hasta que responda. Respeta la pausa del
  429 y el presupuesto de llamadas.
- Al abrir el detalle se refresca solo esa especie, con una llamada. La pantalla
  de detalle llega más adelante. La capacidad ya existe y hoy se usa desde las
  herramientas de depuración ("Restaurar desde PokeAPI").
- Los favoritos y las preferencias están en tablas que ninguna sincronización
  escribe. Una prueba lo comprueba en siete casos, entre ellos un fallo de red y
  un límite de peticiones.

## Consecuencias

- Un dato alterado en una página que todavía no se revisó tarda en restaurarse:
  con una página cada 15 minutos, recorrer todo el catálogo lleva unas 3 horas.
  El refresco por especie lo restaura al instante.
- Si PokeAPI elimina una especie, la app no la borra de la base.
- La comprobación completa (unas 11 llamadas) existe solo como herramienta de
  depuración.