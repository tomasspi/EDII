
_Initialization:

;MyProject.c,11 :: 		void Initialization()
;MyProject.c,13 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       1
	MOVWF       SPBRGH+0 
	MOVLW       160
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;MyProject.c,14 :: 		TRISD = 0;
	CLRF        TRISD+0 
;MyProject.c,15 :: 		PortD = 0;
	CLRF        PORTD+0 
;MyProject.c,16 :: 		P1 = EEPROM_Read(0x01);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _P1+0 
;MyProject.c,17 :: 		P2 = EEPROM_Read(0x02);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _P2+0 
;MyProject.c,18 :: 		P3 = EEPROM_Read(0x03);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _P3+0 
;MyProject.c,19 :: 		}
L_end_Initialization:
	RETURN      0
; end of _Initialization

_PassChange:

;MyProject.c,21 :: 		void PassChange()
;MyProject.c,23 :: 		while(1)
L_PassChange0:
;MyProject.c,25 :: 		if (UART1_Data_Ready())
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_PassChange2
;MyProject.c,27 :: 		Indata = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Indata+0 
;MyProject.c,29 :: 		if(CPassCheck == 2){CPassCheck = 3; EEPROM_Write(0x03, Indata); P3 = EEPROM_Read(0x03);}
	MOVLW       0
	XORWF       _CPassCheck+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__PassChange57
	MOVLW       2
	XORWF       _CPassCheck+0, 0 
L__PassChange57:
	BTFSS       STATUS+0, 2 
	GOTO        L_PassChange3
	MOVLW       3
	MOVWF       _CPassCheck+0 
	MOVLW       0
	MOVWF       _CPassCheck+1 
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Indata+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _P3+0 
L_PassChange3:
;MyProject.c,30 :: 		if(CPassCheck == 1){CPassCheck = 2; EEPROM_Write(0x02, Indata); P2 = EEPROM_Read(0x02);}
	MOVLW       0
	XORWF       _CPassCheck+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__PassChange58
	MOVLW       1
	XORWF       _CPassCheck+0, 0 
L__PassChange58:
	BTFSS       STATUS+0, 2 
	GOTO        L_PassChange4
	MOVLW       2
	MOVWF       _CPassCheck+0 
	MOVLW       0
	MOVWF       _CPassCheck+1 
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Indata+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _P2+0 
L_PassChange4:
;MyProject.c,31 :: 		if(CPassCheck == 0){CPassCheck = 1; EEPROM_Write(0x01, Indata); P1 = EEPROM_Read(0x01);}
	MOVLW       0
	XORWF       _CPassCheck+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__PassChange59
	MOVLW       0
	XORWF       _CPassCheck+0, 0 
L__PassChange59:
	BTFSS       STATUS+0, 2 
	GOTO        L_PassChange5
	MOVLW       1
	MOVWF       _CPassCheck+0 
	MOVLW       0
	MOVWF       _CPassCheck+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Indata+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _P1+0 
L_PassChange5:
;MyProject.c,32 :: 		UART1_Write_Text("*");
	MOVLW       ?lstr1_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;MyProject.c,33 :: 		if(CPassCheck == 3){break;}
	MOVLW       0
	XORWF       _CPassCheck+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__PassChange60
	MOVLW       3
	XORWF       _CPassCheck+0, 0 
L__PassChange60:
	BTFSS       STATUS+0, 2 
	GOTO        L_PassChange6
	GOTO        L_PassChange1
L_PassChange6:
;MyProject.c,34 :: 		}
L_PassChange2:
;MyProject.c,35 :: 		}
	GOTO        L_PassChange0
L_PassChange1:
;MyProject.c,37 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,38 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,39 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,40 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,41 :: 		}
L_end_PassChange:
	RETURN      0
; end of _PassChange

_CorrectPass:

;MyProject.c,43 :: 		void CorrectPass()
;MyProject.c,45 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,46 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,47 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,48 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,49 :: 		UART1_Write_Text("Select one of the below Options: ");
	MOVLW       ?lstr2_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;MyProject.c,50 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,51 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,52 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,53 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,54 :: 		UART1_Write_Text("1) Press Y to Lock.");
	MOVLW       ?lstr3_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;MyProject.c,55 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,56 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,57 :: 		UART1_Write_Text("2) Press N to Unlock.");
	MOVLW       ?lstr4_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;MyProject.c,58 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,59 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,60 :: 		UART1_Write_Text("3) Press C to Change Password.");
	MOVLW       ?lstr5_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;MyProject.c,61 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,62 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,63 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,64 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,65 :: 		UART1_Write_Text("Waiting for Response: ");
	MOVLW       ?lstr6_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;MyProject.c,67 :: 		while(1)
