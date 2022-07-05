
_main:

;MyProject.c,66 :: 		void main()
;MyProject.c,68 :: 		adcon0 = 0b00000001;                       //Seleciona o pino analógico AN0
	MOVLW      1
	MOVWF      ADCON0+0
;MyProject.c,69 :: 		TRISA = 0xff;                              //Configura todo PORTA como entrada
	MOVLW      255
	MOVWF      TRISA+0
;MyProject.c,70 :: 		TRISC = 0x00;                              //Configura todo PORTC como saída
	CLRF       TRISC+0
;MyProject.c,71 :: 		TRISD = 0x04;                              //Configura o pino RD2 como entrada
	MOVLW      4
	MOVWF      TRISD+0
;MyProject.c,72 :: 		PORTA = 0x00;                              //Inicializa os bits em low
	CLRF       PORTA+0
;MyProject.c,73 :: 		PORTC = 0x00;                              //Inicializa os bits em low
	CLRF       PORTC+0
;MyProject.c,74 :: 		PORTD = 0x01;                              //Inicializa RD0 em high
	MOVLW      1
	MOVWF      PORTD+0
;MyProject.c,76 :: 		TRISB = 0b00000011;                        //Configura entradas e saidas RB
	MOVLW      3
	MOVWF      TRISB+0
;MyProject.c,77 :: 		RB2_bit = 0x00;
	BCF        RB2_bit+0, BitPos(RB2_bit+0)
;MyProject.c,78 :: 		RB3_bit = 0x00;
	BCF        RB3_bit+0, BitPos(RB3_bit+0)
;MyProject.c,79 :: 		RB4_bit = 0x00;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;MyProject.c,80 :: 		RB5_bit = 0x00;
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
;MyProject.c,82 :: 		Lcd_Init();                                //Inicializa o display
	CALL       _Lcd_Init+0
;MyProject.c,83 :: 		Lcd_Cmd(_Lcd_Cursor_Off);                  //Apaga o cursor
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,84 :: 		Lcd_Cmd(_LCD_CLEAR);                       //Limpa o display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,86 :: 		text=("TEMPERATURA");                     //Armazena o texto na variável text
	MOVLW      ?lstr1_MyProject+0
	MOVWF      _text+0
;MyProject.c,87 :: 		lcd_out(1,3,text);                        //Escreve o texto uma vez no display, linha 1, coluna 3
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,88 :: 		text=("Temp =");                          //Armazena o texto na variável text
	MOVLW      ?lstr2_MyProject+0
	MOVWF      _text+0
;MyProject.c,89 :: 		lcd_out(2,1,text);                        //Escreve o texto uma vez no display, linha 2, coluna 1
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,92 :: 		OPTION_REG = 0b00000001;                  //Ativa resistor de pull-up e configura pre-escaler, neste caso 1:4
	MOVLW      1
	MOVWF      OPTION_REG+0
;MyProject.c,93 :: 		GIE_bit    = 0x01;                        //Habilita a int global
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;MyProject.c,94 :: 		PEIE_bit   = 0x01;                        //Habilita a int dos perifericos
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
;MyProject.c,95 :: 		T0IE_bit   = 0x01;                        //Habilita int do timer 0
	BSF        T0IE_bit+0, BitPos(T0IE_bit+0)
;MyProject.c,97 :: 		while(1)                               //Início do loop infinito
L_main0:
;MyProject.c,98 :: 		{   aux  = 0 ;
	CLRF       _aux+0
	CLRF       _aux+1
;MyProject.c,99 :: 		aux2 = 0 ;
	CLRF       _aux2+0
	CLRF       _aux2+1
;MyProject.c,100 :: 		aux3 = 0 ;
	CLRF       _aux3+0
	CLRF       _aux3+1
;MyProject.c,102 :: 		if(RD2_bit == 0)
	BTFSC      RD2_bit+0, BitPos(RD2_bit+0)
	GOTO       L_main2
;MyProject.c,104 :: 		Celsius();                          //Se RD0 estiver em low, exibe temperatura em Celsius
	CALL       _Celsius+0
;MyProject.c,105 :: 		}
	GOTO       L_main3
L_main2:
;MyProject.c,106 :: 		else   Fahrenheit();               //Se não, exibe temperatura em Fahrenheit
	CALL       _Fahrenheit+0
