# ADR-005: El indicador de conexión mira si la API responde, no solo si hay red

## Contexto

El enunciado pide un indicador global que no diga "en línea" solo porque haya
Wi-Fi. Un Wi-Fi sin salida a Internet, o una API caída, no son "en línea".

## Problema

¿Cómo decidir qué estado mostrar sin mentirle al usuario y sin que parpadee?

## Opciones consideradas

- **Solo `connectivity_plus`:** dice si hay red, pero no si PokeAPI responde.
- **Hacer una llamada de prueba cada cierto tiempo:** gasta de las 100 llamadas
  por hora.
- **Usar las llamadas reales que la app ya hace, junto con la red del
  dispositivo.**

## Decisión

La tercera opción.

- Dos señales: la red del dispositivo y el resultado de la última llamada real a
  GraphQL. Sin una llamada exitosa, nunca se muestra "En línea".
- Dos dimensiones separadas: la disponibilidad del servicio y la actividad de
  sincronización. Así existe "en línea y sincronizando" y no existe "sin
  conexión y con la API accesible".
- Prioridad al mostrar: Sin conexión, Sin servicio, Sincronizando, Verificando y
  En línea.
- Un corte de red tarda 2 segundos en mostrarse, para que una pérdida breve no
  haga parpadear el indicador.
- La hoja de detalles separa tres cosas: la conexión, que los datos siempre se
  leen de este dispositivo, y su vigencia (nunca sincronizados, al día, o
  "pueden estar desactualizados" pasada una hora; ese plazo es provisional).

## Consecuencias

- No gasta llamadas extra.
- Si el Wi-Fi no cambia pero el acceso a Internet vuelve (un portal cautivo, por
  ejemplo), el indicador se corrige con la siguiente llamada.
- El estado solo se entera de la API cuando hay llamadas. Por eso existen las
  verificaciones periódicas (ADR-007).