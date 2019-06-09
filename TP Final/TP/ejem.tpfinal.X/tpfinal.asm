#include "p16f887.inc"

; CONFIG1
; __config 0x3FF9
 __CONFIG _CONFIG1, _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF & _LVP_OFF
; CONFIG2
; __config 0x3FFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF

 CBLOCK 0x70
 DECENA
 UNIDAD
 GRADOS
 CELSIUS
 WA
 STATUSA
 DISPLAY
 AUX1
 CONTADOR
 DLAY
 ENDC
 
    ORG 0x00
    GOTO INICIO
    ORG 0x04
    GOTO IRS

 INICIO
	  ;----- CONFIGURACIÓN DE PUERTOS -----
          BANKSEL TRISA
	  CLRF TRISD        ;PUERTO D COMO SALIDA
	  MOVLW B'00000000' ;RC6 COMO SALIDA PARA Tx, EL RESTO SALIDAS
	  MOVWF TRISC       
	  MOVLW B'00000001'
	  MOVWF TRISB ; RB0 COMO ENTRADA
	  clrf	TRISA ; RA0 COMO ENTRADA
	  
;	  BANKSEL ANSEL ;RA0 COMO ENTRADA ANALÓGICA
;	  MOVLW 0x01	;EL RESTO DE LAS E/S COMO DIGITALES
	  clrf ANSEL 
	  CLRF ANSELH
	  
	  ;----- CONFIGURACIÓN PARA TRANSMISIÓN POR PUERTO SERIE -----
;	  BANKSEL TXSTA
;      BCF TXSTA, SYNC
;      
;      BANKSEL RCSTA
;      BSF RCSTA, SPEN      
;      
;      BANKSEL TXSTA
;      MOVLW   b'00100100'   
;      MOVWF   TXSTA      ;Tx = ON, ASÍNCRONO CON 8 BITS Y ALTA VELOCIDAD
      
;      BANKSEL SPBRG
;      MOVLW   .25
;      MOVWF   SPBRG      ;9600 BAUDIOS CON Fosc=4MHz
	  ;-----------------------------------------------------------
	  
	  
	  BANKSEL OPTION_REG
	  MOVLW B'00000111'
	  MOVWF OPTION_REG       ;PS=256
	  MOVLW B'00000001'
	  MOVWF	WPUB		 ;ACTIVO PULL UP DEL RB0
	  
	  BANKSEL T1CON
      MOVLW B'00110000'
      MOVWF T1CON    ; MODO TEMPORIZADOR, ACTIVO TMR1 , PS=8
      
      BANKSEL ADCON1
      MOVLW  B'00000000'     ; CONFIGURO ADC: resultado a la izquierda, con estos usamos los bits mas significativos (ADRESH)
      MOVWF ADCON1 ; VREF+ =VCC(5v), VREF- =GND(0) ; esto quiere decir que el rango es de 0 a 5V
      
      BANKSEL ADCON0
      MOVLW B'10000000'      
      MOVWF ADCON0     ; Fosc/32, canal analogico 0(AN0), ADC habilitado
      
	  BANKSEL INTCON
	  MOVLW B'00110000'
	  MOVWF INTCON   ;ACTIVO INTERRUPCIONES POR TMR0 Y RB0
	  
	  BANKSEL TMR1L
      MOVLW 0X0B
      MOVWF TMR1H     ;CARGAMOS TMR1
      MOVLW 0xDC
      MOVWF TMR1L
	  
	  BANKSEL TMR0
	  MOVLW .236      ;PRECARGO EL TMR0
	  MOVWF TMR0     ;PARA TENER 5mseg(por display) PARA RESFRECAR LOS DISPLAYS
	  
	  CLRF PORTD 
	  CLRF PORTC       ;LIMPIO LOS PUERTOS
	  CLRF PORTB
	  CLRF PORTA
	  
	  MOVLW 0x3F
	  MOVWF UNIDAD       ; UNIDAD
	  MOVLW 0x3F
	  MOVWF DECENA     ;DECENA
	  MOVLW 0x63		    
	  MOVWF GRADOS
	  MOVLW 0x39
	  MOVWF CELSIUS
	  MOVLW .4
	  MOVWF DISPLAY    ;CONTADOR PARA SABER EN QUE DISPLAY ESTOY
	  BANKSEL INTCON
	  BSF	  INTCON,GIE
	  
	  GOTO $
	  
