; bcd-addition.asm
; CSC 230: Fall 2022
;
; Code provided for Assignment #1
;
; Mike Zastre (2022-Sept-22)

; This skeleton of an assembly-language program is provided to help you
; begin with the programming task for A#1, part (c). In this and other
; files provided through the semester, you will see lines of code
; indicating "DO NOT TOUCH" sections. You are *not* to modify the
; lines within these sections. The only exceptions are for specific
; changes announced on conneX or in written permission from the course
; instructor. *** Unapproved changes could result in incorrect code
; execution during assignment evaluation, along with an assignment grade
; of zero. ****
;
; In a more positive vein, you are expected to place your code with the
; area marked "STUDENT CODE" sections.

; ==== BEGINNING OF "DO NOT TOUCH" SECTION ====
; Your task: Two packed-BCD numbers are provided in R16
; and R17. You are to add the two numbers together, such
; the the rightmost two BCD "digits" are stored in R25
; while the carry value (0 or 1) is stored R24.
;
; For example, we know that 94 + 9 equals 103. If
; the digits are encoded as BCD, we would have
;   *  0x94 in R16
;   *  0x09 in R17
; with the result of the addition being:
;   * 0x03 in R25
;   * 0x01 in R24
;
; Similarly, we know than 35 + 49 equals 84. If 
; the digits are encoded as BCD, we would have
;   * 0x35 in R16
;   * 0x49 in R17
; with the result of the addition being:
;   * 0x84 in R25
;   * 0x00 in R24
;

; ANY SIGNIFICANT IDEAS YOU FIND ON THE WEB THAT HAVE HELPED
; YOU DEVELOP YOUR SOLUTION MUST BE CITED AS A COMMENT (THAT
; IS, WHAT THE IDEA IS, PLUS THE URL).



    .cseg
    .org 0

	; Some test cases below for you to try. And as usual
	; your solution is expected to work with values other
	; than those provided here.
	;
	; Your code will always be tested with legal BCD
	; values in r16 and r17 (i.e. no need for error checking).

	; 94 + 9 = 03, carry = 1
	; ldi r16, 0x94
	; ldi r17, 0x09

	; 86 + 79 = 65, carry = 1
	; ldi r16, 0x86
	; ldi r17, 0x79

	; 35 + 49 = 84, carry = 0
	; ldi r16, 0x35
	; ldi r17, 0x49

	; 32 + 41 = 73, carry = 0
	ldi r16, 0x32
	ldi r17, 0x41

; ==== END OF "DO NOT TOUCH" SECTION ==========

; **** BEGINNING OF "STUDENT CODE" SECTION **** 
	
	mov r18, r16	;copy r16 to r18
	mov r19, r17	;copy r17 to r19
	ldi r20, 6		;load 6 to r20

	cbr r16, $F0	;clear upper nibble of r18
	cbr r17, $F0	;clear upper nibble of r17
	add r16, r17	;add r16 and r17, result in r16

	loop:
		cpi r16, 10		;compare r16 with 10
		brlt less		;branch if r18 < 10
		add r16, r20	;if r18 >= 10, add r16 and r20
		ldi r21, 1		;load 1 to r21 (carry)
		cbr r16, $F0	;clear upper nibble of r18
		rjmp loop

	less: nop

	swap r18		;swap high and low nibble of r18
	swap r19		;swap high and low nibble of r19
	cbr r18, $F0	;clear upper nibble of r18
	cbr r19, $F0	;clear upper nibble of r19
	add r18, r19	;add r18 and r19, result in r18

	loop2:
		cpi r21, 1		;compare r21 with 1
		breq carry		;branch if r21 = 1
		cpi r18, 10		;compare r18 with 10
		brlt less2		;branch if r18 < 10
		add r18, r20	;if r18 >= 10. add r18 and r20
		ldi r24, 1		;carry = 1
		cbr r18, $F0	;clear upper nibble of r18
		rjmp loop2

	carry: 
		add r18, r21	;add r18 and r21. result in r18
		ldi r21, 0		;load 0 to r21
		rjmp loop2	

	less2: nop

	swap r18		;swap high and low nibble of r18
	mov r25, r16	;copy r16 to r25
	add r25, r18	;add r25 and r18, result in r25




; **** END OF "STUDENT CODE" SECTION ********** 

; ==== BEGINNING OF "DO NOT TOUCH" SECTION ====
bcd_addition_end:
	rjmp bcd_addition_end



; ==== END OF "DO NOT TOUCH" SECTION ==========