L_main3:
;MyProject.c,108 :: 		if(RD5_bit == 0)
	BTFSC      RD5_bit+0, BitPos(RD5_bit+0)
	GOTO       L_main4
;MyProject.c,110 :: 		Ligar ();                         //Se RD5 estiver em low, Liga a saida principal
	CALL       _Ligar+0
;MyProject.c,111 :: 		}
	GOTO       L_main5
L_main4:
;MyProject.c,112 :: 		else   Desliga();                 //Desliga todas as saida principal
	CALL       _Desliga+0
L_main5:
;MyProject.c,114 :: 		if(RD6_bit == 0)
	BTFSC      RD6_bit+0, BitPos(RD6_bit+0)
	GOTO       L_main6
;MyProject.c,116 :: 		Liga_Saida1();                 //Se RD6 estiver emm low, Liga a saida 1
	CALL       _Liga_Saida1+0
;MyProject.c,117 :: 		}
	GOTO       L_main7
L_main6:
;MyProject.c,118 :: 		else  Des_Saida1();              //Desliga a saida 1
	CALL       _Des_Saida1+0
L_main7:
;MyProject.c,120 :: 		if(RD7_bit == 0)
	BTFSC      RD7_bit+0, BitPos(RD7_bit+0)
	GOTO       L_main8
;MyProject.c,122 :: 		Liga_Saida2();                //Se RD7_bit estiver emm low, Liga a saida 2
	CALL       _Liga_Saida2+0
;MyProject.c,123 :: 		}
	GOTO       L_main9
L_main8:
;MyProject.c,124 :: 		else Des_Saida2();              //Desliga a saida 2
	CALL       _Des_Saida2+0
L_main9:
;MyProject.c,126 :: 		if(RB0_bit == 0)                   //Checa sensor do shampoo
	BTFSC      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_main10
;MyProject.c,128 :: 		RB2_bit = 1;
	BSF        RB2_bit+0, BitPos(RB2_bit+0)
;MyProject.c,129 :: 		TMR0 = 0x00; //inicia timer
	CLRF       TMR0+0
;MyProject.c,130 :: 		aux = 1;
	MOVLW      1
	MOVWF      _aux+0
	MOVLW      0
	MOVWF      _aux+1
;MyProject.c,131 :: 		}
L_main10:
;MyProject.c,133 :: 		if(RB1_bit == 0)                   //Checa sensor do shampoo
	BTFSC      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_main11
;MyProject.c,135 :: 		RB5_bit = 1;
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
;MyProject.c,136 :: 		TMR0 = 0x00; //inicia timer
	CLRF       TMR0+0
;MyProject.c,137 :: 		aux2 = 1;
	MOVLW      1
	MOVWF      _aux2+0
	MOVLW      0
	MOVWF      _aux2+1
;MyProject.c,138 :: 		}
L_main11:
;MyProject.c,142 :: 		} //end while
	GOTO       L_main0
;MyProject.c,143 :: 		} //end main
L_end_main:
	GOTO       $+0
; end of _main

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,145 :: 		void interrupt()
;MyProject.c,147 :: 		if (T0IF_bit)                //Houve estouro do timer 0 ?
	BTFSS      T0IF_bit+0, BitPos(T0IF_bit+0)
	GOTO       L_interrupt12
;MyProject.c,149 :: 		T0IF_bit = 0x00;         //Reseta o flag da interrupcao
	BCF        T0IF_bit+0, BitPos(T0IF_bit+0)
;MyProject.c,150 :: 		TMR1L = 0xDC;            //Reinicia contagem com 3036
	MOVLW      220
	MOVWF      TMR1L+0
;MyProject.c,151 :: 		TMR1H = 0x0B;
	MOVLW      11
	MOVWF      TMR1H+0
;MyProject.c,153 :: 		conta++;
	INCF       _conta+0, 1
	BTFSC      STATUS+0, 2
	INCF       _conta+1, 1
;MyProject.c,154 :: 		aux3++;
	INCF       _aux3+0, 1
	BTFSC      STATUS+0, 2
	INCF       _aux3+1, 1