L_CorrectPass7:
;MyProject.c,69 :: 		if (UART1_Data_Ready())
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_CorrectPass9
;MyProject.c,71 :: 		Indata = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Indata+0 
;MyProject.c,73 :: 		if((Indata == 'Y') || (Indata == 'y')){UART1_Write_Text("Y"); PortD.F0 = 1; PortD.F1 = 0; UART1_Write(10); UART1_Write(13); UART1_Write(10); UART1_Write(13); break;}
	MOVF        R0, 0 
	XORLW       89
	BTFSC       STATUS+0, 2 
	GOTO        L__CorrectPass49
	MOVF        _Indata+0, 0 
	XORLW       121
	BTFSC       STATUS+0, 2 
	GOTO        L__CorrectPass49
	GOTO        L_CorrectPass12
L__CorrectPass49:
	MOVLW       ?lstr7_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr7_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	BSF         PORTD+0, 0 
	BCF         PORTD+0, 1 
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	GOTO        L_CorrectPass8
L_CorrectPass12:
;MyProject.c,74 :: 		if((Indata == 'N') || (Indata == 'n')){UART1_Write_Text("N"); PortD.F0 = 0; PortD.F1 = 1; UART1_Write(10); UART1_Write(13); UART1_Write(10); UART1_Write(13); break;}
	MOVF        _Indata+0, 0 
	XORLW       78
	BTFSC       STATUS+0, 2 
	GOTO        L__CorrectPass48
	MOVF        _Indata+0, 0 
	XORLW       110
	BTFSC       STATUS+0, 2 
	GOTO        L__CorrectPass48
	GOTO        L_CorrectPass15
L__CorrectPass48:
	MOVLW       ?lstr8_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr8_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	BCF         PORTD+0, 0 
	BSF         PORTD+0, 1 
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	GOTO        L_CorrectPass8
L_CorrectPass15:
;MyProject.c,75 :: 		if((Indata == 'C') || (Indata == 'c')){UART1_Write_Text("C"); UART1_Write(10); UART1_Write(13); UART1_Write(10); UART1_Write(13); UART1_Write_Text("Enter New Password: "); PassChange();break;}
	MOVF        _Indata+0, 0 
	XORLW       67
	BTFSC       STATUS+0, 2 
	GOTO        L__CorrectPass47
	MOVF        _Indata+0, 0 
	XORLW       99
	BTFSC       STATUS+0, 2 
	GOTO        L__CorrectPass47
	GOTO        L_CorrectPass18
L__CorrectPass47:
	MOVLW       ?lstr9_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr9_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	MOVLW       ?lstr10_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr10_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	CALL        _PassChange+0, 0
	GOTO        L_CorrectPass8
L_CorrectPass18:
;MyProject.c,78 :: 		}
L_CorrectPass9:
;MyProject.c,79 :: 		}
	GOTO        L_CorrectPass7
L_CorrectPass8:
;MyProject.c,80 :: 		}
L_end_CorrectPass:
	RETURN      0
; end of _CorrectPass

_WrongPass:

;MyProject.c,82 :: 		void WrongPass()
;MyProject.c,84 :: 		int x = 0;
	CLRF        WrongPass_x_L0+0 
	CLRF        WrongPass_x_L0+1 
;MyProject.c,85 :: 		PortD.F5 = 1;
	BSF         PORTD+0, 5 
;MyProject.c,86 :: 		while(1)
L_WrongPass19:
;MyProject.c,89 :: 		PortD.F2 = 1;
	BSF         PORTD+0, 2 
;MyProject.c,90 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_WrongPass21:
	DECFSZ      R13, 1, 1
	BRA         L_WrongPass21
	DECFSZ      R12, 1, 1
	BRA         L_WrongPass21
	DECFSZ      R11, 1, 1
	BRA         L_WrongPass21
;MyProject.c,91 :: 		PortD.F2 = 0;
	BCF         PORTD+0, 2 
;MyProject.c,92 :: 		PortD.F3 = 1;
	BSF         PORTD+0, 3 
;MyProject.c,93 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_WrongPass22:
	DECFSZ      R13, 1, 1
	BRA         L_WrongPass22
	DECFSZ      R12, 1, 1
	BRA         L_WrongPass22
	DECFSZ      R11, 1, 1
	BRA         L_WrongPass22
;MyProject.c,94 :: 		PortD.F3 = 0;
	BCF         PORTD+0, 3 
;MyProject.c,95 :: 		PortD.F4 = 1;
	BSF         PORTD+0, 4 
;MyProject.c,96 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_WrongPass23:
	DECFSZ      R13, 1, 1
	BRA         L_WrongPass23
	DECFSZ      R12, 1, 1
	BRA         L_WrongPass23
	DECFSZ      R11, 1, 1
	BRA         L_WrongPass23
;MyProject.c,97 :: 		PortD.F4 = 0;
	BCF         PORTD+0, 4 
;MyProject.c,98 :: 		x = x + 1;
	INFSNZ      WrongPass_x_L0+0, 1 
	INCF        WrongPass_x_L0+1, 1 
;MyProject.c,99 :: 		if(x > 30){break;}
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       WrongPass_x_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WrongPass63
	MOVF        WrongPass_x_L0+0, 0 
	SUBLW       30
L__WrongPass63:
	BTFSC       STATUS+0, 0 
	GOTO        L_WrongPass24
	GOTO        L_WrongPass20
