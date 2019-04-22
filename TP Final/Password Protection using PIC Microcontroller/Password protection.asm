
_Password_prompt:

;Password protection.c,25 :: 		void Password_prompt(){
;Password protection.c,26 :: 		Lcd_Cmd(_LCD_CLEAR);                     // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Password protection.c,27 :: 		Lcd_Out(1, 1, "Motor is Off");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Password_32protection+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Password protection.c,28 :: 		Lcd_Out(2,1,"and Locked");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Password_32protection+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Password protection.c,29 :: 		Delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_Password_prompt0:
	DECFSZ     R13+0, 1
	GOTO       L_Password_prompt0
	DECFSZ     R12+0, 1
	GOTO       L_Password_prompt0
	DECFSZ     R11+0, 1
	GOTO       L_Password_prompt0
	NOP
;Password protection.c,31 :: 		Lcd_Cmd(_LCD_CLEAR);                     // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Password protection.c,32 :: 		Lcd_Out(1, 1, "Enter 6 digit no:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_Password_32protection+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Password protection.c,34 :: 		Lcd_Cmd(_LCD_BLINK_CURSOR_ON);                // Cursor off
	MOVLW      15
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Password protection.c,35 :: 		Lcd_Cmd(_LCD_SECOND_ROW);
	MOVLW      192
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Password protection.c,36 :: 		}
L_end_Password_prompt:
	RETURN
; end of _Password_prompt

_Init:

;Password protection.c,39 :: 		void Init(){
;Password protection.c,40 :: 		Lcd_Init();                        // Initialize LCD
	CALL       _Lcd_Init+0
;Password protection.c,41 :: 		Lcd_Cmd(_LCD_CLEAR);                     // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Password protection.c,42 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Password protection.c,43 :: 		Lcd_Out(1, 1, "Welcome to");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_Password_32protection+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Password protection.c,44 :: 		Lcd_Out(2, 1, "Password Lock");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_Password_32protection+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Password protection.c,45 :: 		Lcd_Out(3, 2, "www.TheEngineering");
	MOVLW      3
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_Password_32protection+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Password protection.c,46 :: 		Lcd_Out(4, 5,"Projects.com");
	MOVLW      4
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_Password_32protection+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Password protection.c,48 :: 		Delay_ms(5000);
	MOVLW      127
	MOVWF      R11+0
	MOVLW      212
	MOVWF      R12+0
	MOVLW      49
	MOVWF      R13+0
L_Init1:
	DECFSZ     R13+0, 1
	GOTO       L_Init1
	DECFSZ     R12+0, 1
	GOTO       L_Init1
	DECFSZ     R11+0, 1
	GOTO       L_Init1
	NOP
	NOP
;Password protection.c,49 :: 		Password_prompt();
	CALL       _Password_prompt+0
;Password protection.c,50 :: 		TRISB=0;
	CLRF       TRISB+0
;Password protection.c,52 :: 		count=0;
	CLRF       _count+0
	CLRF       _count+1
;Password protection.c,53 :: 		Keypad_Init();                           // Initialize Keypad
	CALL       _Keypad_Init+0
;Password protection.c,54 :: 		}
L_end_Init:
	RETURN
; end of _Init

_Check_password:

;Password protection.c,58 :: 		int Check_password(){
;Password protection.c,60 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Password protection.c,61 :: 		if(!memcmp(actual_password, given_password, 6)){
	MOVLW      _actual_password+0
	MOVWF      FARG_memcmp_s1+0
	MOVLW      _given_password+0
	MOVWF      FARG_memcmp_s2+0
	MOVLW      6
	MOVWF      FARG_memcmp_n+0
	MOVLW      0
	MOVWF      FARG_memcmp_n+1
	CALL       _memcmp+0
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L_Check_password2
;Password protection.c,62 :: 		Lcd_Out(1, 1, "Password Matched");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_Password_32protection+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Password protection.c,63 :: 		Lcd_Out(2,1,"Motor is on");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_Password_32protection+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Password protection.c,65 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	GOTO       L_end_Check_password
;Password protection.c,66 :: 		}
L_Check_password2:
;Password protection.c,68 :: 		Lcd_Out(1, 1, "Incorrect Password");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_Password_32protection+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Password protection.c,69 :: 		Lcd_Out(2, 1, "Try Again!");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_Password_32protection+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Password protection.c,71 :: 		Delay_ms(2000);
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_Check_password4:
	DECFSZ     R13+0, 1
	GOTO       L_Check_password4
	DECFSZ     R12+0, 1
	GOTO       L_Check_password4
	DECFSZ     R11+0, 1
	GOTO       L_Check_password4
	NOP
	NOP
;Password protection.c,72 :: 		Password_prompt();
	CALL       _Password_prompt+0
;Password protection.c,73 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
;Password protection.c,77 :: 		}
L_end_Check_password:
	RETURN