;MyProject.c,155 :: 		if( aux = 1){
	MOVLW      1
	MOVWF      _aux+0
	MOVLW      0
	MOVWF      _aux+1
;MyProject.c,156 :: 		if (conta==30000)         //1us * 4 * 256  =  1,024ms  * 30000 ~= 6s
	MOVF       _conta+1, 0
	XORLW      117
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt30
	MOVLW      48
	XORWF      _conta+0, 0
L__interrupt30:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt14
;MyProject.c,158 :: 		RB2_bit = 0;            //Para o motor
	BCF        RB2_bit+0, BitPos(RB2_bit+0)
;MyProject.c,159 :: 		conta = 0;              //Reseta timer
	CLRF       _conta+0
	CLRF       _conta+1
;MyProject.c,160 :: 		RB3_bit = 1;            //Inicia o motor para outro lado
	BSF        RB3_bit+0, BitPos(RB3_bit+0)
;MyProject.c,161 :: 		delay_ms(6000);         //Conta 6s
	MOVLW      61
	MOVWF      R11+0
	MOVLW      225
	MOVWF      R12+0
	MOVLW      63
	MOVWF      R13+0
L_interrupt15:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt15
	DECFSZ     R12+0, 1
	GOTO       L_interrupt15
	DECFSZ     R11+0, 1
	GOTO       L_interrupt15
	NOP
	NOP
;MyProject.c,162 :: 		RB3_bit = 0;            //Para o motor
	BCF        RB3_bit+0, BitPos(RB3_bit+0)
;MyProject.c,164 :: 		}
L_interrupt14:
;MyProject.c,167 :: 		if( aux2 = 1){
	MOVLW      1
	MOVWF      _aux2+0
	MOVLW      0
	MOVWF      _aux2+1
;MyProject.c,168 :: 		if (aux3 ==30000)         //1us * 4 * 256  =  1,024ms  * 30000 ~= 6s
	MOVF       _aux3+1, 0
	XORLW      117
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt31
	MOVLW      48
	XORWF      _aux3+0, 0
L__interrupt31:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt17
;MyProject.c,170 :: 		RB5_bit = 0;            //Para o motor
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
;MyProject.c,171 :: 		aux3 = 0;              //Reseta timer
	CLRF       _aux3+0
	CLRF       _aux3+1
;MyProject.c,172 :: 		RB4_bit = 1;            //Inicia o motor para outro lado
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
;MyProject.c,173 :: 		delay_ms(6000);         //Conta 6s
	MOVLW      61
	MOVWF      R11+0
	MOVLW      225
	MOVWF      R12+0
	MOVLW      63
	MOVWF      R13+0
L_interrupt18:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt18
	DECFSZ     R12+0, 1
	GOTO       L_interrupt18
	DECFSZ     R11+0, 1
	GOTO       L_interrupt18
	NOP
	NOP
;MyProject.c,174 :: 		RB4_bit = 0;            //Para o motor
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;MyProject.c,176 :: 		}
L_interrupt17:
;MyProject.c,178 :: 		}
L_interrupt12:
;MyProject.c,179 :: 		return;
;MyProject.c,180 :: 		}
L_end_interrupt:
L__interrupt29:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_Ligar:

;MyProject.c,182 :: 		void Ligar()
;MyProject.c,184 :: 		RD3_bit = 0x01;                //Liga o led indicativo da saida principal
	BSF        RD3_bit+0, BitPos(RD3_bit+0)
;MyProject.c,185 :: 		RD4_bit = 0x00;                //Deliga o led de standy_by
	BCF        RD4_bit+0, BitPos(RD4_bit+0)
;MyProject.c,186 :: 		}
L_end_Ligar:
	RETURN
; end of _Ligar

_Desliga:

;MyProject.c,187 :: 		void Desliga()
;MyProject.c,189 :: 		RD4_bit = 0x01;
	BSF        RD4_bit+0, BitPos(RD4_bit+0)
;MyProject.c,190 :: 		RD3_bit = 0x00;
	BCF        RD3_bit+0, BitPos(RD3_bit+0)
;MyProject.c,191 :: 		}
L_end_Desliga:
	RETURN
; end of _Desliga

_Liga_Saida1:

