;***************************************************************************
; Programa main.asm (PIC16F628A)	Fecha de inicio de proyecto: 28-10-2023	
; Autor: Angel Valentin Altieri												
; Programa que en base a un circuito del PIC16F628A con los LEDS, RB0,RB1,RB2 y RB3, controla
; los mismos
; - Velocidad del Reloj: 4MHz		- Tipo de Reloj: Interno				
; - Perro guardián: OFF			- Protección de código: OFF											
;***************************************************************************
	
	 __CONFIG 3F10
	 LIST		P=16F628A
	 INCLUDE	<P16F628A.INC>

;***************************************************************************
; Declaracion de variables													
;***************************************************************************
	CBLOCK 0x20
		
    CONT1       	;0X20 Registros para los distintos retardos
	CONT2   		;0X21
	CONT3   		;0X22	
	CONT4			;0X23	
	CONT5			;0X24	

	ENDC

	#DEFINE BANCO_0 BCF STATUS,RP0	; Definimos macros para cambiar de bancos 
	#DEFINE BANCO_1	BSF STATUS,RP0

	ORG 0x00

	CALL CONFIGURAR_PUERTOS	 ; Subrutina que configura los puertos como salida y deja los LEDS OFF

	GOTO INICIO
	
INICIO	;Inicio del programa
	
	;Punto 1
	CALL ENCENDER_LEDS				;enciende los leds RB0,RB1,RB2 y RB3
	CALL DELAY_5S					;genera delay de 5s para poder verlo
	
	;Punto 2
	CALL ENCENDER_Y_APAGAR_1S		;enciende los leds con demora de 1s entre ellos
	CALL DELAY_5S					;genera delay de 5s para poder verlo
	
	;Punto 3
	CALL ENCENDER_Y_APAGAR_1S_500MS ;enciende los leds 1segundo prendidos y 500ms apagados
	CALL DELAY_5S					;genera delay de 5s para poder verlo
	
	;Punto 4
	CALL ENCENDER_UNO_X_UNO_500MS 	;enciende los leds desde RB0 hasta RB3 con demora de 500ms
	CALL DELAY_5S            		;genera delay de 5s para poder verlo

BUCLE
	CALL ENCENDER_Y_APAGAR_UPU_500MS;enciende los leds desde RB0 hasta RB3 y los apaga desde RB0 hasta RB3 con 500ms de demora
	GOTO BUCLE						;Repetimos el bucle indefinidamente

;***************************************************************************
; Subrutina que configura los puertos													
;***************************************************************************
CONFIGURAR_PUERTOS
	BANCO_1				    ; Vamos al banco 1 para manipular el TRISB
	MOVLW	B'11110000'		; Cargamos en W con 0 los valores que querramos como salida
	MOVWF	TRISB			; Se lo asignamos TRISB

	BANCO_0				    ; Volvemos al banco 0 para manipular PORTB
	CLRF PORTB				; Dejamos los LEDS apagados por defecto con 0

	RETURN

;***************************************************************************
; Subrutina de LEDS												
;***************************************************************************
ENCENDER_LEDS
	BANCO_0				; Vamos al banco 0 para manipular los puertos
	MOVLW	B'00001111' ; Ponemos en 1 los puertos RB0,RB1,RB2 y RB3
	MOVWF	PORTB		; Se lo asignamos a PORTB para encenderlos
	RETURN

APAGAR_LEDS
	BANCO_0				; Vamos al banco 0 para manipular los puertos
	MOVLW	B'00000000' ; Ponemos en 0 los puertos RB0,RB1,RB2 y RB3
	MOVWF	PORTB		; Se lo asignamos a PORTB para apagarlos
	RETURN

ENCENDER_Y_APAGAR_1S
		
		CALL ENCENDER_LEDS	; Encendemos todos los LEDS 
		
		CALL DELAY_1S		; Generamos un delay de 1 segundo
		
		CALL APAGAR_LEDS	; Apagamos todos los LEDS
		
		CALL DELAY_1S		; Generamos un delay de 1 segundo
		
		RETURN

ENCENDER_Y_APAGAR_1S_500MS

		CALL ENCENDER_LEDS ; Encendemos todos los LEDS 
		
		CALL DELAY_1S	   ; Generamos un delay de 1 segundo
		
		CALL APAGAR_LEDS   ; Apagamos todos los LEDS

		CALL DELAY_250MS
		CALL DELAY_250MS   ; Generamos un delay de 500MS
		
		RETURN