IRS	  ;SALVAR CONTEXTO
	  MOVWF WA
	  SWAPF STATUS,W
	  MOVWF STATUSA   
	  ;VER BANDERAS
	  BTFSC INTCON,INTF    
	  GOTO RB0SR
	  BTFSC INTCON,T0IF   
	  GOTO TMR0SR
	  BTFSC PIR1,TMR1IF
	  GOTO TMR1SR
	  BTFSC PIR1,ADIF
	  GOTO ADSR
	  GOTO SALIR
	  
;----- INTERRUPCIÓN POR RB0 -----
RB0SR	  BCF INTCON,INTF
	  BSF ADCON0,GO
	  GOTO SALIR

;----- INTERRUPCIÓN POR CONVERSOR -----
ADSR	  BCF PIR1,ADIF
	  ;MODIFICAR DECENA Y UNIDAD

;----- INTERRUPCIÓN POR TIMER0 -----
TMR0SR	  BCF INTCON,T0IF
	  MOVLW	    .236
	  MOVWF	    TMR0
	  DECFSZ    DISPLAY,F
	  GOTO	    MOSTRAR	  
	  GOTO	    MOVDECENA	
	      
;----- MUESTRA LOS VALORES EN LOS DISPLAYS -----
MOSTRAR	 
	  BCF	    STATUS,Z
	  MOVF	    DISPLAY,W	    
	  SUBLW	    .3
	  MOVWF	    AUX1
	  BTFSC	    STATUS,Z
	  GOTO	    MOVLETRA
	  BTFSC	    AUX1,0
	  GOTO	    MOVGRADO
	  BTFSC	    AUX1,1
	  GOTO	    MOVUNIDAD
	  
MOVLETRA  
	  MOVF	CELSIUS,W
	  MOVWF	PORTD
	  CLRF	PORTC
	  BSF	PORTC,3
	  GOTO	SALIR
MOVGRADO  
	  MOVF	GRADOS,W
	  MOVWF	PORTD
	  CLRF	PORTC
	  BSF	PORTC,2	 
	  GOTO	SALIR
MOVUNIDAD 
	  MOVF	UNIDAD,W
	  MOVWF	PORTD
	  CLRF	PORTC
	  BSF	PORTC,1	 
	  GOTO	SALIR
MOVDECENA 
	  MOVF	DECENA,W
	  MOVWF	PORTD
	  CLRF	PORTC
	  BSF	PORTC,0
	  MOVLW .4
	  MOVWF	DISPLAY
	  GOTO	SALIR	

;----- INTERRUPCIÓN POR TIMER1 -----
TMR1SR	  BCF PIR1,TMR1IF
	  MOVLW	0x0B
	  MOVWF	TMR1H
	  MOVLW	0xDC
	  MOVWF	TMR1L
	  DECFSZ CONTADOR
	  GOTO SALIR
	  ;SI ES 0 MANDAR EL DATO 
	  ;Y MOSTRAR LEDs
	  
;----- RECUPERAR CONTEXTO -----	  
SALIR
	  SWAPF	STATUSA,W
	  MOVWF	STATUS
	  SWAPF	WA,F
	  SWAPF	WA,W
	  RETFIE	  

;----- DELAY PARA ADQUISICION DEL DATO -----
DELAY MOVLW .250
      MOVWF DLAY
	  DECFSZ DLAY		;250[uS]
	  GOTO $-1
	  
;----- TABLAS CON LOS VALORES DEL 0 AL 9 PARA LOS DISPLAYS -----
TABLA     ADDWF PCL,F
	  RETLW 0X3F       ;0
          RETLW 0x06       ;1
	  RETLW 0x5B       ;2
	  RETLW 0x4F       ;3
	  RETLW 0x66       ;4
	  RETLW 0x6D       ;5
	  RETLW 0x7D       ;6
	  RETLW 0x07       ;7
	  RETLW 0x7F       ;8
	  RETLW 0x6F       ;9

	  END
 
