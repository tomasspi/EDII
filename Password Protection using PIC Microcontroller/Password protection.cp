#line 1 "C:/Users/zain/Desktop/Password protection/Password protection.c"
unsigned short kp;
char actual_password[] = "123123";
char given_password[] = "000000";
int count;

sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;



char keypadPort at PORTD;


void Password_prompt(){
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Motor is Off");
 Lcd_Out(2,1,"and Locked");
 Delay_ms(1000);

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Enter 6 digit no:");

 Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
 Lcd_Cmd(_LCD_SECOND_ROW);
}


void Init(){
Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, "Welcome to");
 Lcd_Out(2, 1, "Password Lock");
 Lcd_Out(3, 2, "www.TheEngineering");
 Lcd_Out(4, 5,"Projects.com");

 Delay_ms(5000);
 Password_prompt();
 TRISB=0;

count=0;
Keypad_Init();
}



int Check_password(){

Lcd_Cmd(_LCD_CLEAR);
if(!memcmp(actual_password, given_password, 6)){
 Lcd_Out(1, 1, "Password Matched");
 Lcd_Out(2,1,"Motor is on");

 return 1;
}
else{
 Lcd_Out(1, 1, "Incorrect Password");
 Lcd_Out(2, 1, "Try Again!");

 Delay_ms(2000);
 Password_prompt();
 return 0;

 }
 count=0;
}


void main() {
 Init();
 do {
 kp = 0;
 if(count==6)
 {
 PORTB.B7=Check_password();
 count=0;
 if(PORTB.B7==1){
 Delay_ms(1000);
 Lcd_Cmd(_LCD_CLEAR);

 Lcd_Out(1,1,"Press * to Off");
 Lcd_Out(2,1,"and Lock again");
 Lcd_Cmd(_LCD_CURSOR_OFF);

 do

 kp = Keypad_Key_Click();
 while (kp!=13);
 if(kp==13){
 PORTB.B7=0;
 Password_prompt();
 }
 }
 }

 do

 kp = Keypad_Key_Click();
 while (!kp);
 switch (kp) {
 case 1: kp = 49;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break;
 case 2: kp = 50;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break;
 case 3: kp = 51;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break;
 case 4: kp = 65;Lcd_Chr_Cp(kp); break;
 case 5: kp = 52;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break;
 case 6: kp = 53;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break;
 case 7: kp = 54;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break;
 case 8: kp = 66;Lcd_Chr_Cp(kp); break;
 case 9: kp = 55;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break;
 case 10: kp = 56;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break;
 case 11: kp = 57;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break;
 case 12: kp = 67;Lcd_Chr_Cp(kp); break;
 case 13: kp = 42;Lcd_Cmd(_LCD_MOVE_CURSOR_LEFT);count--; break;
 case 14: kp = 48;Lcd_Chr_Cp(kp);given_password[count]=kp;count++; break;
 case 15: kp = 35;Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);count++; break;
 case 16: kp = 68;Lcd_Chr_Cp(kp); break;

 }
 } while (1);

}
