;Lishan Huang
;250777962
;cs2208 assignment4
            AREA question1, CODE, READWRITE
			ENTRY
			
final		EQU 0x00;    ;store the end of string
INPUT		EQU STRING1  ;store string1 in INPUT
OUTPUT		EQU STRING2	;store string2 in OUTPUT
t			EQU 0x74  ;store ASCII number of t in t
h	   		EQU 0x68  ;store ASCII number of h in h
e			EQU 0x65  ;store ASCII number of e in e
s			EQU 0x20  ;store ASCII number of space in s
	
			ADR r0,INPUT  ;store the address of INPUT into r0
			ADR r1,OUTPUT ;store the address of OUTPUT into r1
Loop		LDRB r2,[r0]  ;store the element of first element in r0
			CMP  r2,#t    ;compare the first element in string
			BNE	STORE     ;if the first element of the word is not f then the whole word is not the ,then jump to store and store the element
			LDRB r3,[r0,#1] ;if the first element of the word is f then read the second element 
			CMP r3,#h       ;check whether if it is h   
			BNE	STORE       ; if the second element is not h then jump to store 
			LDRB r4,[r0,#2] ;if the second element is h then store the third element in r4 
			CMP  r4,#e      ;check  if the third element is e
			BNE	STORE       ;if it the thrid element is not e then jump to store
			LDRB r5,[r0,#3] ;if the thrid element is e then check if it is the end of the word
			CMP r5,#s       ; if the forth element is space then it is a word 'the'
			LDRBEQ  r2,[r0,#3]! ;if it is space,then store it in r2 
			BEQ    SPACE       ;if it is space,then jump to space check next element if is also space
			CMP  r5,#final	   ;if the end of the word is final, then it also is the end of string
			BEQ  STOP  		   ;if it is the end of string, then jump to stop
STORE       STRB r2,[r1],#1 ;since the word is not the, store the word in output
			LDRB r2,[r0,#1]!;load the next element
			CMP  r2,#final  ;check if the next element is  the end of string
			BEQ STOP		;if it is the end of stringm, then jump to stop
			CMP  r2,#s      ;compare the if it is space
			BNE	 STORE      ;if it is then keep store it 
SPACE		LDRB  r3,[r0,#1];check the next element 
			CMP  r3,#s      ;compare the next elment if is space
			BEQ  STORE      ;if it is space the store it
			STRB r2,[r1],#1  ;if the next element is not space, means next is a new word, then store the space
			LDRB r2,[r0],#1  ; then check the first element of new word
			B  	 Loop        ;keep loop
STOP		B    STOP		 ;finish check

STRING1 	DCB   "the the the 123 the" ;String1
EoS  		DCB   0x00 ;end of string1
STRING2 	space 0xFF ;just allocating 255 bytes 
			END
				

 
