/*PERSEC_A EQU R4
PERSEC_B EQU 30H
SEC_A EQU R2
SEC_B EQU 31H
MIN_A EQU R3
MIN_B EQU 32H
	
ORG 0000H
LJMP MAIN
ORG 000BH         //NGAT TIMER 0
LJMP NGAT_T0
ORG 001BH   	  //NGAT TIMER 1
LJMP NGAT_T1
////////////////////////////////////////////////////////////////////////////////////
MAIN:
    CLR p3.4
    MOV TMOD,#11H
	MOV IE,#10001010B
	MOV PERSEC_A,#99
	MOV PERSEC_B,#99
	MOV SEC_A,#0
	MOV SEC_B,#0
	MOV MIN_A,#0
	MOV MIN_B,#0
	LJMP SETTIME
///////////////////
START:
START_1: 
ACALL BCDTOLED7
 
PLAY_A:
setb P3.4
mov R7,#250
djnz r7,$
	clr P3.4
	ACALL BUTTON
	ACALL DL_LED
	CLR TR1
	MOV TL0,#LOW(-7348)
	ACALL KTRA
	MOV TH0,#HIGH(-7348)
	ACALL KTRA
	SETB TR0
	LJMP COUNT1_A
	COUNT3_A:       
	MOV SEC_A,#59            
	COUNT2_A:                
	MOV PERSEC_A,#99          
	COUNT1_A:				
    ACALL HEXTOBCD_A
	ACALL KTRA
	ACALL BCDTOLED7
	ACALL KTRA
	MOV A,PERSEC_A                
	CJNE A,#0,COUNT1_A
	CLR C
	DEC SEC_A
	MOV A,SEC_A
	CJNE A,#0FFH,COUNT2_A 
	DEC MIN_A
	MOV A,MIN_A
	CJNE A,#0FFH,COUNT3_A
	CLR TR0
    LCALL SPEAKER
	LJMP ENDD
	
PLAY_B: ;;;;B CHOI (NGAT)
setb P3.4
mov R7,#250
djnz r7,$
	clr P3.4

	ACALL BUTTON
	CLR TR0
	ACALL KTRA
	MOV TL1,#LOW(-7330)
	MOV TH1,#HIGH(-7330)
	SETB TR1
	LJMP COUNT1_B
	COUNT3_B:                
	MOV SEC_B,#59             
	COUNT2_B:
	MOV PERSEC_B,#99          
	COUNT1_B:
    ACALL HEXTOBCD_B
	ACALL BCDTOLED7
	ACALL KTRA
	MOV A,PERSEC_B            
	CJNE A,#0,COUNT1_B
	CLR C
	DEC SEC_B
	MOV A,SEC_B
	CJNE A,#0FFH,COUNT2_B ; =-1 THI NHAY
	CLR C
	DEC MIN_B
	MOV A,MIN_B
	CJNE A,#0H,COUNT3_B
	CLR TR1
	LCALL SPEAKER
	LJMP ENDD
	
	SPEAKER:
    PUSH ACC
	MOV A,SEC_A
	ORL A,MIN_A
	JNZ NEXT1
	SETB P3.4
	LJMP STOP
	NEXT1:
	MOV A,SEC_B
	ORL A,MIN_B
	JNZ NEXT
	SETB P3.4
	LJMP STOP
	NEXT:POP ACC 
	RET
	
KTRA: JB P0.2, NOTHING_0
	LJMP PLAY_A
	NOTHING_0: JB P0.3,NOTHING_1
	LJMP PLAY_B
	NOTHING_1: RET
	
	STOP: 
	LJMP MAIN
//////////////////////////////////////////////////////////////////////////
HEXTOBCD_A:                               //////23H 22H : 21H 20H (HIEN THI)////// A
    MOV A,SEC_A                             //////27H 26H : 25H 24H (HIEN THI)////// B
    MOV B,#10
    DIV AB
    MOV 20H,B            
    MOV 21H,A              
    MOV A,MIN_A
    MOV B,#10
    DIV AB
    MOV 22H,B           
    MOV 23H,A
	RET
HEXTOBCD_B:                               //////23H 22H : 21H 20H (HIEN THI)////// A
	MOV A,SEC_B                             //////27H 26H : 25H 24H (HIEN THI)////// B
    MOV B,#10
    DIV AB
    MOV 24H,B            
    MOV 25H,A              
    MOV A,MIN_B
    MOV B,#10
    DIV AB
    MOV 26H,B           
    MOV 27H,A      
	RET
//////////////////////////////////////////////////////////////////////////
BCDTOLED7:
    MOV DPTR,#MALED7
LED_P27:
	MOV A,20H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.7            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.7
LED_P26:
	MOV A,21H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.6            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.6
LED_P25:
	MOV A,22H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.5            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.5
LED_P24:
	MOV A,23H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.4            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.4
LED_P23:
	MOV A,24H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.3            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.3
LED_P22:
	MOV A,25H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.2            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.2
LED_P21:
	MOV A,26H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.1            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.1
LED_P20:
	MOV A,27H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.0            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.0

RET
///////////////////////////////////////////////////////////////////////
SETTIME:
    ACALL HEXTOBCD_A
	ACALL DISPLAY_SETTIME
	ACALL BCDTOLED7
	JNB P3.0,X1
	JB P3.6,SETTIME
	ACALL BUTTON   ;an nut p3.6
	INC MIN_A
	MOV A,MIN_A
	MOV MIN_B,MIN_A
	CJNE A,#60,SETTIME
	MOV MIN_A,#0
	MOV MIN_B,#0
	SJMP SETTIME
	X1: LCALL BCDTOLED7
	    LCALL KTRA
		JMP X1

RET
///////////////////
DISPLAY_SETTIME:   
	MOV 24H,20H
	MOV 25H,21H
	MOV 26H,22H
	MOV 27H,23H
RET
///////////////////

DL_LED:
	MOV 39H,#150
	DL_1: DJNZ 39H,DL_1
	RET
//////////////////
BUTTON:
	MOV 3AH,#250
	BT_2: MOV 3BH,#250
    BT_1: NOP
		  NOP
	DJNZ  3BH,BT_1
	DJNZ 3AH,BT_2
	RET
//////////////////
BUTTON_0:
	MOV 3AH,#200
	BT0_2: MOV 3BH,#250
    BT0_1: NOP
		  NOP
	DJNZ  3BH,BT0_1
	DJNZ 3AH,BT0_2
	RET
//////////////////
NGAT_T1:
CLR TR1
MOV TL1,#LOW(-7348)
MOV TH1,#HIGH(-7348)
DEC PERSEC_B
SETB TR1
LCALL SPEAKER
RETI

NGAT_T0:
CLR TR0
MOV TL0,#LOW(-7348)
MOV TH0,#HIGH(-7348)
DEC PERSEC_A
SETB TR0
LCALL SPEAKER
RETI

/////////////////////
MALED7:
DB 0C0H,0F9H,0A4H,0B0H,099H,92H,082H,0F8H,080H,090H
	ENDD: SJMP $
END*/
/*PERSEC_A EQU R4
PERSEC_B EQU 30H
SEC_A EQU R2
SEC_B EQU 31H
MIN_A EQU R3
MIN_B EQU 32H
	
ORG 0000H
LJMP MAIN
ORG 000BH         //NGAT TIMER 0
LJMP NGAT_T0
ORG 001BH   	  //NGAT TIMER 1
LJMP NGAT_T1
////////////////////////////////////////////////////////////////////////////////////
MAIN:
    MOV TMOD,#11H
	MOV IE,#10001010B
	MOV PERSEC_A,#99
	MOV PERSEC_B,#99
	MOV SEC_A,#0
	MOV SEC_B,#0
	MOV MIN_A,#0
	MOV MIN_B,#0
	LJMP SETTIME
///////////////////
START:
START_1: 
ACALL BCDTOLED7
PLAY_A:
	ACALL BUTTON
	ACALL DL_LED
	CLR TR1
	MOV TL0,#LOW(-7348)
	MOV TH0,#HIGH(-7348)
	SETB TR0
	LJMP COUNT1_A
	COUNT3_A:       
	MOV SEC_A,#59            
	COUNT2_A:                
	MOV PERSEC_A,#99          
	COUNT1_A:				
    ACALL HEXTOBCD_A
	ACALL BCDTOLED7
	ACALL KTRA
	MOV A,PERSEC_A                
	CJNE A,#0,COUNT1_A
	CLR C
	DEC SEC_A
	MOV A,SEC_A
	CJNE A,#0FFH,COUNT2_A 
	DEC MIN_A
	MOV A,MIN_A
	CJNE A,#0FFH,COUNT3_A
	CLR TR0
	LJMP ENDD
PLAY_B: ;;;;B CHOI (NGAT)
	ACALL BUTTON
	CLR TR0
	MOV TL1,#LOW(-7330)
	MOV TH1,#HIGH(-7330)
	SETB TR1
	LJMP COUNT1_B
	COUNT3_B:                
	MOV SEC_B,#59             
	COUNT2_B:
	MOV PERSEC_B,#99          
	COUNT1_B:
    ACALL HEXTOBCD_B
	ACALL BCDTOLED7
	ACALL KTRA
	MOV A,PERSEC_B            
	CJNE A,#0,COUNT1_B
	CLR C
	DEC SEC_B
	MOV A,SEC_B
	CJNE A,#0FFH,COUNT2_B ; =-1 THI NHAY
	CLR C
	DEC MIN_B
	MOV A,MIN_B
	CJNE A,#0H,COUNT3_B
	CLR TR1
	LJMP ENDD
KTRA: JB P0.2, NOTHING_0
	LJMP PLAY_A
	NOTHING_0: JB P0.3,NOTHING_1
	LJMP PLAY_B
	NOTHING_1: JB P3.0, NOTHING_2
	LCALL BUTTON_0
	STOP: LCALL BCDTOLED7
	JB P3.0,STOP
	LCALL BUTTON_0
	
	NOTHING_2: RET
//////////////////////////////////////////////////////////////////////////
HEXTOBCD_A:                               //////23H 22H : 21H 20H (HIEN THI)////// A
    MOV A,SEC_A                             //////27H 26H : 25H 24H (HIEN THI)////// B
    MOV B,#10
    DIV AB
    MOV 20H,B            
    MOV 21H,A              
    MOV A,MIN_A
    MOV B,#10
    DIV AB
    MOV 22H,B           
    MOV 23H,A  
	RET
HEXTOBCD_B:                               //////23H 22H : 21H 20H (HIEN THI)////// A
	MOV A,SEC_B                             //////27H 26H : 25H 24H (HIEN THI)////// B
    MOV B,#10
    DIV AB
    MOV 24H,B            
    MOV 25H,A              
    MOV A,MIN_B
    MOV B,#10
    DIV AB
    MOV 26H,B           
    MOV 27H,A      
	RET
//////////////////////////////////////////////////////////////////////////
BCDTOLED7:
    MOV DPTR,#MALED7
LED_P27:
	MOV A,20H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.7            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.7
LED_P26:
	MOV A,21H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.6            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.6
LED_P25:
	MOV A,22H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.5            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.5
LED_P24:
	MOV A,23H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.4            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.4
LED_P23:
	MOV A,24H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.3            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.3
LED_P22:
	MOV A,25H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.2            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.2
LED_P21:
	MOV A,26H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.1            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.1
LED_P20:
	MOV A,27H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.0            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.0
RET
///////////////////////////////////////////////////////////////////////
SETTIME:
    ACALL HEXTOBCD_A
	ACALL DISPLAY_SETTIME
	ACALL BCDTOLED7
	JNB P3.0,X1
	JB P3.6,SETTIME
	ACALL BUTTON   ;an nut p3.6
	INC MIN_A
	MOV A,MIN_A
	MOV MIN_B,MIN_A
	CJNE A,#60,SETTIME
	MOV MIN_A,#0
	MOV MIN_B,#0
	SJMP SETTIME
	X1: LJMP PLAY_A
RET
///////////////////
DISPLAY_SETTIME:   
	MOV 24H,20H
	MOV 25H,21H
	MOV 26H,22H
	MOV 27H,23H
RET
///////////////////

DL_LED:
	MOV 39H,#150
	DL_1: DJNZ 39H,DL_1
	RET
//////////////////
BUTTON:
	MOV 3AH,#253
	BT_2: MOV 3BH,#250
    BT_1: NOP
		  NOP
	DJNZ  3BH,BT_1
	DJNZ 3AH,BT_2
	RET
//////////////////
BUTTON_0:
	MOV 3AH,#25
	BT0_2: MOV 3BH,#250
    BT0_1: NOP
		  NOP
	DJNZ  3BH,BT0_1
	DJNZ 3AH,BT0_2
	RET
//////////////////
NGAT_T1:
CLR TR1
MOV TL1,#LOW(-7348)
MOV TH1,#HIGH(-7348)
DEC PERSEC_B
SETB TR1
RETI
NGAT_T0:
CLR TR0
MOV TL0,#LOW(-7348)
MOV TH0,#HIGH(-7348)
DEC PERSEC_A
SETB TR0
RETI

/////////////////////
MALED7:
DB 0C0H,0F9H,0A4H,0B0H,099H,92H,082H,0F8H,080H,090H
	ENDD: SJMP $
END*/
PERSEC_A EQU R4
PERSEC_B EQU 30H
SEC_A EQU R2
SEC_B EQU 31H
MIN_A EQU R3
MIN_B EQU 32H
	
