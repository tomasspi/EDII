; PIC16F887 Configuration Bit Settings

; Assembly source line config statements

#include "p16f887.inc"

; CONFIG1
; __config 0x3FF1
 __CONFIG _CONFIG1, _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _IESO_ON & _FCMEN_ON & _LVP_ON
; CONFIG2
; __config 0x3FFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF

 
  ; Variable para salvar y recuperar registro STATUS y W
W_TEMP      equ 0x36
STATUS_TEMP equ 0x37

  ;Variable para el DELAY del ADC 
val equ h'20' 

  ;Variables para el DELAY del ENABLE LCD
val2     equ 0x30
val1     equ 0x31

  ;Variables para separar el resultado de ADC
  ; en valor BCD
Unidades equ 0x32     
Decenas  equ 0x33  	
Centenas equ 0x34   
Resto    equ 0x35

 
 ;Variables para guardar el dato recibido del puerto serie
RECIBIDO equ 0x36

  org 0x00
  goto INICIO
  org 0x04
  goto INT
  org 0x05

INICIO
      clrf PORTA        ;Limpia el puerto A
      clrf PORTB        ;Limpia el puerto B
      clrf PORTC        ;Limpia el puerto C	
      clrf PORTD        ;Limpia el puerto D
      bsf STATUS,RP0    
      bcf STATUS,RP1    ;Cambio al banco 1
	  
      ;Configuración de puertos C-D para el LCD y puerto serie
      
      clrf TRISB        ;Configura PORTB como salida exepto RB0
      clrf TRISD        ;Configura PORTD como salida
      movlw 0xbc        ;Configura el puerto C como entrada para el puerto serie
      movwf TRISC       ;exepto RC6,RC0 Y RC1 
      
      ;Configuracion para puerto serie
      movlw b'00100100'
      movwf TXSTA
      movlW .25
      movwf SPBRG
      bsf PIE1,RCIE
      
      ;Configuración del puerto A para ADC
      movlw 0x00         
      movwf ADCON1      ; ADFM=0 ajuste a la izquierda, VCFG1=0=VSS, VCFG0=0=VDD
      movlw 0x01        ;  RA0 como entrada      
      movwf TRISA       ;Configura el puerto A como entrada
      bsf   PIE1,ADIE   ;Habilitamos interrupciones A/D
      bsf   STATUS,RP0
      bsf   STATUS,RP1
      bsf   ANSEL,0     ;Configuro RA0 como entrada analogica
      bcf   STATUS,RP0  ;regresa a banco 0 
      bcf   STATUS,RP1
      
      ;otro punto para puerto serie
      movlw 0x90
      MOVWF RCSTA
      
      ;sigue con configuracion para ADC
      banksel PIR1
      bcf   PIR1,ADIF   ;Limpio flag de interrupcion
      bsf   INTCON,PEIE ;Habilito interrupciones de perifericos
      bsf   INTCON,GIE  ;Habilito interrupciones globales 
        
      ;Inicio del programa
START
      call START_LCD   ;Inicializa LCD
      goto START_ADC   ;Comienza la lectura del Conv. A/D
	  
      ;Inicia LCD
START_LCD
      bcf PORTC,0      ; RS=0 MODO INSTRUCCION
      movlw 0x01       ; 0x01 limpia la pantalla en el LCD
      movwf PORTD 
      call COMANDO     ; Se da de alta el comando
      movlw 0x0C       ; Selecciona la primera línea
      movwf PORTD
      call COMANDO     ; Se da de alta el comando
      movlw 0x3C       ; Se configura el cursor
      movwf PORTD
      call COMANDO     ; Se da de alta el comando
      bsf PORTC,0     ; Rs=1 MODO DATO
      return
	  
      ;Rutina para enviar un dato
ENVIA
      bsf PORTC,0    ; RS=1 MODO DATO
      call COMANDO    ; Se da de alta el comando
      return 
	   
      ;Rutina para enviar comandos
COMANDO
      bsf PORTC,1    ; Pone la señal ENABLE en 1
      call DELAY2     ; Tiempo de espera
      call DELAY2
      bcf PORTC, 1    ; ENABLE=0	
      call DELAY2
      return     
	  
      ;Rutina para limpar pantalla LCD  
ERASE_LCD
      bcf PORTC,0      ; RS=0 MODO INSTRUCCION
      movlw 0x01       ; 0x01 limpia la pantalla en el LCD
      movwf PORTD
      call COMANDO     ; Se da de alta el comando
      bsf PORTC,0    ; Rs=1 MODO DATO
      return
	  
      ;Configuración Convertidor A/D
START_ADC
      banksel ADCON0
      movlw b'11000001' ;ConfiguraciÃ³n ADCON0 
      movwf ADCON0      ;fRC, canal de conversion 0,conversion finalizada
                        ;modulo A/D encendido 
			
      call DELAY1  
       call DELAY1
