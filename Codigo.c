/*
        Chuveiro Smart

        AUTOR: Bruno Antonelli 20150457

        UFSC 2020
*/

//Comunicação entre o PIC e o display
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
//end comunicação


//Funções auxiliares
void Celsius();                               //temperatura na escala Celsius
void Fahrenheit();                            //temperatura na escala Fahrenheit
void CustomChar(char pos_row, char pos_char); //função que escreve o caractere especial de "graus" no display
long average_temp();                          //função auxiliar retorna a média das tempeturas de 100 iterações
void Ligar();
void Desliga();
void Liga_Saida1();
void Liga_Saida2();
void Des_Saida1();
void Des_Saida2();
  /* code */

//end funções auxiliares


//Diretivas
#define ad_resolution 1023                    //resolução PICF877A
#define vdd           5                       //alimentação TTL
#define factor        100                     //fator de correção do sensor LM35
//end diretivas


//Macro (concatena cada dígito referente à temperatura lida, precisão de duas casas decimais)
#define disp_t  lcd_chr(2,9,dezena+48);    lcd_chr_cp(unidade+48); \
                lcd_chr_cp('.');           lcd_chr_cp(dec1+48);    \
                lcd_chr_cp(dec2+48);       CustomChar(2,14);
//end macro
 #pragma config FOSC = HS  //define uso do clock externo em 4 ou 20mhz

//Variáveis
unsigned long store, t_Celsius, t_Fahrenheit; //variáveis armazenam as grandezas de temperatura
unsigned char dezena, unidade, dec1, dec2;    //dígitos para utilizar na macro e exibir no display
unsigned char *text;                          //Variável que armazena textos para escrever no display
const char character[] = {6,9,6,0,0,0,0,0};   //caractere especial de "graus"
int conta =0, aux = 0, aux2 = 0, aux3 = 0 ;
//end variáveis



//Função principal
void main()
{
   adcon0 = 0b00000001;                       //Seleciona o pino analógico AN0
   TRISA = 0xff;                              //Configura todo PORTA como entrada
   TRISC = 0x00;                              //Configura todo PORTC como saída
   TRISD = 0x04;                              //Configura o pino RD2 como entrada
   PORTA = 0x00;                              //Inicializa os bits em low
   PORTC = 0x00;                              //Inicializa os bits em low
   PORTD = 0x01;                              //Inicializa RD0 em high

   TRISB = 0b00000011;                        //Configura entradas e saidas RB
   RB2_bit = 0x00;
   RB3_bit = 0x00;
   RB4_bit = 0x00;
   RB5_bit = 0x00;

   Lcd_Init();                                //Inicializa o display
   Lcd_Cmd(_Lcd_Cursor_Off);                  //Apaga o cursor
   Lcd_Cmd(_LCD_CLEAR);                       //Limpa o display

   text=("TEMPERATURA");                     //Armazena o texto na variável text
   lcd_out(1,3,text);                        //Escreve o texto uma vez no display, linha 1, coluna 3
   text=("Temp =");                          //Armazena o texto na variável text
   lcd_out(2,1,text);                        //Escreve o texto uma vez no display, linha 2, coluna 1

   //interrupts
   OPTION_REG = 0b00000001;                  //Ativa resistor de pull-up e configura pre-escaler, neste caso 1:4
   GIE_bit    = 0x01;                        //Habilita a int global
   PEIE_bit   = 0x01;                        //Habilita a int dos perifericos
   T0IE_bit   = 0x01;                        //Habilita int do timer 0

      while(1)                               //Início do loop infinito
      {   aux  = 0 ;
          aux2 = 0 ;
          aux3 = 0 ;

          if(RD2_bit == 0)
           {
         Celsius();                          //Se RD0 estiver em low, exibe temperatura em Celsius
           }
          else   Fahrenheit();               //Se não, exibe temperatura em Fahrenheit

          if(RD5_bit == 0)
           {
          Ligar ();                          //Se RD5 estiver em low, Liga a saida principal
           }
          else   Desliga();                  //Desliga todas as saida principal

          if(RD6_bit == 0)
          {
            Liga_Saida1();                  //Se RD6 estiver emm low, Liga a saida 1
          }
          else  Des_Saida1();               //Desliga a saida 1

          if(RD7_bit == 0)
          {
            Liga_Saida2();                   //Se RD7_bit estiver emm low, Liga a saida 2
          }
          else Des_Saida2();                 //Desliga a saida 2

          if(RB0_bit == 0)                   //Checa sensor do shampoo
          {
              RB2_bit = 1;
              TMR0 = 0x00; //inicia timer
              aux = 1;
          }

          if(RB1_bit == 0)                   //Checa sensor do shampoo
          {
              RB5_bit = 1;
              TMR0 = 0x00; //inicia timer
              aux2 = 1;
          }



    } //end while
} //end main

