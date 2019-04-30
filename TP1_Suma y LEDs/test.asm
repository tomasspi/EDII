#include "p16f887.inc"

; CONFIG1
; __config 0x20F1
 __CONFIG _CONFIG1, _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF & _LVP_OFF
; CONFIG2
; __config 0x3FFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF


contador equ 0x20
tabla equ 0x21
 
    org 0x00 
    goto inicio
    org 0x05
 
 
 
 
inicio      movlw .27        
            movwf contador     
            movlw 0x64        
            movwf FSR          
vuelvo	    movlw .3        
	    call tabla
	    movwf INDF    
	    incf FSR,f         
	    decfsz contador,f  
	    goto vuelvo        
	    end
      
tabla	    addwf pcl
	    retlw .0
	    retlw .7
	    retlw .14
	    retlw .21
	    retlw .28
	    retlw .35
	    retlw .42
	    retlw .49
	    retlw .56
	    retlw .63   