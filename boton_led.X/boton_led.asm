	LIST	P=16F887
	RADIX	HEX
	#INCLUDE <P16F887.INC>
	
	
; CONFIG1
; __config 0xFFF9
 __CONFIG _CONFIG1, _FOSC_XT & _WDTE_ON & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _IESO_ON & _FCMEN_ON & _LVP_ON
; CONFIG2
; __config 0xFFFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF
	
	ORG 	0
	BSF	STATUS,RP0
	MOVLW	0b00000001
	MOVWF	TRISA	    ;Configuro puerto A pin 0 como entrada y demas como salida
	MOVLW	0x00
	MOVWF	TRISB
	MOVWF	TRISC
	MOVWF	TRISD	    ;Configuro puerto B,C,D como salidas	
	BSF	STATUS,RP1
	CLRF	ANSEL	    ;asigno todas las salidas y entradas como digitales
	CLRF	ANSELH
	BCF	STATUS,RP1
	BCF	STATUS,RP0
	MOVWF	PORTB
	MOVWF	PORTC
	MOVWF	PORTD
	CLRF	PORTA
	GOTO	APAGAR

INICIO:	BTFSC	PORTA,0	    ;pregunta si hay pulso bajo en RA0
	GOTO	INICIO	    ;si no detecta un pulso en alto regresa a preguntar
	BSF	PORTB,0	    ;si detecta pulso en alto manda un pulso a salida RB0   	
	GOTO 	APAGAR	    ;
APAGAR:	BTFSS	PORTA,0	    ;Pregunta por pulso alto en RA0
	GOTO	APAGAR	    ;si no detecta pulso bajo regresa a preguntar
	BCF	PORTB,0	    ;si detecta pulso bajo apaga led
	GOTO	INICIO	    ;
	
	END