; end of _Check_password

_main:

;Password protection.c,80 :: 		void main() {
;Password protection.c,81 :: 		Init();
	CALL       _Init+0
;Password protection.c,82 :: 		do {
L_main5:
;Password protection.c,83 :: 		kp = 0;                                // Reset key code variable
	CLRF       _kp+0
;Password protection.c,84 :: 		if(count==6)
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main40
	MOVLW      6
	XORWF      _count+0, 0
L__main40:
	BTFSS      STATUS+0, 2
	GOTO       L_main8
;Password protection.c,86 :: 		PORTB.B7=Check_password();    //0/1 according to password check and drives the motor
	CALL       _Check_password+0
	BTFSC      R0+0, 0
	GOTO       L__main41
	BCF        PORTB+0, 7
	GOTO       L__main42
L__main41:
	BSF        PORTB+0, 7
L__main42:
;Password protection.c,87 :: 		count=0;
	CLRF       _count+0
	CLRF       _count+1
;Password protection.c,88 :: 		if(PORTB.B7==1){
	BTFSS      PORTB+0, 7
	GOTO       L_main9
;Password protection.c,89 :: 		Delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	DECFSZ     R11+0, 1
	GOTO       L_main10
	NOP
;Password protection.c,90 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Password protection.c,92 :: 		Lcd_Out(1,1,"Press * to Off");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr12_Password_32protection+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Password protection.c,93 :: 		Lcd_Out(2,1,"and Lock again");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr13_Password_32protection+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Password protection.c,94 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);           // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Password protection.c,96 :: 		do
L_main11:
;Password protection.c,98 :: 		kp = Keypad_Key_Click();             // Store key code in kp variable
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;Password protection.c,99 :: 		while (kp!=13);
	MOVF       R0+0, 0
	XORLW      13
	BTFSS      STATUS+0, 2
	GOTO       L_main11
;Password protection.c,100 :: 		if(kp==13){
	MOVF       _kp+0, 0
	XORLW      13
	BTFSS      STATUS+0, 2
	GOTO       L_main14
;Password protection.c,101 :: 		PORTB.B7=0;
	BCF        PORTB+0, 7
;Password protection.c,102 :: 		Password_prompt();
	CALL       _Password_prompt+0
;Password protection.c,103 :: 		}
L_main14:
;Password protection.c,104 :: 		}
L_main9:
;Password protection.c,105 :: 		}
L_main8:
;Password protection.c,107 :: 		do
L_main15:
;Password protection.c,109 :: 		kp = Keypad_Key_Click();             // Store key code in kp variable
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;Password protection.c,110 :: 		while (!kp);
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main15
;Password protection.c,111 :: 		switch (kp) {
	GOTO       L_main18
;Password protection.c,112 :: 		case  1: kp = 49;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break; // 1        // Uncomment this block for keypad4x4
L_main20:
	MOVLW      49
	MOVWF      _kp+0
	MOVLW      49
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVF       _count+0, 0
	ADDLW      _given_password+0
	MOVWF      FSR
	MOVF       _kp+0, 0
	MOVWF      INDF+0
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
	GOTO       L_main19
;Password protection.c,113 :: 		case  2: kp = 50;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break; // 2
L_main21:
	MOVLW      50
	MOVWF      _kp+0
	MOVLW      50
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVF       _count+0, 0
	ADDLW      _given_password+0
	MOVWF      FSR
	MOVF       _kp+0, 0
	MOVWF      INDF+0
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
	GOTO       L_main19
;Password protection.c,114 :: 		case  3: kp = 51;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break; // 3
L_main22:
	MOVLW      51
	MOVWF      _kp+0
	MOVLW      51
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVF       _count+0, 0
	ADDLW      _given_password+0
	MOVWF      FSR
	MOVF       _kp+0, 0
	MOVWF      INDF+0
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
	GOTO       L_main19
;Password protection.c,115 :: 		case  4: kp = 65;Lcd_Chr_Cp(kp); break; // A
L_main23:
	MOVLW      65
	MOVWF      _kp+0
	MOVLW      65
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	GOTO       L_main19
;Password protection.c,116 :: 		case  5: kp = 52;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break; // 4
L_main24:
	MOVLW      52
	MOVWF      _kp+0
	MOVLW      52
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVF       _count+0, 0
	ADDLW      _given_password+0
	MOVWF      FSR
	MOVF       _kp+0, 0
	MOVWF      INDF+0
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
	GOTO       L_main19
;Password protection.c,117 :: 		case  6: kp = 53;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break; // 5
L_main25:
	MOVLW      53
	MOVWF      _kp+0
	MOVLW      53
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVF       _count+0, 0
	ADDLW      _given_password+0
	MOVWF      FSR
	MOVF       _kp+0, 0
	MOVWF      INDF+0
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
	GOTO       L_main19
;Password protection.c,118 :: 		case  7: kp = 54;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break; // 6
L_main26:
	MOVLW      54
	MOVWF      _kp+0
	MOVLW      54
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVF       _count+0, 0
	ADDLW      _given_password+0
	MOVWF      FSR
	MOVF       _kp+0, 0
	MOVWF      INDF+0
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
	GOTO       L_main19
;Password protection.c,119 :: 		case  8: kp = 66;Lcd_Chr_Cp(kp); break; // B
L_main27:
	MOVLW      66
	MOVWF      _kp+0
	MOVLW      66
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	GOTO       L_main19
;Password protection.c,120 :: 		case  9: kp = 55;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break; // 7
L_main28:
	MOVLW      55
	MOVWF      _kp+0
	MOVLW      55
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVF       _count+0, 0
	ADDLW      _given_password+0
	MOVWF      FSR
	MOVF       _kp+0, 0
	MOVWF      INDF+0
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
	GOTO       L_main19
;Password protection.c,121 :: 		case 10: kp = 56;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break; // 8
L_main29:
	MOVLW      56
	MOVWF      _kp+0
	MOVLW      56
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVF       _count+0, 0
	ADDLW      _given_password+0
	MOVWF      FSR
	MOVF       _kp+0, 0
	MOVWF      INDF+0
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
	GOTO       L_main19
;Password protection.c,122 :: 		case 11: kp = 57;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break; // 9
L_main30:
	MOVLW      57
	MOVWF      _kp+0
	MOVLW      57
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVF       _count+0, 0
	ADDLW      _given_password+0
	MOVWF      FSR
	MOVF       _kp+0, 0
	MOVWF      INDF+0
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
	GOTO       L_main19
;Password protection.c,123 :: 		case 12: kp = 67;Lcd_Chr_Cp(kp); break; // C
L_main31:
	MOVLW      67
	MOVWF      _kp+0
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	GOTO       L_main19
;Password protection.c,124 :: 		case 13: kp = 42;Lcd_Cmd(_LCD_MOVE_CURSOR_LEFT);count--; break; // *
L_main32:
	MOVLW      42
	MOVWF      _kp+0
	MOVLW      16
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	MOVLW      1
	SUBWF      _count+0, 1
	BTFSS      STATUS+0, 0
	DECF       _count+1, 1
	GOTO       L_main19
;Password protection.c,125 :: 		case 14: kp = 48;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break; // 0
L_main33:
	MOVLW      48
	MOVWF      _kp+0
	MOVLW      48
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVF       _count+0, 0
	ADDLW      _given_password+0
	MOVWF      FSR
	MOVF       _kp+0, 0
	MOVWF      INDF+0
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
	GOTO       L_main19
;Password protection.c,126 :: 		case 15: kp = 35;Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);count++; break; // #
L_main34:
	MOVLW      35
	MOVWF      _kp+0
	MOVLW      20
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
	GOTO       L_main19
;Password protection.c,127 :: 		case 16: kp = 68;Lcd_Chr_Cp(kp); break; // D
L_main35:
	MOVLW      68
	MOVWF      _kp+0
	MOVLW      68
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	GOTO       L_main19
;Password protection.c,129 :: 		}
L_main18:
	MOVF       _kp+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main20
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main21
	MOVF       _kp+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main22
	MOVF       _kp+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_main23
	MOVF       _kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main24
	MOVF       _kp+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main25
	MOVF       _kp+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_main26
	MOVF       _kp+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_main27
	MOVF       _kp+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_main28
	MOVF       _kp+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_main29
	MOVF       _kp+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_main30
	MOVF       _kp+0, 0
	XORLW      12
	BTFSC      STATUS+0, 2
	GOTO       L_main31
	MOVF       _kp+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_main32
	MOVF       _kp+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_main33
	MOVF       _kp+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_main34
	MOVF       _kp+0, 0
	XORLW      16
	BTFSC      STATUS+0, 2
	GOTO       L_main35
L_main19:
;Password protection.c,130 :: 		} while (1);
	GOTO       L_main5
;Password protection.c,132 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
