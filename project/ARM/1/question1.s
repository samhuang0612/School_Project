			AREA question1, CODE,READWRITE
			ENTRY
			;r0 point to the top of the string
			;r3 the time of loop
			;r1 First sum
			;r5 Store element for first sum
			;r2 Second sum
			;r4 Store element for second sum
			;r6 the last digit of the string
			ADR r0, UPC
loop_Count	MOV r3, #5      	 ;set r3 to 5 means loop 5 time totally 					
Loop1 		LDRB r4,[r0,#1]! 	 ;i points the number of the string
			ADD r2,r2,r4	 	 ;add the the number to second sum 		
			LDRB r5,[r0,#1]! 
			SUB r5,r5,#0x30 	 ;recalculate the element by minus 30 since the element is stored as a string that store by ASCII table
			ADD	r1,r1,r5		 ;add it to first sum		
			SUBS r3,r3,#1 		 ;decrease the time of loop left
			BNE Loop1
			ADD r1,r1,r1, LSL #1 ;Multiplying the first sum by 3
			ADD r1,r1,r2		 ;sum the first sum and the second sum together and store in r1
			SUB r1,r1,#151		 ;Subtracting 151 since r2 didn't decrease 30 at first and total need 5 decreasement 
Loop2		SUB r1,#10			 ;minus 10 each time 
			CMP	r1,#9			 ;indentity the size of number after minus 10
			BGT Loop2			 ;until the number is not larger than 9
			RSB r1,r1,#0x39		 ;Remainder is subtracted from 39 since the last number will not be decreased 30 later
			LDRB r6,[r0,#1]!	 ;r6 point to last element of string
			CMP r6,r1			 ;check if r6 equals r1
			BEQ  VALID			 ;if r6 equals r1, then branch to VALID
			MOV r0,#2			 ;if r6 does not equal r1, then assign r0 to #2
UPC			DCB "013800150738"	 ;the given UPC string
EXIT		B 	EXIT
VALID		MOV r0,#1			 ;if it is valid, assign r0 to #1
			END
