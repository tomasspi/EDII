LIST P=16F887
include <p16f887.inc>
; CONFIG1
; __config 0x3FE6
__CONFIG _CONFIG1, _FOSC_EXTRC_NOCLKOUT & _WDTE_OFF & _PWRTE_ON &
_MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _IESO_ON & _FCMEN_ON &
_LVP_ON
; CONFIG2
; __config 0xFFFF
__CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF

cblock 0x20
char0
COUNT1
COUNT2
endc
ORG 0x00
goto init
init
bsf STATUS, RP0 ;bank 1
;---CONFIGURE SPBRG FOR DESIRED BAUD RATE
movlw D'25' ;baud rate = 9600bps
movwf SPBRG ;at 4MHZ
;---CONFIGURE TXSTA
movlw B'00100100'
movwf TXSTA
;Configures TXSTA as 8 bit transmission, transmit enabled, async mode, high speed baud
rate
bcf STATUS, RP0 ;bank 0
movlw B'10000000'
movwf RCSTA ;enable serial port receive
movlw 0x41
movwf char0 ;put A (ascii code 0x41) character to char0 register
main
movf char0, W
movwf TXREG ;place the A character to TXREG
bsf STATUS, RP0 ;bank 1
wthere

btfss TXSTA, TRMT ;check if TRMT is empty
goto wthere ;if not, check again
bcf STATUS, RP0 ;bank 0, if TRMT is empty then the character has been sent
goto main
end
    
    ; cuando txreg se queda vacío, se levanta la bandera de interrupcion para indicarnos que podemos enviar otros 8 (o 9) bits
    ; el noveno bit puede usarse (ademas) para chequeo de paridad
    
    ; cuidado con filmina errada (no confundir bits con registros)
    ; si el error en el baudiaje es el alto, se puede sobremuestrear o perder muestras (dependiendo del signo del error)
    
    ; velocidad deseada = (Fosc) / ((64)*(SPBRGH:SPBRG - 1))
    ; SPBRGH:SPBRG = ((Fosc) / (velocidad deseada)) - 1
    
    ; para modulo:	RXD se conecta con Tx del pic
    ;			TXD se conecta con Rx del pic
    ;			el GND del modulo tiene que ser el mismo que del pic
    ;			descargar driver en: silicon lab CP210x USB to UART Bridge
    ;			    el dispositivo deberia aparecer en Puertos (COM y LPT)
    ;			    en propiedades del dispositivo veriamos en qué COM está (ésto va a servir para el software)
    ;			    mirar tambien propiedades por defecto
    ;			software: PuTTY, o Hercules terminal
    ;	en PuTTY, ayarde sacó flow control
    ;	la terminal lee en ASCII
    ;	en mplab podemos hacer lo siguiente: movlw 'a' para guardar en W el valor en ASCII de 'a'
    ;	con una tabla se podrian generar palabras:  retlw 'H'
    ;						    retlw 'O'
    ;						    retlw 'L'
    ;						    retlw 'A'