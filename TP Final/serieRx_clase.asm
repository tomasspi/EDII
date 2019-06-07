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

org 0x00
goto start
start
bsf STATUS, RP0
movlw .25
movwf SPBRG
movlw 0x24
movwf TXSTA
clrf TRISB
bcf STATUS, RP0
movlw 0x90
movwf RCSTA
main
btfss PIR1, RCIF
goto main
movf RCREG, W
movwf PORTB
goto main
end