void interrupt()
{
    if (T0IF_bit)                //Houve estouro do timer 0 ?
    {
        T0IF_bit = 0x00;         //Reseta o flag da interrupcao
        TMR1L = 0xDC;            //Reinicia contagem com 3036
        TMR1H = 0x0B;
        //comandos pra tratar a interrupcao
        conta++;
        aux3++;
        if( aux = 1){
          if (conta==30000)         //1us * 4 * 256  =  1,024ms  * 30000 ~= 6s
           {
             RB2_bit = 0;            //Para o motor 1
             conta = 0;              //Reseta timer
             RB3_bit = 1;            //Inicia o motor para outro lado
             delay_ms(6000);         //Conta 6s
             RB3_bit = 0;            //Para o motor

        }
        }

        if( aux2 = 1){
          if (aux3 ==30000)         //1us * 4 * 256  =  1,024ms  * 30000 ~= 6s
           {
             RB5_bit = 0;            //Para o motor 1
             aux3 = 0;              //Reseta timer
             RB4_bit = 1;            //Inicia o motor para outro lado
             delay_ms(6000);         //Conta 6s
             RB4_bit = 0;            //Para o motor

        }
        }
    }
    return;
}

void Ligar()
{
     RD3_bit = 0x01;                //Liga o led indicativo da saida principal
     RD4_bit = 0x00;                //Deliga o led de standy_by
}
void Desliga()
{
     RD4_bit = 0x01;                //Liga o led de standy_by
     RD3_bit = 0x00;                //Desliga o led indicatio da saida principal
}

void Liga_Saida1()
{
     RD0_bit = 0x01;                //Liga o led indicativo da saida 1
}

void Liga_Saida2()
{
     RD1_bit = 0x01;                //Liga o led indicativo da saida 2
}

void Des_Saida1()
{
    RD0_bit = 0x00;                //Desliga o led indicativo da saida 1
}

void Des_Saida2()
{
    RD1_bit = 0x00;                //Liga o led indicativo da saida 2
}

void Celsius()
{
               store = average_temp();                       //atribui a média de 100 medidas à variável store
               t_Celsius = (store*vdd*factor)/ad_resolution; //converte o valor para escala Celsius


                           //as 4 linhas seguintes separam os dígitos do valor em dezena, unidade e mais duas casas decimais
               dezena = t_Celsius/10;
               unidade = t_Celsius % 10;
               dec1 = (((store*vdd*factor)%ad_resolution)*10)/ad_resolution;
               dec2 = (((((store*vdd*factor)%ad_resolution)*10)%ad_resolution)*10)/ad_resolution;

               disp_t;              //chama a macro

               Lcd_Out(2,15,"C");   //escreve "C" de Celsius no display
               delay_ms(800);       //taxa de atualização do display e das medidas
}

void Fahrenheit()
{
               store = average_temp();                       //atribui a média de 100 medidas à variável store
               t_Celsius = (store*vdd*factor)/ad_resolution; //converte o valor para escala Celsius

               t_Fahrenheit = (t_Celsius*1.8)+32;            //converte temperatura em Celsius para Fahrenheit


                           //as 4 linhas seguintes separam os dígitos do valor em dezena, unidade e mais duas casas decimais
               dezena  = t_Fahrenheit/10;
               unidade = t_Fahrenheit % 10;
               dec1    = (((store*vdd*factor)%ad_resolution)*10)/ad_resolution;
               dec2    = (((((store*vdd*factor)%ad_resolution)*10)%ad_resolution)*10)/ad_resolution;

               disp_t;              //chama a macro

               Lcd_Out(2,15,"F");   //escreve "F" de Fahrenheit no display


               delay_ms(800);       //taxa de atualização do display e das medidas

}

long average_temp()
{
     unsigned char i;
     unsigned long temp_store = 0;

     for(i=0; i<100; i++)
     {
              temp_store += ADC_Read(0); //temp_store = temp_store + ADC_Read(0) (faz o somatório das 100 iterações
     }

     return(temp_store/100); //retorna a média das iterações
}

void CustomChar(char pos_row, char pos_char)  //função gerada pelo mikroC para imprimir caracteres especiais
{
    char i;
    Lcd_Cmd(64);
    for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
    Lcd_Cmd(_LCD_RETURN_HOME);
    Lcd_Chr(pos_row, pos_char, 0);
}