ENCENDER_UNO_X_UNO_500MS
		
		BANCO_0				; Vamos al banco 0 para manipular los puertos
		MOVLW B'00000001'	; Prendemos primero el LED RB0
		MOVWF PORTB

		CALL DELAY_250MS	; Esperamos 500ms
		CALL DELAY_250MS

		MOVLW B'00000011'	; Prendemos el LED RB1
		MOVWF PORTB	

		CALL DELAY_250MS	; Esperamos 500ms
		CALL DELAY_250MS

		MOVLW B'00000111'	; Prendemos el LED RB2
		MOVWF PORTB

		CALL DELAY_250MS	; Esperamos 500ms
		CALL DELAY_250MS

		MOVLW B'00001111'	; Prendemos el LED RB3
		MOVWF PORTB

		CALL DELAY_250MS	; Esperamos 500ms
		CALL DELAY_250MS
		
		RETURN

ENCENDER_Y_APAGAR_UPU_500MS	; Encender y apagar uno por uno con demora de 500ms
		; Comenzamos prendiendolos
		BANCO_0				; Vamos al banco 0 para manipular los puertos
		MOVLW B'00000001'	; Prendemos primero el LED RB0
		MOVWF PORTB

		CALL DELAY_250MS	; Esperamos 500ms
		CALL DELAY_250MS

		MOVLW B'00000011'	; Prendemos el LED RB1
		MOVWF PORTB	

		CALL DELAY_250MS	; Esperamos 500ms
		CALL DELAY_250MS

		MOVLW B'00000111'	; Prendemos el LED RB2
		MOVWF PORTB

		CALL DELAY_250MS	; Esperamos 500ms
		CALL DELAY_250MS

		MOVLW B'00001111'	; Prendemos el LED RB3
		MOVWF PORTB

		CALL DELAY_250MS	; Esperamos 500ms
		CALL DELAY_250MS
		
		; Una vez prendidos, empezamos a apagarlos 
		MOVLW B'00000111'	; Apagamos primero el LED RB3
		MOVWF PORTB

		CALL DELAY_250MS	; Esperamos 500ms
		CALL DELAY_250MS

		MOVLW B'00000011'	; Apagamos el LED RB2
		MOVWF PORTB	

		CALL DELAY_250MS	; Esperamos 500ms
		CALL DELAY_250MS

		MOVLW B'00000001'	; Apagamos el LED RB1
		MOVWF PORTB

		CALL DELAY_250MS	; Esperamos 500ms
		CALL DELAY_250MS

		MOVLW B'00000000'	; Apagamos el LED RB0
		MOVWF PORTB

		CALL DELAY_250MS	; Esperamos 500ms
		CALL DELAY_250MS
		
		RETURN


;***************************************************************************
; Subrutinas de demoras											
;***************************************************************************
DELAY_1MS
	MOVLW	D'250'		; Cargar 250 en W
	MOVWF	CONT1		; Lo asigno a CONT1
LOOP	
	NOP					; No hace nada, consume 4 ciclos reloj = 1 ciclo de instruccion
	DECFSZ	CONT1,F		; Decrementa CONT1, cuando sea 0 salta
	GOTO	LOOP		; Regresa a LOOP
	RETURN

DELAY_250MS
	MOVLW	D'250'		; Cargamos 250 en W
	MOVWF	CONT2		; Lo aisgno a CONT1
LOOP_2	
	CALL	DELAY_1MS	; Llamamos a DELAY_1MS 
	DECFSZ	CONT2,F		; Se decrementa CONT2, cuando sea 0 salta    Se ejecutará 250 * 1ms = 250ms
	GOTO	LOOP_2		; Regresa a LOOP_2
	RETURN

DELAY_1S
	MOVLW	D'4'		; Cargamos 4 en W
	MOVWF	CONT3		; Lo asigno en CONT3
LOOP_3
	CALL	DELAY_250MS	; Llamamos a DELAY_250MS
	DECFSZ	CONT3,F		; Se decrementa CONT3, cuando sea 0 salta    Se ejecutará 4 * 250ms = 1s
	GOTO	LOOP_3	    ; Regresa a LOOP_3
	RETURN

DELAY_5S		
		MOVLW D'5'		; Cargamos 5 en W		
		MOVWF CONT5		; Lo asignamos en CONT4
LOOP_4					
		CALL DELAY_1S	; Llamamos a DELAY_1S		
		DECFSZ CONT5,F	; Se decrementa CONT4, cuando sea 0 salta    Se ejecutará 5 * 1s = 1s	
		GOTO LOOP_4		; Regresa a LOOP_4
		RETURN
		END
;***************************************************************************
; Fin											
;***************************************************************************