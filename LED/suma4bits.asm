    LIST P=16F887
    #INCLUDE <P16F887.INC>
    

; CONFIG1
; __config 0xFFF1
 __CONFIG _CONFIG1, _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF & _LVP_OFF
; CONFIG2
; __config 0xFFFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF

    CBLOCK 0x20
	c1        
	c2      
	c3      
	numero1
	resultado
    ENDC
    
	ORG	   0
	GOTO	   INICIO

	ORG        5
DELAY:
	MOVLW      .4
	MOVWF      c3
loop3:
	MOVLW      .250
	MOVWF      c2
loop2:
	MOVLW      .250
	MOVWF      c1
loop1:
	NOP
	DECFSZ     c1
	GOTO       loop1
	NOP
	NOP
	NOP
	DECFSZ     c2
	GOTO       loop2
	DECFSZ     c3
	GOTO       loop3
	NOP
	RETURN
	
INICIO:
    BSF	    STATUS,RP0
    MOVLW   0x80
    MOVWF   TRISA
    MOVLW   0xFF
    MOVWF   TRISB
    MOVLW   0x00
    MOVWF   TRISC
    MOVWF   TRISD
    BSF	    STATUS,RP1
    CLRF    ANSEL
    CLRF    ANSELH
    BCF	    STATUS,RP1
    BCF	    STATUS,RP0
    CLRF    PORTA
    CLRF    PORTB
    CLRF    PORTC
    CLRF    PORTD
    CLRW
 
SUMA:
    MOVF    PORTB,W
    XORLW   0xFF
    ANDLW   0xF0
    MOVWF   numero1
    SWAPF   numero1,W
    MOVWF   numero1
    MOVF    PORTB,W
    XORLW   0xFF
    ANDLW   0x0F
    ADDWF   numero1,W
    MOVWF   PORTA
    MOVWF   resultado
    BTFSC   resultado,4
    GOTO    PARPADEO
    GOTO    SUMA
    
PARPADEO:   BSF	    PORTA,4
	    CALL    DELAY
	    BCF	    PORTA,4
	    CALL    DELAY
	    GOTO    PARPADEO
    
	    END


