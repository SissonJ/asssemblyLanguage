INCLUDE <P18F4321.INC>
sum1 equ 0x10
sum2 equ 0x11
sum3 equ 0x12

	CLRF sum1
	CLRF sum2
	CLRF sum3
	MOVLW 0xB5
	ADDLW 0x04
	MOVWF sum1
	MOVLW 0x91
	ADDWFC sum2, W
	ADDLW 0xA2
	MOVWF sum2
	MOVLW 0xF1
	ADDWFC sum3, W
	ADDLW 0x07
	MOVWF sum3
HERE BRA HERE
END