ORG 0000H
/*LJMP MAIN
ORG 000BH         //NGAT TIMER 0
LJMP NGAT_T0
ORG 001BH   	  //NGAT TIMER 1
LJMP NGAT_T1*/
////////////////////////////////////////////////////////////////////////////////////
MAIN:
    CLR P3.4
    MOV TMOD,#11H
	/*MOV IE,#10001010B*/
	MOV PERSEC_A,#99
	MOV PERSEC_B,#99
	MOV SEC_A,#0
	MOV SEC_B,#0
	MOV MIN_A,#0
	MOV MIN_B,#0
	LJMP SETTIME
///////////////////
START:
START_1: 
ACALL BCDTOLED7
jb P0.2, tiep
ljmp PLAY_A
tiep: jb P0.3,tiep1
ljmp PLAY_B
tiep1:
JMP START
 
PLAY_A:
setb P3.4
mov R7,#250
djnz r7,$ 
	clr P3.4
	ACALL BUTTON
	ACALL DL_LED
	LJMP COUNT1_A
	COUNT3_A:       
	MOV SEC_A,#59            
	COUNT2_A:                
	MOV PERSEC_A,#99          
	COUNT1_A:		
    DEC PERSEC_A 
	MOV TL1,#LOW(-7500)
	MOV TH1,#HIGH(-7500)
	SETB TR1
	JNB TF1,$
		CLR TR1
		CLR TF1
    ACALL HEXTOBCD_A
	ACALL BCDTOLED7
	ACALL KTRA
	MOV A,PERSEC_A                
	CJNE A,#0,COUNT1_A
	CLR C
	DEC SEC_A
	MOV A,SEC_A
	CJNE A,#0FFH,COUNT2_A 
	DEC MIN_A
	MOV A,MIN_A
	CJNE A,#0FFH,COUNT3_A
	CLR TR0
    LCALL SPEAKER
	LCALL KTRA
	LJMP PLAY_A
	