CICLO  bsf ADCON0,1      ;Conversión en progreso GO=1 
      
       ;Rutina que muestra temperatura
PRINT_TEMP
       call ERASE_LCD    ;Limpia LCD
       movlw 'T'
       movwf PORTD
       call ENVIA
       movlw '=' 
       movwf PORTD
       call ENVIA

       call READ_TEMP    ;Llamada a rutina que obtine el 
                         ;valor de la temperatura a partir
                         ;del  resultado del Conv a/D

       movf Centenas,W   ;Imprime el dígito de las centenas
       movwf PORTD
       call ENVIA
       movf Decenas,W    ;Imprime el dígito de las decenas
       movwf PORTD
       call ENVIA
       movf Unidades,W   ;Imprime el dígito de las unidades
       movwf PORTD
       call ENVIA
       movlw ' '
       movwf PORTD
       call ENVIA
       movlw h'DF'       ;Imprime el simbolo "°"
       movwf PORTD
       call ENVIA 
       movlw 'C'
       movwf PORTD
       call ENVIA 

       goto CICLO        ;Repite el ciclo de lectura ADC

       ;Rutina que obtine el valor de la temperatura
       ;a partir del  resultado del Conv a/D
READ_TEMP
       clrf Centenas
       clrf Decenas
       clrf Unidades
      
       movf ADRESH,W   
       addwf ADRESH,W     ;Dupilca el valor de ADRESH para 
                        ;obtener un valor de temperatura real aprox
       movwf Resto        ;Guarda el valor de ADRESH en Resto  
	    
       ;Comienza el proceso de otención de valores BCD 
       ;para Centenas, Decenas y unidades atraves de restas
       ;sucesivas.
CENTENAS1
       movlw d'100'      ;W=d'100'
       subwf Resto,W     ;Resto - d'100' (W)
       btfss STATUS,C    ;Resto menor que d'100'?
       goto DECENAS1     ;SI
       movwf Resto       ;NO, Salva el resto
       incf Centenas,1   ;Incrementa el contador de centenas BCD
       goto CENTENAS1    ;Realiza otra resta
DECENAS1
       movlw d'10'       ;W=d'10'
       subwf Resto,W     ;Resto - d'10' (W)
       btfss STATUS,C    ;Resto menor que d'10'?
       goto UNIDADES1    ;Si
       movwf Resto       ;No, Salva el resto
       incf Decenas,1    ;Incrementa el contador de centenas BCD
       goto DECENAS1     ;Realiza otra resta
UNIDADES1
       movf Resto,W      ;El resto son la Unidades BCD
       movwf Unidades 
       ;clrf Resto
	   
       ;Rutina que obtiene el equivalente en ASCII	   
OBTEN_ASCII
       movlw h'30' 
       iorwf Unidades,f      
       iorwf Decenas,f
       iorwf Centenas,f      
       return

;Rutina que genera un Delay de 20 microSeg aprox.
;para el Conv. A/D
DELAY1             
       movlw h'30'
       movwf val
Loop   decfsz val,1
       goto Loop
       return

;Subrutina de retardo para ENABLE_LCD 
DELAY2        	
       movlw 0xFF
       movwf val1 
Loop1
       movlw 0xFF
       movwf val2	
Loop2
       decfsz val2,1
       goto Loop2
       decfsz val1,1
       goto Loop1
       return
       

;Rutina de interrupcion      
INT movwf W_TEMP
    swapf STATUS,W
    movwf STATUS_TEMP
    btfsc PIR1,ADIF       ;¿interrupcion por modulo A/D?
    goto INTAD            ;si, vamos a rutina INT por AD
    btfsc PIR1,RCIF       ;¿interrupcion por Recepcion de dato?
    goto  INTR            ;si,vamos a rutina de INT por recepcion de dato
    goto  INTT            ;no,vamos a rutina de INT por transmision de datos
FIN swapf STATUS_TEMP
    movwf STATUS
    swapf W_TEMP,F
    swapf W_TEMP,W
    retfie                ;retorno de interrupcion, habilito GIE
       
       
INTAD       
       movf  ADRESH,0      ;Si, tomo los 8 bits de l conversion
       movwf PORTB         ;Muestra el resultado en PORTB
       bcf   PIR1,ADIF     ;reseteo la bandera de A/D
       call  DELAY1        ;delay de adquisicion
       goto  FIN           
       
INTR
       bcf   PIR1,RCIF     ;leo el dato recibido
       movf  RCREG,W      
       movwf RECIBIDO
       bsf   PORTA,4
       ;call  TX_DATO       ;va a transmitir el dato
       goto  FIN
       
INTT
       bcf   PIR1,TXIF
       movwf TXREG       ;almaceno byte a transmitir
       bsf   STATUS,RP0
TX     btfss TXSTA,TRMT  ;byte transmitido?
       goto  TX
       bcf   STATUS,RP0
       goto  FIN
       
       
    end
