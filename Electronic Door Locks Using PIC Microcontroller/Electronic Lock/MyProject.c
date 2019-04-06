
 char Indata;
 char P1 = '1';
 char P2 = '2';
 char P3 = '3';
 int PassCheck = 0;
 int WrongCheck = 0;
 int CPassCheck = 0;
 

void Initialization()
{
      UART1_Init(9600);
      TRISD = 0;
      PortD = 0;
      P1 = EEPROM_Read(0x01);
      P2 = EEPROM_Read(0x02);
      P3 = EEPROM_Read(0x03);
}

void PassChange()
{
            while(1)
            {
                  if (UART1_Data_Ready())
                  {
                        Indata = UART1_Read();

                        if(CPassCheck == 2){CPassCheck = 3; EEPROM_Write(0x03, Indata); P3 = EEPROM_Read(0x03);}
                        if(CPassCheck == 1){CPassCheck = 2; EEPROM_Write(0x02, Indata); P2 = EEPROM_Read(0x02);}
                        if(CPassCheck == 0){CPassCheck = 1; EEPROM_Write(0x01, Indata); P1 = EEPROM_Read(0x01);}
                        UART1_Write_Text("*");
                        if(CPassCheck == 3){break;}
                  }
            }
            
            UART1_Write(10);
            UART1_Write(13);
            UART1_Write(10);
            UART1_Write(13);
}

void CorrectPass()
{
            UART1_Write(10);
            UART1_Write(13);
            UART1_Write(10);
            UART1_Write(13);
            UART1_Write_Text("Select one of the below Options: ");
            UART1_Write(10);
            UART1_Write(13);
            UART1_Write(10);
            UART1_Write(13);
            UART1_Write_Text("1) Press Y to Lock.");
            UART1_Write(10);
            UART1_Write(13);
            UART1_Write_Text("2) Press N to Unlock.");
            UART1_Write(10);
            UART1_Write(13);
            UART1_Write_Text("3) Press C to Change Password.");
            UART1_Write(10);
            UART1_Write(13);
            UART1_Write(10);
            UART1_Write(13);
            UART1_Write_Text("Waiting for Response: ");
            
            while(1)
            {
                  if (UART1_Data_Ready())
                  {
                        Indata = UART1_Read();

                        if((Indata == 'Y') || (Indata == 'y')){UART1_Write_Text("Y"); PortD.F0 = 1; PortD.F1 = 0; UART1_Write(10); UART1_Write(13); UART1_Write(10); UART1_Write(13); break;}
                        if((Indata == 'N') || (Indata == 'n')){UART1_Write_Text("N"); PortD.F0 = 0; PortD.F1 = 1; UART1_Write(10); UART1_Write(13); UART1_Write(10); UART1_Write(13); break;}
                        if((Indata == 'C') || (Indata == 'c')){UART1_Write_Text("C"); UART1_Write(10); UART1_Write(13); UART1_Write(10); UART1_Write(13); UART1_Write_Text("Enter New Password: "); PassChange();break;}


                  }
            }
}

void WrongPass()
{
         int x = 0;
         PortD.F5 = 1;
         while(1)
         {

             PortD.F2 = 1;
             Delay_ms(100);
             PortD.F2 = 0;
             PortD.F3 = 1;
             Delay_ms(100);
             PortD.F3 = 0;
             PortD.F4 = 1;
             Delay_ms(100);
             PortD.F4 = 0;
             x = x + 1;
             if(x > 30){break;}
         }
         PortD.F5 = 0;
}


void main() {
      Initialization();

      do
      {
          UART1_Write_Text("Enter Password: ");
          while(1)
          {
                if (UART1_Data_Ready())
                {
                      Indata = UART1_Read();

                      if((Indata == P1) && (PassCheck == 0)){PassCheck = 1;}
                      if((Indata == P2) && (PassCheck == 1)){PassCheck = 2;}
                      if((Indata == P3) && (PassCheck == 2)){PassCheck = 3;}

                      if((Indata == 13) && (PassCheck == 3)){PassCheck = 0; WrongCheck = 0; UART1_Write(10); UART1_Write(13); UART1_Write_Text("Correct Password.");CorrectPass();break;}
                      if((Indata == 13) && (PassCheck != 3)){PassCheck = 0; UART1_Write(10); UART1_Write(13); UART1_Write_Text("Wrong Password."); WrongCheck = WrongCheck + 1; if(WrongCheck == 3){WrongPass();}UART1_Write(10); UART1_Write(13); UART1_Write(10); UART1_Write(13);break;}
                      UART1_Write_Text("*");
                }
          }

      } while(1);
}