PLAY_B: ;;;;B CHOI (NGAT)
setb P3.4
mov R7,#250
djnz r7,$
	clr P3.4
	ACALL BUTTON
	ACALL DL_LED
	LJMP COUNT1_B
	COUNT3_B:                
	MOV SEC_B,#59             
	COUNT2_B:
	MOV PERSEC_B,#99          
	COUNT1_B:
	DEC PERSEC_B
	MOV TL1,#LOW(-7500)
	MOV TH1,#HIGH(-7500)
	SETB TR1
	JNB TF1,$
		CLR TR1
		CLR TF1
    ACALL HEXTOBCD_B
	ACALL BCDTOLED7
	ACALL KTRA
	MOV A,PERSEC_B            
	CJNE A,#0,COUNT1_B
	CLR C
	DEC SEC_B
	MOV A,SEC_B
	CJNE A,#0FFH,COUNT2_B ; =-1 THI NHAY
	CLR C
	DEC MIN_B
	MOV A,MIN_B
	CJNE A,#0H,COUNT3_B
	CLR TR1
	LCALL SPEAKER
	LCALL KTRA
	LJMP PLAY_B
	
	SPEAKER:
	SETB P3.4
	LCALL BUTTON
	LJMP STOP
	RET
	
KTRA: JB P0.2, NOTHING_0
	LJMP PLAY_A
	NOTHING_0: JB P0.3,NOTHING_1
	LJMP PLAY_B
	NOTHING_1: RET
	
	STOP: 
	LJMP MAIN
