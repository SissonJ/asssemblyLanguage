.data

	num1: .word 5
	num2: .word 6
	num3: .word 7
	
.text

	lw $t0, num1
	lw $t1, num2
	add $a0, $t0, $t1
	lw $t0, num3
	add $a0, $a0, $t0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall