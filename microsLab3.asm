INCLUDE<P18F4321.INC>
;create variables
sum1 equ 0x030
sum2 equ 0x031
A1 equ 0x020
A2 equ 0x021
B1 equ 0x022
B2 equ 0x023
temp equ 0x24
	CLRF sum1
	CLRF sum2
	
	;move 37h into wreg
	MOVLW 0x37
	;and 37h with 0000 1111 or 0Fh
	ANDLW 0x0F
	;move the anded value from wreg into location 0x21 
	MOVWF 0x21

	;move 31h into wreg
	MOVLW 0x31
	;and contents of wreg 31h with 0Fh
	ANDLW 0x0F
	;move the anded value from wreg into location 0x23
	MOVWF 0x23

	;move 30h into wreg
	MOVLW 0x30
	;move data from wreg into location 20
	MOVWF 0x20
	;in location 20, flip the first 4 bits with the last 4 bits of the 8 bit number and store the flipped value into wreg
	SWAPF 0x20, W
	;and the flipped value in wreg with F0h or 1111 0000
	ANDLW 0xF0
	;move the anded value from wreg into location 0x20
	MOVWF 0x20

	;move 31h into wreg
	MOVLW 0x31
	;move data from wreg into location 22
	MOVWF 0x22
	;in location 22, flip the first 4 bits with the last 4 bits of the 8 bit number and store the flipped value into wreg
	SWAPF 0x22, W
	;and the flipped value in wreg with F0h
	ANDLW 0xF0
	;move the final value from wreg into location 22
	MOVWF 0x22

	;move the contents of location 21 into wreg
	MOVF 0x21, W
	;add the contents of location 23 with the contents of wreg and store it in wreg
	ADDWF 0x23, W
	;recorrect from hex to decimal
	DAW
	;since we anded 0x21 and 0x23 with 0Fh, this addition leaves us with a 4 bit number that is the ones place in decimal
	;move the final sum from wreg into the variable sum1
	MOVWF sum1

	;move the contents of 0x20 into wreg
	MOVF 0x20, W
	;add the contents of 0x22 with the contents of wreg and store the value in wreg
	ADDWF 0x22, W

	;check to see if there is a carry flag and branch to the CARRYHERE case if there is a carry flag
	BC CARRYHERE
BACK:

	;add the contents of sum1 with the contents of wreg and store the value in wreg
	ADDWF sum1, W
	;re ajust from hex to decimal
	DAW
	;move the contents of wreg into sum1
	MOVWF sum1

	;load 0 into wreg
	MOVLW 0x00
	;add 1 to sum2 if there's a carry flag, do nothing if there's no carry flag
	ADDWFC sum2, F
	;end the program
	BRA HERE

CARRYHERE:
	;in this block of code, we add 60 to the previous value, then add one to the one hundreds place to finish the carry operation
	;add 60h with wreg
	ADDLW 0x60
	;move the contents of wreg into a temporary variable
	MOVWF temp
	;move the contents of sum2 into wreg
	MOVF sum2, W
	;add 1h to the contents of wreg and store that in wreg
	ADDLW 0x01
	;move the contents of wreg into the variable sum2(100's and 1000's place)
	MOVWF sum2
	;move temp back into wreg
	MOVF temp, W
	;branch back and finish the rest of the program
	BRA BACK
	

HERE BRA HERE
	END
	
	
	
	