L_WrongPass24:
;MyProject.c,100 :: 		}
	GOTO        L_WrongPass19
L_WrongPass20:
;MyProject.c,101 :: 		PortD.F5 = 0;
	BCF         PORTD+0, 5 
;MyProject.c,102 :: 		}
L_end_WrongPass:
	RETURN      0
; end of _WrongPass

_main:

;MyProject.c,105 :: 		void main() {
;MyProject.c,106 :: 		Initialization();
	CALL        _Initialization+0, 0
;MyProject.c,108 :: 		do
L_main25:
;MyProject.c,110 :: 		UART1_Write_Text("Enter Password: ");
	MOVLW       ?lstr11_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr11_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;MyProject.c,111 :: 		while(1)
L_main28:
;MyProject.c,113 :: 		if (UART1_Data_Ready())
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main30
;MyProject.c,115 :: 		Indata = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Indata+0 
;MyProject.c,117 :: 		if((Indata == P1) && (PassCheck == 0)){PassCheck = 1;}
	MOVF        R0, 0 
	XORWF       _P1+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main33
	MOVLW       0
	XORWF       _PassCheck+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main65
	MOVLW       0
	XORWF       _PassCheck+0, 0 
L__main65:
	BTFSS       STATUS+0, 2 
	GOTO        L_main33
L__main54:
	MOVLW       1
	MOVWF       _PassCheck+0 
	MOVLW       0
	MOVWF       _PassCheck+1 
L_main33:
;MyProject.c,118 :: 		if((Indata == P2) && (PassCheck == 1)){PassCheck = 2;}
	MOVF        _Indata+0, 0 
	XORWF       _P2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main36
	MOVLW       0
	XORWF       _PassCheck+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main66
	MOVLW       1
	XORWF       _PassCheck+0, 0 
L__main66:
	BTFSS       STATUS+0, 2 
	GOTO        L_main36
L__main53:
	MOVLW       2
	MOVWF       _PassCheck+0 
	MOVLW       0
	MOVWF       _PassCheck+1 
L_main36:
;MyProject.c,119 :: 		if((Indata == P3) && (PassCheck == 2)){PassCheck = 3;}
	MOVF        _Indata+0, 0 
	XORWF       _P3+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main39
	MOVLW       0
	XORWF       _PassCheck+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main67
	MOVLW       2
	XORWF       _PassCheck+0, 0 
L__main67:
	BTFSS       STATUS+0, 2 
	GOTO        L_main39
L__main52:
	MOVLW       3
	MOVWF       _PassCheck+0 
	MOVLW       0
	MOVWF       _PassCheck+1 
L_main39:
;MyProject.c,121 :: 		if((Indata == 13) && (PassCheck == 3)){PassCheck = 0; WrongCheck = 0; UART1_Write(10); UART1_Write(13); UART1_Write_Text("Correct Password.");CorrectPass();break;}
	MOVF        _Indata+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_main42
	MOVLW       0
	XORWF       _PassCheck+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main68
	MOVLW       3
	XORWF       _PassCheck+0, 0 
L__main68:
	BTFSS       STATUS+0, 2 
	GOTO        L_main42
L__main51:
	CLRF        _PassCheck+0 
	CLRF        _PassCheck+1 
	CLRF        _WrongCheck+0 
	CLRF        _WrongCheck+1 
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	MOVLW       ?lstr12_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr12_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	CALL        _CorrectPass+0, 0
	GOTO        L_main29
L_main42:
;MyProject.c,122 :: 		if((Indata == 13) && (PassCheck != 3)){PassCheck = 0; UART1_Write(10); UART1_Write(13); UART1_Write_Text("Wrong Password."); WrongCheck = WrongCheck + 1; if(WrongCheck == 3){WrongPass();}UART1_Write(10); UART1_Write(13); UART1_Write(10); UART1_Write(13);break;}
	MOVF        _Indata+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_main45
	MOVLW       0
	XORWF       _PassCheck+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main69
	MOVLW       3
	XORWF       _PassCheck+0, 0 
L__main69:
	BTFSC       STATUS+0, 2 
	GOTO        L_main45
L__main50:
	CLRF        _PassCheck+0 
	CLRF        _PassCheck+1 
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	MOVLW       ?lstr13_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr13_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	INFSNZ      _WrongCheck+0, 1 
	INCF        _WrongCheck+1, 1 
	MOVLW       0
	XORWF       _WrongCheck+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main70
	MOVLW       3
	XORWF       _WrongCheck+0, 0 
L__main70:
	BTFSS       STATUS+0, 2 
	GOTO        L_main46
	CALL        _WrongPass+0, 0
L_main46:
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	GOTO        L_main29
L_main45:
;MyProject.c,123 :: 		UART1_Write_Text("*");
	MOVLW       ?lstr14_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr14_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;MyProject.c,124 :: 		}
L_main30:
;MyProject.c,125 :: 		}
	GOTO        L_main28
L_main29:
;MyProject.c,127 :: 		} while(1);
	GOTO        L_main25
;MyProject.c,128 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