//////////////////////////////////////////////////////////////////////////
HEXTOBCD_A:                               //////23H 22H : 21H 20H (HIEN THI)////// A
    MOV A,SEC_A                             //////27H 26H : 25H 24H (HIEN THI)////// B
    MOV B,#10
    DIV AB
    MOV 20H,B            
    MOV 21H,A              
    MOV A,MIN_A
    MOV B,#10
    DIV AB
    MOV 22H,B           
    MOV 23H,A
	RET
HEXTOBCD_B:                               //////23H 22H : 21H 20H (HIEN THI)////// A
	MOV A,SEC_B                             //////27H 26H : 25H 24H (HIEN THI)////// B
    MOV B,#10
    DIV AB
    MOV 24H,B            
    MOV 25H,A              
    MOV A,MIN_B
    MOV B,#10
    DIV AB
    MOV 26H,B           
    MOV 27H,A      
	RET
//////////////////////////////////////////////////////////////////////////
BCDTOLED7:
    MOV DPTR,#MALED7
LED_P27:
	MOV A,20H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.7            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.7
LED_P26:
	MOV A,21H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.6            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.6
LED_P25:
	MOV A,22H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.5            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.5
LED_P24:
	MOV A,23H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.4            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.4
LED_P23:
	MOV A,24H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.3            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.3
