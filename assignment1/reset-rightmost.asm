; reset-rightmost.asm
; CSC 230: Fall 2022
;
; Code provided for Assignment #1
;
; Mike Zastre (2022-Sept-22)

; This skeleton of an assembly-language program is provided to help you
; begin with the programming task for A#1, part (b). In this and other
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
; Your task: You are to take the bit sequence stored in R16,
; and to reset the rightmost contiguous sequence of set
; by storing this new value in R25. For example, given
; the bit sequence 0b01011100, resetting the right-most
; contigous sequence of set bits will produce 0b01000000.
; As another example, given the bit sequence 0b10110110,
; the result will be 0b10110000.
;
; Your solution must work, of course, for bit sequences other
; than those provided in the example. (How does your
; algorithm handle a value with no set bits? with all set bits?)

; ANY SIGNIFICANT IDEAS YOU FIND ON THE WEB THAT HAVE HELPED
; YOU DEVELOP YOUR SOLUTION MUST BE CITED AS A COMMENT (THAT
; IS, WHAT THE IDEA IS, PLUS THE URL).

    .cseg
    .org 0

; ==== END OF "DO NOT TOUCH" SECTION ==========

	ldi R16, 0b01011100
	; ldi R16, 0b10110110


	; THE RESULT **MUST** END UP IN R25

; **** BEGINNING OF "STUDENT CODE" SECTION **** 

; Your solution here.

	ldi r17, 0x00	;load 0 to r17
	ldi r18, 0x00	;load 0 to r18

	loop:
		sbrc r16, 0	;skip if bit 0 in r16 cleared
		brne clear	;only executed if bit 0 in r16 is not cleared
		cpi r18,1	;compare r19 with 1
		breq shift	;branch if r19 = 1
		lsr r16		;logical shift right r16
		inc r17		;increment r17
		brne loop	;loop

	clear:
		cbr r16, 1	;clear bit 0 in r16
		sbrs r16, 1	;skip if bit 1 in r16 is set
		ldi r18, 1	;load 1 to r18
		lsr r16		;logical shift right r16
		inc r17		;increment r17
		brne loop	;loop

	shift:
		dec r17		;decrement r17
		lsl r16		;logical shift left r16
		cpi r17, 0	;compare r17 with 0
		brne shift	;branch if r17 != 0 
		nop

	mov r25, r16	;copy r16 to r25

; **** END OF "STUDENT CODE" SECTION ********** 



; ==== BEGINNING OF "DO NOT TOUCH" SECTION ====
reset_rightmost_stop:
    rjmp reset_rightmost_stop


; ==== END OF "DO NOT TOUCH" SECTION ==========