;MyProject.c,193 :: 		void Liga_Saida1()
;MyProject.c,195 :: 		RD0_bit = 0x01;
	BSF        RD0_bit+0, BitPos(RD0_bit+0)
;MyProject.c,196 :: 		}
L_end_Liga_Saida1:
	RETURN
; end of _Liga_Saida1

_Liga_Saida2:

;MyProject.c,198 :: 		void Liga_Saida2()
;MyProject.c,200 :: 		RD1_bit = 0x01;
	BSF        RD1_bit+0, BitPos(RD1_bit+0)
;MyProject.c,201 :: 		}
L_end_Liga_Saida2:
	RETURN
; end of _Liga_Saida2

_Des_Saida1:

;MyProject.c,203 :: 		void Des_Saida1()
;MyProject.c,205 :: 		RD0_bit = 0x00;
	BCF        RD0_bit+0, BitPos(RD0_bit+0)
;MyProject.c,206 :: 		}
L_end_Des_Saida1:
	RETURN
; end of _Des_Saida1

_Des_Saida2:

;MyProject.c,208 :: 		void Des_Saida2()
;MyProject.c,210 :: 		RD1_bit = 0x00;
	BCF        RD1_bit+0, BitPos(RD1_bit+0)
;MyProject.c,211 :: 		}
L_end_Des_Saida2:
	RETURN
; end of _Des_Saida2

_Celsius:

;MyProject.c,213 :: 		void Celsius()
;MyProject.c,215 :: 		store = average_temp();                       //atribui a média de 100 medidas à variável store
	CALL       _average_temp+0
	MOVF       R0+0, 0
	MOVWF      _store+0
	MOVF       R0+1, 0
	MOVWF      _store+1
	MOVF       R0+2, 0
	MOVWF      _store+2
	MOVF       R0+3, 0
	MOVWF      _store+3
;MyProject.c,216 :: 		t_Celsius = (store*vdd*factor)/ad_resolution; //converte o valor para escala Celsius
	MOVLW      5
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVLW      100
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__Celsius+8
	MOVF       R0+1, 0
	MOVWF      FLOC__Celsius+9
	MOVF       R0+2, 0
	MOVWF      FLOC__Celsius+10
	MOVF       R0+3, 0
	MOVWF      FLOC__Celsius+11
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FLOC__Celsius+8, 0
	MOVWF      R0+0
	MOVF       FLOC__Celsius+9, 0
	MOVWF      R0+1
	MOVF       FLOC__Celsius+10, 0
	MOVWF      R0+2
	MOVF       FLOC__Celsius+11, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__Celsius+0
	MOVF       R0+1, 0
	MOVWF      FLOC__Celsius+1
	MOVF       R0+2, 0
	MOVWF      FLOC__Celsius+2
	MOVF       R0+3, 0
	MOVWF      FLOC__Celsius+3
	MOVF       FLOC__Celsius+0, 0
	MOVWF      _t_Celsius+0
	MOVF       FLOC__Celsius+1, 0
	MOVWF      _t_Celsius+1
	MOVF       FLOC__Celsius+2, 0
	MOVWF      _t_Celsius+2
	MOVF       FLOC__Celsius+3, 0
	MOVWF      _t_Celsius+3
;MyProject.c,220 :: 		dezena = t_Celsius/10;
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FLOC__Celsius+0, 0
	MOVWF      R0+0
	MOVF       FLOC__Celsius+1, 0
	MOVWF      R0+1
	MOVF       FLOC__Celsius+2, 0
	MOVWF      R0+2
	MOVF       FLOC__Celsius+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__Celsius+4
	MOVF       R0+1, 0
	MOVWF      FLOC__Celsius+5
	MOVF       R0+2, 0
	MOVWF      FLOC__Celsius+6
	MOVF       R0+3, 0
	MOVWF      FLOC__Celsius+7
	MOVF       FLOC__Celsius+4, 0
	MOVWF      _dezena+0
;MyProject.c,221 :: 		unidade = t_Celsius % 10;
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FLOC__Celsius+0, 0
	MOVWF      R0+0
	MOVF       FLOC__Celsius+1, 0
	MOVWF      R0+1
	MOVF       FLOC__Celsius+2, 0
	MOVWF      R0+2
	MOVF       FLOC__Celsius+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      _unidade+0
