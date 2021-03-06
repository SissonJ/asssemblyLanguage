#INCLUDE <P18F4321.INC>
	ORG 0x100 ;set the memory location of the main method
;define variables
numbaH equ 0x0A
numbaL equ 0x0F
lsb0 equ 0x10
msb0 equ 0x11
bcd2 equ 0x0B
bcd1 equ 0x0C
bcd0 equ 0x0D
divideCounter equ 0x0E
counter equ 0x05
holder equ 0x06
compH equ 0x12
compL equ 0x13
	LFSR 0, 0x20 
	MOVLW 0x0A
	MOVWF counter
	MOVLW UPPER ADDR
	MOVWF TBLPTRU
	MOVLW HIGH ADDR
	MOVWF TBLPTRH
	MOVLW LOW ADDR
	MOVWF TBLPTRL

LOOP TBLRD *+
	MOVF TABLAT, W
	MOVWF POSTINC0
	DECF counter, 1
	BNZ LOOP

	MOVLW 0x0A
	MOVWF counter
	LFSR 0, 0x20
	LFSR 1,0x40
	LFSR 2, 0X30

one equ 0x01
	MOVLW 0x01
	MOVWF one

sqrtCounter equ 0x02
	CLRF sqrtCounter

LOOPTWO
	MOVF POSTINC0, W
	MOVWF holder
	MULWF holder
	
	MOVF PRODH, W
	MOVWF POSTINC1
	MOVF PRODL, W
	MOVWF POSTINC1

	CALL SQRT
	
	DECF counter, 1
	BNZ LOOPTWO

	;ERASE DATA

	MOVLW 0xD0
	CLRF TBLPTRH
	CLRF TBLPTRU
	MOVWF TBLPTRL
	MOVLW D'10'
	MOVWF counter
	BSF EECON1, EEPGD
	BCF EECON1, CFGS
	BSF EECON1, WREN
	BSF EECON1, FREE
	BCF INTCON, GIE

ERASELOOP

	MOVLW 55h
	MOVWF EECON2
	MOVLW 0AAh
	MOVWF EECON2
	BSF EECON1, WR
	BSF INTCON, GIE
	MOVF TBLPTRL, W
	SUBLW 10h
	MOVWF TBLPTRL
	DECF counter
	BNZ ERASELOOP

	;MOVE PROGRAM MEMORY TO DATA MOEMORY HERE

	MOVLW D'10'
	MOVWF counter
tableStart equ 0x2A
	MOVLW 0x40
	MOVWF tableStart



	LFSR 0, 0x020
	LFSR 1, 0x041
	LFSR 2, 0x030

	CLRF TBLPTRH
	CLRF TBLPTRU
	MOVF tableStart, W
	MOVWF TBLPTRL
	;MOVLW 0x05
	;MOVWF TBLPTRH
counter2 equ 0x07
	
LOOPTHREE
;	MOVLW 0x02
;	MOVWF counter2
;LOOPFOUR
	MOVF POSTDEC1, W
	MOVWF TABLAT
	TBLWT*+;
	
	MOVF POSTINC1, W
	MOVWF TABLAT
	TBLWT*+;

	;MOVF POSTINC1, W
	;MOVF POSTINC1, W

	MOVF POSTINC2, W
	MOVWF TABLAT
	TBLWT*+;

	MOVF POSTINC0, W
	MOVWF TABLAT
	TBLWT*+
	MOVF POSTDEC0, W

	MOVF POSTDEC1, W
	MOVWF lsb0
	MOVF POSTINC1, W
	MOVWF msb0
	MOVF POSTINC1, W
	MOVF POSTINC1, W
	CALL BCD
	MOVF bcd0, W
	MOVWF holder

	MOVF bcd1, W
	MOVWF TABLAT
	TBLWT*+

	MOVF bcd2, W
	MOVWF TABLAT
	TBLWT*+

	MOVF POSTINC0, W
	MOVWF lsb0
	CLRF msb0
	CALL BCD

	MOVF bcd1, W
	MOVWF TABLAT
	TBLWT*+

	MOVF holder, W
	MOVWF TABLAT
	TBLWT*+




