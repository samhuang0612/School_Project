		AREA question2, CODE, READWRITE
		ENTRY
		;r0 represent the result of the program, if equal 1, then the string is palindrome
		;r3 load the first character of the input string
		;r4 load the last character of the input string
		ADR r1, STRING ;point to the first character of the input string
		ADR r2, EoS    ;point to the last character of the input string
Loop
FW		LDRB r3, [r1], #1
		CMP r3,#0x00
		BEQ YES
		CMP r3, #0x41			; if the character is less than "A", then skip it beacuse it is not a character
		BLT FW			 		; loop again for next character
		CMP r3, #0x5A			; if the character is between "A" and "Z", then convert it to lower case
		ADDLE r3, #0x20			; convert it into lower case
		CMP r3, #0x7A			; it is greater than "z", the skip this letter and continute next loop
		BGT	FW					; go to next loop
BW		LDRB r4, [r2,#-1]!      ; load the last character into register
		CMP r4, #0x41			; if the character is less than "A", then skip it beacuse it is not a character
		BLT BW				    ; loop again for next character
		CMP r4, #0x5A			; if the character is between "A" and "Z", then convert it to lower case
		ADDLE r4, #0x20			; convert it into lower case
		CMP r4, #0x7A			; convert it into lower case
		BGT	BW					; it is greater than "z", the skip this letter and continute next loop
		CMP r3,r4				; if the ith legal character is equal the ith legal chacater from back then continute compare the next character
		BNE NOT
		B Loop
YES     MOV r0,#1				; if all of the character have been check then return true which means assigning value 1 to r0
		B DONE					; the program end
NOT		MOV r0,#2				; once non-equivalent character found then return false which means assigning value 2 to r0
DONE    B DONE					; since an illegal situation was found then program end 
		DCD 0x0000
STRING  DCB "He lived as a devil, eh?" ;the given UPC string
EoS 	DCB 0x00 				;end of string
		END