;MyProject.c,222 :: 		dec1 = (((store*vdd*factor)%ad_resolution)*10)/ad_resolution;
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FLOC__Celsius+8, 0
	MOVWF      R0+0
	MOVF       FLOC__Celsius+9, 0
	MOVWF      R0+1
	MOVF       FLOC__Celsius+10, 0
	MOVWF      R0+2
	MOVF       FLOC__Celsius+11, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__Celsius+0
	MOVF       R0+1, 0
	MOVWF      FLOC__Celsius+1
	MOVF       R0+2, 0
	MOVWF      FLOC__Celsius+2
	MOVF       R0+3, 0
	MOVWF      FLOC__Celsius+3
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FLOC__Celsius+0, 0
	MOVWF      R0+0
	MOVF       FLOC__Celsius+1, 0
	MOVWF      R0+1
	MOVF       FLOC__Celsius+2, 0
	MOVWF      R0+2
	MOVF       FLOC__Celsius+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _dec1+0
;MyProject.c,223 :: 		dec2 = (((((store*vdd*factor)%ad_resolution)*10)%ad_resolution)*10)/ad_resolution;
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FLOC__Celsius+0, 0
	MOVWF      R0+0
	MOVF       FLOC__Celsius+1, 0
	MOVWF      R0+1
	MOVF       FLOC__Celsius+2, 0
	MOVWF      R0+2
	MOVF       FLOC__Celsius+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _dec2+0
;MyProject.c,225 :: 		disp_t;              //chama a macro
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      FLOC__Celsius+4, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
	MOVLW      48
	ADDWF      _unidade+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVLW      48
	ADDWF      _dec1+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVLW      48
	ADDWF      _dec2+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVLW      2
	MOVWF      FARG_CustomChar_pos_row+0
	MOVLW      14
	MOVWF      FARG_CustomChar_pos_char+0
	CALL       _CustomChar+0
;MyProject.c,227 :: 		Lcd_Out(2,15,"C");   //escreve "C" de Celsius no display
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,228 :: 		delay_ms(800);       //taxa de atualização do display e das medidas
	MOVLW      9
	MOVWF      R11+0
	MOVLW      30
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_Celsius19:
	DECFSZ     R13+0, 1
	GOTO       L_Celsius19
	DECFSZ     R12+0, 1
	GOTO       L_Celsius19
	DECFSZ     R11+0, 1
	GOTO       L_Celsius19
	NOP
;MyProject.c,229 :: 		}
L_end_Celsius:
	RETURN
; end of _Celsius

_Fahrenheit:

;MyProject.c,231 :: 		void Fahrenheit()
;MyProject.c,233 :: 		store = average_temp();                       //atribui a média de 100 medidas à variável store
	CALL       _average_temp+0
	MOVF       R0+0, 0
	MOVWF      _store+0
	MOVF       R0+1, 0
	MOVWF      _store+1
	MOVF       R0+2, 0
	MOVWF      _store+2
	MOVF       R0+3, 0
	MOVWF      _store+3
;MyProject.c,234 :: 		t_Celsius = (store*vdd*factor)/ad_resolution; //converte o valor para escala Celsius
	MOVLW      5
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVLW      100
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__Fahrenheit+8
	MOVF       R0+1, 0
	MOVWF      FLOC__Fahrenheit+9
	MOVF       R0+2, 0
	MOVWF      FLOC__Fahrenheit+10
	MOVF       R0+3, 0
	MOVWF      FLOC__Fahrenheit+11
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FLOC__Fahrenheit+8, 0
	MOVWF      R0+0
	MOVF       FLOC__Fahrenheit+9, 0
	MOVWF      R0+1
	MOVF       FLOC__Fahrenheit+10, 0
	MOVWF      R0+2
	MOVF       FLOC__Fahrenheit+11, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _t_Celsius+0
	MOVF       R0+1, 0
	MOVWF      _t_Celsius+1
	MOVF       R0+2, 0
	MOVWF      _t_Celsius+2
	MOVF       R0+3, 0
	MOVWF      _t_Celsius+3
