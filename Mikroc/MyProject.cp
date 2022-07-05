#line 1 "C:/Users/oHaxixero/Documents/UFSC/micro/Projeto final/Mikroc/MyProject.c"
#line 10 "C:/Users/oHaxixero/Documents/UFSC/micro/Projeto final/Mikroc/MyProject.c"
sbit LCD_RS at RC2_bit;
sbit LCD_EN at RC3_bit;
sbit LCD_D4 at RC4_bit;
sbit LCD_D5 at RC5_bit;
sbit LCD_D6 at RC6_bit;
sbit LCD_D7 at RC7_bit;

sbit LCD_RS_Direction at TRISC2_bit;
sbit LCD_EN_Direction at TRISC3_bit;
sbit LCD_D4_Direction at TRISC4_bit;
sbit LCD_D5_Direction at TRISC5_bit;
sbit LCD_D6_Direction at TRISC6_bit;
sbit LCD_D7_Direction at TRISC7_bit;




void Celsius();
void Fahrenheit();
void CustomChar(char pos_row, char pos_char);
long average_temp();
void Ligar();
void Desliga();
void Liga_Saida1();
void Liga_Saida2();
void Des_Saida1();
void Des_Saida2();
#pragma config FOSC = HS
#line 57 "C:/Users/oHaxixero/Documents/UFSC/micro/Projeto final/Mikroc/MyProject.c"
unsigned long store, t_Celsius, t_Fahrenheit;
unsigned char dezena, unidade, dec1, dec2;
unsigned char *text;
const char character[] = {6,9,6,0,0,0,0,0};

int conta =0, aux = 0, aux2 = 0, aux3 = 0 ;



void main()
{
 adcon0 = 0b00000001;
 TRISA = 0xff;
 TRISC = 0x00;
 TRISD = 0x04;
 PORTA = 0x00;
 PORTC = 0x00;
 PORTD = 0x01;

 TRISB = 0b00000011;
 RB2_bit = 0x00;
 RB3_bit = 0x00;
 RB4_bit = 0x00;
 RB5_bit = 0x00;

 Lcd_Init();
 Lcd_Cmd(_Lcd_Cursor_Off);
 Lcd_Cmd(_LCD_CLEAR);

 text=("TEMPERATURA");
 lcd_out(1,3,text);
 text=("Temp =");
 lcd_out(2,1,text);


 OPTION_REG = 0b00000001;
 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 T0IE_bit = 0x01;

 while(1)
 { aux = 0 ;
 aux2 = 0 ;
 aux3 = 0 ;

 if(RD2_bit == 0)
 {
 Celsius();
 }
 else Fahrenheit();

 if(RD5_bit == 0)
 {
 Ligar ();
 }
 else Desliga();

 if(RD6_bit == 0)
 {
 Liga_Saida1();
 }
 else Des_Saida1();

 if(RD7_bit == 0)
 {
 Liga_Saida2();
 }
 else Des_Saida2();

 if(RB0_bit == 0)
 {
 RB2_bit = 1;
 TMR0 = 0x00;
 aux = 1;
 }

 if(RB1_bit == 0)
 {
 RB5_bit = 1;
 TMR0 = 0x00;
 aux2 = 1;
 }



 }
}

void interrupt()
{
 if (T0IF_bit)
 {
 T0IF_bit = 0x00;
 TMR1L = 0xDC;
 TMR1H = 0x0B;

 conta++;
 aux3++;
 if( aux = 1){
 if (conta==30000)
 {
 RB2_bit = 0;
 conta = 0;
 RB3_bit = 1;
 delay_ms(6000);
 RB3_bit = 0;

 }
 }

 if( aux2 = 1){
 if (aux3 ==30000)
 {
 RB5_bit = 0;
 aux3 = 0;
 RB4_bit = 1;
 delay_ms(6000);
 RB4_bit = 0;

 }
 }
 }
 return;
}

void Ligar()
{
 RD3_bit = 0x01;
 RD4_bit = 0x00;
}
void Desliga()
{
 RD4_bit = 0x01;
 RD3_bit = 0x00;
}

void Liga_Saida1()
{
 RD0_bit = 0x01;
}

void Liga_Saida2()
{
 RD1_bit = 0x01;
}

void Des_Saida1()
{
 RD0_bit = 0x00;
}

void Des_Saida2()
{
 RD1_bit = 0x00;
}

void Celsius()
{
 store = average_temp();
 t_Celsius = (store* 5 * 100 )/ 1023 ;



 dezena = t_Celsius/10;
 unidade = t_Celsius % 10;
 dec1 = (((store* 5 * 100 )% 1023 )*10)/ 1023 ;
 dec2 = (((((store* 5 * 100 )% 1023 )*10)% 1023 )*10)/ 1023 ;

  lcd_chr(2,9,dezena+48); lcd_chr_cp(unidade+48); lcd_chr_cp('.'); lcd_chr_cp(dec1+48); lcd_chr_cp(dec2+48); CustomChar(2,14); ;

 Lcd_Out(2,15,"C");
 delay_ms(800);
}

void Fahrenheit()
{
 store = average_temp();
 t_Celsius = (store* 5 * 100 )/ 1023 ;

 t_Fahrenheit = (t_Celsius*1.8)+32;



 dezena = t_Fahrenheit/10;
 unidade = t_Fahrenheit % 10;
 dec1 = (((store* 5 * 100 )% 1023 )*10)/ 1023 ;
 dec2 = (((((store* 5 * 100 )% 1023 )*10)% 1023 )*10)/ 1023 ;

  lcd_chr(2,9,dezena+48); lcd_chr_cp(unidade+48); lcd_chr_cp('.'); lcd_chr_cp(dec1+48); lcd_chr_cp(dec2+48); CustomChar(2,14); ;

 Lcd_Out(2,15,"F");


 delay_ms(800);

}

long average_temp()
{
 unsigned char i;
 unsigned long temp_store = 0;

 for(i=0; i<100; i++)
 {
 temp_store += ADC_Read(0);
 }

 return(temp_store/100);
}

void CustomChar(char pos_row, char pos_char)
{
 char i;
 Lcd_Cmd(64);
 for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
 Lcd_Cmd(_LCD_RETURN_HOME);
 Lcd_Chr(pos_row, pos_char, 0);
}
