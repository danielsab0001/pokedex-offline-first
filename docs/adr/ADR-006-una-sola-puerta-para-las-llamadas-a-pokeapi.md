# ADR-006: Todas las llamadas a PokeAPI pasan por una sola puerta

## Contexto

PokeAPI permite 100 llamadas por hora por IP y puede bloquear a quien se pase.
Llaman varias partes de la app: el arranque, la reconexión, la verificación
periódica, el botón de sincronizar, el refresco de un Pokémon y las herramientas
de demostración.

## Problema

¿Cómo evitar que cada parte tenga su propia idea de cuándo reintentar y cuánto
gastar?

## Opciones consideradas

- **Cada pieza maneja sus reintentos y límites:** es simple, pero se pisan entre
  sí y es fácil pasarse.
- **Una sola puerta por la que pasa todo.**

## Decisión

Una sola puerta (`ApiGate`).

- **Reintentos con espera creciente:** hasta 4 intentos, con esperas de 2, 4 y 8
  segundos (con una variación al azar). Solo cuando tiene sentido: tiempo
  agotado y errores del servidor (5xx). Un corte de red no se reintenta.
- **Pausa por "demasiadas peticiones" (429):** se guarda en la base de datos la
  espera que indique el servidor, o 15 minutos si no indica nada. Sobrevive a
  reiniciar la app, y mientras dure no sale ninguna llamada.
- **Presupuesto por hora:** cada llamada real queda registrada en la base. Las
  acciones automáticas se frenan a las 80 y las otras 20 quedan para lo que pide
  el usuario. Una acción automática sin presupuesto no hace nada y no marca
  error. Una del usuario sin presupuesto sí avisa.
- **Simulador para las demostraciones**, solo en modo depuración: falla las
  peticiones antes de que lleguen al contador, así que lo simulado no gasta
  cuota.

## Consecuencias

- Hay un solo lugar donde cambiar las reglas, y una prueba para cada una.
- El contador es del dispositivo, pero la cuota es por IP: si varios comparten
  red, el límite real puede llegar antes de lo que cuenta la app.
- La revisión del presupuesto y la llamada no son una sola operación: con
  llamadas simultáneas se puede pasar por una o dos.