;MyProject.c,236 :: 		t_Fahrenheit = (t_Celsius*1.8)+32;            //converte temperatura em Celsius para Fahrenheit
	CALL       _longword2double+0
	MOVLW      102
	MOVWF      R4+0
	MOVLW      102
	MOVWF      R4+1
	MOVLW      102
	MOVWF      R4+2
	MOVLW      127
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _double2longword+0
	MOVF       R0+0, 0
	MOVWF      FLOC__Fahrenheit+0
	MOVF       R0+1, 0
	MOVWF      FLOC__Fahrenheit+1
	MOVF       R0+2, 0
	MOVWF      FLOC__Fahrenheit+2
	MOVF       R0+3, 0
	MOVWF      FLOC__Fahrenheit+3
	MOVF       FLOC__Fahrenheit+0, 0
	MOVWF      _t_Fahrenheit+0
	MOVF       FLOC__Fahrenheit+1, 0
	MOVWF      _t_Fahrenheit+1
	MOVF       FLOC__Fahrenheit+2, 0
	MOVWF      _t_Fahrenheit+2
	MOVF       FLOC__Fahrenheit+3, 0
	MOVWF      _t_Fahrenheit+3
;MyProject.c,240 :: 		dezena = t_Fahrenheit/10;
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FLOC__Fahrenheit+0, 0
	MOVWF      R0+0
	MOVF       FLOC__Fahrenheit+1, 0
	MOVWF      R0+1
	MOVF       FLOC__Fahrenheit+2, 0
	MOVWF      R0+2
	MOVF       FLOC__Fahrenheit+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__Fahrenheit+4
	MOVF       R0+1, 0
	MOVWF      FLOC__Fahrenheit+5
	MOVF       R0+2, 0
	MOVWF      FLOC__Fahrenheit+6
	MOVF       R0+3, 0
	MOVWF      FLOC__Fahrenheit+7
	MOVF       FLOC__Fahrenheit+4, 0
	MOVWF      _dezena+0
;MyProject.c,241 :: 		unidade = t_Fahrenheit % 10;
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FLOC__Fahrenheit+0, 0
	MOVWF      R0+0
	MOVF       FLOC__Fahrenheit+1, 0
	MOVWF      R0+1
	MOVF       FLOC__Fahrenheit+2, 0
	MOVWF      R0+2
	MOVF       FLOC__Fahrenheit+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      _unidade+0
;MyProject.c,242 :: 		dec1 = (((store*vdd*factor)%ad_resolution)*10)/ad_resolution;
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FLOC__Fahrenheit+8, 0
	MOVWF      R0+0
	MOVF       FLOC__Fahrenheit+9, 0
	MOVWF      R0+1
	MOVF       FLOC__Fahrenheit+10, 0
	MOVWF      R0+2
	MOVF       FLOC__Fahrenheit+11, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__Fahrenheit+0
	MOVF       R0+1, 0
	MOVWF      FLOC__Fahrenheit+1
	MOVF       R0+2, 0
	MOVWF      FLOC__Fahrenheit+2
	MOVF       R0+3, 0
	MOVWF      FLOC__Fahrenheit+3
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FLOC__Fahrenheit+0, 0
	MOVWF      R0+0
	MOVF       FLOC__Fahrenheit+1, 0
	MOVWF      R0+1
	MOVF       FLOC__Fahrenheit+2, 0
	MOVWF      R0+2
	MOVF       FLOC__Fahrenheit+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _dec1+0
;MyProject.c,243 :: 		dec2 = (((((store*vdd*factor)%ad_resolution)*10)%ad_resolution)*10)/ad_resolution;
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FLOC__Fahrenheit+0, 0
	MOVWF      R0+0
	MOVF       FLOC__Fahrenheit+1, 0
	MOVWF      R0+1
	MOVF       FLOC__Fahrenheit+2, 0
	MOVWF      R0+2
	MOVF       FLOC__Fahrenheit+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _dec2+0
;MyProject.c,245 :: 		disp_t;              //chama a macro
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      FLOC__Fahrenheit+4, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
	MOVLW      48
	ADDWF      _unidade+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVLW      48
	ADDWF      _dec1+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVLW      48
	ADDWF      _dec2+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVLW      2
	MOVWF      FARG_CustomChar_pos_row+0
	MOVLW      14
	MOVWF      FARG_CustomChar_pos_char+0
	CALL       _CustomChar+0
