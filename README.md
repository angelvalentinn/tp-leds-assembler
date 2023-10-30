# TP LEDS - Assembler
*Este repositorio contiene un programa hecho en Assembler para un Trabajo Práctico de Arquitectura de Computadoras. 
  Se trata de programar los LEDS del microcontrolador PIC16F628A en los terminales RB0,RB1,RB2 y RB3. El código se encuentra en el archivo .asm y el diagrama de flujo en el png
  Esta construído en Assembler con la ide MPLAB*

  
El funcionamiento es el siguiente; primero se encienden todos los leds, luego se encieden y se apagan cada 1 segundo. Despues lo mismo pero están 1 segundo prendidos y 500ms apagados. Luego se encienden todos a partir desde el RB0 hasta el RB3, es decir, uno por uno con una demora de 500ms entre ellos. Por último lo mismo que lo anterior pero se deben comenzar a apagase a partir desde el RB3 hasta RB0.
