INCLUDE <P18F4321.INC>

	;Set up tables
	MOVLW 0x27
	MOVWF 0x020
	MOVLW 0x45
	MOVWF 0x021
	MOVLW 0x93
	MOVWF 0x022
	MOVLW 0x58
	MOVWF 0x023
	MOVLW 0x20
	MOVWF 0x024
	MOVLW 0x71
	MOVWF 0x025
	MOVLW 0xA5
	MOVWF 0x026
	MOVLW 0xB4
	MOVWF 0x027
	MOVLW 0x8F
	MOVWF 0x028
	MOVLW 0x4B
	MOVWF 0x029
	MOVLW 0x3E
	MOVWF 0x02A
	MOVLW 0x29
	MOVWF 0x02B
	MOVLW 0x1F
	MOVWF 0x02C
	MOVLW 0x03
	MOVWF 0x02D
	MOVLW 0x8A
	MOVWF 0x2E
	MOVLW 0xF3
	MOVWF 0x2F
	
	MOVLW 0x19
	MOVWF 0x030
	MOVLW 0xF2
	MOVWF 0x031
	MOVLW 0xA3
	MOVWF 0x032
	MOVLW 0x48
	MOVWF 0x033
	MOVLW 0x6D
	MOVWF 0x034
	MOVLW 0x3C
	MOVWF 0x035
	MOVLW 0x2F
	MOVWF 0x036
	MOVLW 0x9A
	MOVWF 0x037
	MOVLW 0x92
	MOVWF 0x038
	MOVLW 0x76
	MOVWF 0x039
	MOVLW 0x4f
	MOVWF 0x03A
	MOVLW 0x2B
	MOVWF 0x03B
	MOVLW 0x6A
	MOVWF 0x03C
	MOVLW 0x39
	MOVWF 0x03D
	MOVLW 0x2B
	MOVWF 0x03E
	MOVLW 0xE6
	MOVWF 0x03F
	
;set up some variables
sixteen equ 0x16
eight equ 0x08
	MOVLW 0x10
	MOVWF sixteen
	MOVLW 0x08
	MOVWF eight

	;clear the two ov values
	CLRF 0x011
	CLRF 0x012
	
	MOVLB 0x01 ;load 1 into B

	;load pointers to registers into the FSRs
	LFSR 0, 0x020
	LFSR 1, 0x03F
	LFSR 2, 0x150

;set up the counter
counter equ 0x060
	MOVLW D'16'
	MOVWF 0x060

;start the loop
ADDITION:
	MOVF POSTINC0, W ;move the value in the register pointed at by FSR0 into reg and increment FSR0
	ADDWF POSTDEC1, W ;Add wreg with the value in the register pointed at by FSR1, store in wreg and decrement FSR1
	MOVWF POSTINC2 ;move the value in wreg to the register pointed at by FSR2, and increment FSR2
	BNOV SKIP ;if there is no overflow, branch to skip

	;these lines only evaluated if there is an overflow error
	MOVF counter, W ;move the counter into wreg
	CPFSLT eight ;skip if 8<WREG
	BRA LESS ;evaluated if WREG<=8
	BRA GREATER ;evaluated if WREG>8

		


SKIP:
	
	;these lines only evaluated if there is not an overflow error
	MOVF counter, W ;move the counter into wreg
	CPFSLT eight ;skip if 8<WREG
	BRA LESSNOOV 
	BRA GREATERNOOV

AFTER

	
	DECF counter, F ;decrement the counter
	BNZ ADDITION ;branch to the begining of the loop if the counter isn't zero
	BRA HERE ;branch to the end of the program if the counter is zero
	


LESS:

	;this code will evaluate if the counter is less than or equal to 8, and there has been an overflow error
	BSF 0x012, 0 ;set bit 0 to 1 in register 12
	RRNCF 0x012, 1 ;roatate to the right (this will happen 8 times for reg 0x12)
	BRA AFTER ;branch back to the loop

GREATER:

	;this code will evaluate if the counter is greater than 8, and there has been an overflow error
	BSF 0x011, 0 ;set bit 0 to 1 in register 11
	RRNCF 0x011, 1 ;rotate to the right (this will happen 8 times for reg 0x11)
	BRA AFTER ;branch back to the loop

LESSNOOV

	;this code will evaluate if the counter is less than or equal to 8, and there has not been an overflow error
	RRNCF 0x012, 1 ;roatate to the right (this will happen 8 times for reg 0x12)
	BRA AFTER ;branch back to the loop

GREATERNOOV

	;this code will evaluate if the counter is greater than 8, and there has not been an overflow error
	RRNCF 0x011, 1 ;rotate to the right (this will happen 8 times for reg 0x11)
	BRA AFTER ;branch back to the loop

HERE BRA HERE
END