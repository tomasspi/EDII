
_Move_Delay:

;lm35.c,20 :: 		void Move_Delay() { // Function used for text moving
;lm35.c,21 :: 		Delay_ms(500); // You can change the moving speed here
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_Move_Delay0:
	DECFSZ     R13+0, 1
	GOTO       L_Move_Delay0
	DECFSZ     R12+0, 1
	GOTO       L_Move_Delay0
	DECFSZ     R11+0, 1
	GOTO       L_Move_Delay0
	NOP
	NOP
;lm35.c,22 :: 		}
L_end_Move_Delay:
	RETURN
; end of _Move_Delay

_main:

;lm35.c,24 :: 		void main() {
;lm35.c,28 :: 		trisb=0;
	CLRF       TRISB+0
;lm35.c,29 :: 		trisa=0xff;
	MOVLW      255
	MOVWF      TRISA+0
;lm35.c,30 :: 		adcon1=0x80;
	MOVLW      128
	MOVWF      ADCON1+0
;lm35.c,31 :: 		lcd_init();
	CALL       _Lcd_Init+0
;lm35.c,32 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lm35.c,33 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lm35.c,34 :: 		lcd_out(3,2,"www.TheEngineering");
	MOVLW      3
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_lm35+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lm35.c,35 :: 		lcd_out(4,5,"Projects.com");
	MOVLW      4
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_lm35+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lm35.c,36 :: 		while(1)
L_main1:
;lm35.c,38 :: 		result=adc_read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;lm35.c,39 :: 		volt=result*4.88;
	CALL       _Word2Double+0
	MOVLW      246
	MOVWF      R4+0
	MOVLW      40
	MOVWF      R4+1
	MOVLW      28
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
;lm35.c,40 :: 		temp=volt/10;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      main_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      main_temp_L0+1
	MOVF       R0+2, 0
	MOVWF      main_temp_L0+2
	MOVF       R0+3, 0
	MOVWF      main_temp_L0+3
;lm35.c,42 :: 		lcd_out(1,1,"Temp = ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_lm35+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lm35.c,44 :: 		floattostr(temp,display);
	MOVF       main_temp_L0+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       main_temp_L0+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       main_temp_L0+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       main_temp_L0+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _display+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;lm35.c,45 :: 		lcd_out_cp(display);
	MOVLW      _display+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;lm35.c,46 :: 		lcd_chr(1,14,223); //print at pos(row=1,col=13) "°" =223 =0xdf
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      223
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;lm35.c,47 :: 		lcd_out_cp("C"); //celcius
	MOVLW      ?lstr4_lm35+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;lm35.c,50 :: 		}
	GOTO       L_main1
;lm35.c,52 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