;MyProject.c,247 :: 		Lcd_Out(2,15,"F");   //escreve "F" de Fahrenheit no display
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,250 :: 		delay_ms(800);       //taxa de atualização do display e das medidas
	MOVLW      9
	MOVWF      R11+0
	MOVLW      30
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_Fahrenheit20:
	DECFSZ     R13+0, 1
	GOTO       L_Fahrenheit20
	DECFSZ     R12+0, 1
	GOTO       L_Fahrenheit20
	DECFSZ     R11+0, 1
	GOTO       L_Fahrenheit20
	NOP
;MyProject.c,252 :: 		}
L_end_Fahrenheit:
	RETURN
; end of _Fahrenheit

_average_temp:

;MyProject.c,254 :: 		long average_temp()
;MyProject.c,257 :: 		unsigned long temp_store = 0;
	CLRF       average_temp_temp_store_L0+0
	CLRF       average_temp_temp_store_L0+1
	CLRF       average_temp_temp_store_L0+2
	CLRF       average_temp_temp_store_L0+3
;MyProject.c,259 :: 		for(i=0; i<100; i++)
	CLRF       average_temp_i_L0+0
L_average_temp21:
	MOVLW      100
	SUBWF      average_temp_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_average_temp22
;MyProject.c,261 :: 		temp_store += ADC_Read(0); //temp_store = temp_store + ADC_Read(0) (faz o somatório das 100 iterações
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVLW      0
	MOVWF      R0+2
	MOVWF      R0+3
	MOVF       average_temp_temp_store_L0+0, 0
	ADDWF      R0+0, 1
	MOVF       average_temp_temp_store_L0+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     average_temp_temp_store_L0+1, 0
	ADDWF      R0+1, 1
	MOVF       average_temp_temp_store_L0+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     average_temp_temp_store_L0+2, 0
	ADDWF      R0+2, 1
	MOVF       average_temp_temp_store_L0+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     average_temp_temp_store_L0+3, 0
	ADDWF      R0+3, 1
	MOVF       R0+0, 0
	MOVWF      average_temp_temp_store_L0+0
	MOVF       R0+1, 0
	MOVWF      average_temp_temp_store_L0+1
	MOVF       R0+2, 0
	MOVWF      average_temp_temp_store_L0+2
	MOVF       R0+3, 0
	MOVWF      average_temp_temp_store_L0+3
;MyProject.c,259 :: 		for(i=0; i<100; i++)
	INCF       average_temp_i_L0+0, 1
;MyProject.c,262 :: 		}
	GOTO       L_average_temp21
L_average_temp22:
;MyProject.c,264 :: 		return(temp_store/100); //retorna a média das iterações
	MOVLW      100
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       average_temp_temp_store_L0+0, 0
	MOVWF      R0+0
	MOVF       average_temp_temp_store_L0+1, 0
	MOVWF      R0+1
	MOVF       average_temp_temp_store_L0+2, 0
	MOVWF      R0+2
	MOVF       average_temp_temp_store_L0+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
;MyProject.c,265 :: 		}
L_end_average_temp:
	RETURN
; end of _average_temp

_CustomChar:

;MyProject.c,267 :: 		void CustomChar(char pos_row, char pos_char)  //função gerada pelo mikroC para imprimir caracteres especiais
;MyProject.c,270 :: 		Lcd_Cmd(64);
	MOVLW      64
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,271 :: 		for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
	CLRF       CustomChar_i_L0+0
L_CustomChar24:
	MOVF       CustomChar_i_L0+0, 0
	SUBLW      7
	BTFSS      STATUS+0, 0
	GOTO       L_CustomChar25
	MOVF       CustomChar_i_L0+0, 0
	ADDLW      _character+0
	MOVWF      R0+0
	MOVLW      hi_addr(_character+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	INCF       CustomChar_i_L0+0, 1
	GOTO       L_CustomChar24
L_CustomChar25:
;MyProject.c,272 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW      2
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,273 :: 		Lcd_Chr(pos_row, pos_char, 0);
	MOVF       FARG_CustomChar_pos_row+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       FARG_CustomChar_pos_char+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	CLRF       FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,274 :: 		}
L_end_CustomChar:
	RETURN
; end of _CustomChar
