
; PIC16F887 Configuration Bit Settings

; Assembly source line config statements
    
;LIST P=16F877
#include "p16f887.inc"

; CONFIG1
; __config 0xFFF1
 __CONFIG _CONFIG1, _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _IESO_ON & _FCMEN_ON & _LVP_ON
; CONFIG2
; __config 0xFFFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF

    
 CODE
 BANKSEL    PORTA   
 CLRF	    PORTA
 BANKSEL    ANSEL
 CLRF	    ANSEL
 BCF	    STATUS,RP1
 BANKSEL    TRISA
 MOVLW	    B'11110000'
 MOVFW	    TRISA
 END