LED_P22:
	MOV A,25H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.2            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.2
LED_P21:
	MOV A,26H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.1            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.1
LED_P20:
	MOV A,27H
	MOVC A,@A+DPTR       ;;chuyen bcd thanh led7
	MOV P1,A             ;;chan gtri cua led7
	SETB P2.0            ;;hien thi ledB
	ACALL DL_LED
	;ACALL KTRA
	CLR P2.0

RET
///////////////////////////////////////////////////////////////////////
SETTIME:
    ACALL HEXTOBCD_A
	ACALL DISPLAY_SETTIME
	ACALL BCDTOLED7
	JNB P3.0,X1
	JB P3.6,SETTIME
	ACALL BUTTON   ;an nut p3.6
	INC MIN_A
	MOV A,MIN_A
	MOV MIN_B,MIN_A
	CJNE A,#60,SETTIME
	MOV MIN_A,#0
	SJMP SETTIME
	X1: LCALL BCDTOLED7
	    LCALL KTRA
		JMP X1

ljmp start
///////////////////
DISPLAY_SETTIME:   
	MOV 24H,20H
	MOV 25H,21H
	MOV 26H,22H
	MOV 27H,23H
RET
///////////////////

DL_LED:
	MOV 39H,#150
	DL_1: DJNZ 39H,DL_1
	RET
//////////////////
BUTTON:
	MOV 3AH,#200
	BT_2: MOV 3BH,#250
    BT_1: NOP
		  NOP
	DJNZ  3BH,BT_1
	DJNZ 3AH,BT_2
	RET
//////////////////
BUTTON_0:
	MOV 3AH,#200
	BT0_2: MOV 3BH,#250
    BT0_1: NOP
		  NOP
	DJNZ  3BH,BT0_1
	DJNZ 3AH,BT0_2
	RET
//////////////////
/*NGAT_T1:
CLR TR1
MOV TL1,#LOW(-7500)
MOV TH1,#HIGH(-7500)
DEC PERSEC_B
SETB TR1
RETI

NGAT_T0:
CLR TR0
MOV TL0,#LOW(-7500)
MOV TH0,#HIGH(-7500)
DEC PERSEC_A
SETB TR0
RETI*/

/////////////////////
MALED7:
DB 0C0H,0F9H,0A4H,0B0H,099H,92H,082H,0F8H,080H,090H
	ENDD: SJMP $
END