;	DECFSZ counter2
;	GOTO LOOPFOUR

	MOVLW 0x8
	SUBWF TBLPTRL, F
	
	;MOVLW 0x0D
	;ADDWF TBLPTRL, F

	BCF INTCON, GIE
	MOVLW 55h
	MOVWF EECON2
	MOVLW 0AAh
	MOVWF EECON2
	BSF EECON1, WR
	NOP
	BSF INTCON, GIE

	MOVLW 0x10
	ADDWF TBLPTRL, F

	DECF counter, 1
	BNZ LOOPTHREE

;END OF THRID LOOP
	MOVLW D'10'
	MOVWF counter
tableStart equ 0x2A
	MOVLW 0x48
	MOVWF tableStart

	LFSR 0, 0x020
	LFSR 1, 0x040
	LFSR 2, 0x030

	CLRF TBLPTRH
	CLRF TBLPTRU
	MOVF tableStart, W
	MOVWF TBLPTRL

LOOPFOUR

	MOVF POSTINC2, W
	MOVWF lsb0
	CLRF msb0;
	CALL BCD
	MOVF bcd0, W
	MOVWF TABLAT
	TBLWT*+

	MOVF POSTINC0, W
	MOVWF lsb0
	CLRF msb0;
	CALL BCD
	MOVF bcd0, W
	MOVWF TABLAT
	TBLWT*+

	MOVLW 0x2
	SUBWF TBLPTRL, F
	
	;MOVLW 0x0D
	;ADDWF TBLPTRL, F

	BCF INTCON, GIE
	MOVLW 55h
	MOVWF EECON2
	MOVLW 0AAh
	MOVWF EECON2
	BSF EECON1, WR
	NOP
	BSF INTCON, GIE

	MOVLW 0x10
	ADDWF TBLPTRL, F

	DECF counter, 1
	BNZ LOOPFOUR

HERE BRA HERE
	ORG 0x400
ADDR DB D'05', D'8', D'9', D'27', D'42', D'61', D'100', D'127', D'165', D'225'
	ORG 0X300
SQRT	BTFSC holder, 7
	BRA ADD2
	 MOVF one, W
	;CLRF C
	SUBWF holder, F
	BNN ADD
	MOVF sqrtCounter, W
	MOVWF POSTINC2
	CLRF sqrtCounter
	MOVLW 0x01
	MOVWF one
	RETURN

ADD
;	MOVWF holder
	INCF sqrtCounter
	MOVF one, W
	ADDLW 0x02
	MOVWF one
	GOTO SQRT

ADD2
	MOVF one, W
	SUBWF holder, F
INCF sqrtCounter
	MOVF one, W
	ADDLW 0x02
	MOVWF one
	GOTO SQRT


	ORG 0x500
BCD
	CLRF bcd2
	CLRF bcd1
	CLRF bcd0
	MOVLW 0x27 ;10 thousands
	MOVWF numbaH
	MOVLW 0x10
	MOVWF numbaL
	CALL DIVIDE2
	MOVF divideCounter, W
	MOVWF bcd2
	MOVLW 0x03 ;thousands
	MOVWF numbaH
	MOVLW 0xE8
	MOVWF numbaL
	CALL DIVIDE2
	MOVF divideCounter, W
	MOVWF bcd1
	SWAPF bcd1, F
	CLRF numbaH
	MOVLW 0x64 ;hundreds
	MOVWF numbaL
	CALL DIVIDE2
	MOVF divideCounter, W
	ADDWF bcd1, F
	MOVLW 0x0A ;tens
	MOVWF numbaL
	CALL DIVIDE2
	MOVF divideCounter, W
	MOVWF bcd0
	SWAPF bcd0, F
	MOVLW 0x01
	MOVWF numbaL
	CALL DIVIDE2
	MOVF divideCounter, W
	ADDWF bcd0, F
	RETURN

	ORG 0x700
DIVIDE2
	MOVLW 0x00
	MOVWF divideCounter
	MOVF numbaH, W
	MOVWF compH
	MOVF numbaL, W
	MOVWF compL
	INCF compH
	INCF compL
DIVIDELOOP
	MOVF msb0, W
	CPFSGT compH
	BRA SUBTRACT
	CPFSEQ numbaH
	RETURN
	MOVF lsb0,W
	CPFSGT compL
	BRA SUBTRACT
	CPFSEQ numbaL
	RETURN
SUBTRACT
	INCF divideCounter
	MOVF numbaL, W
	SUBWF 0x10, F
	MOVF numbaH, W
	SUBWFB msb0, F

	GOTO DIVIDELOOP
END


