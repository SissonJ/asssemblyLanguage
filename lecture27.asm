.data
	integerVar: .word 100
	doubleVar: .double 3.5
	string1: .asciiz "/n"
	
	
.text
	lw $a0 integerVar
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, string1
	syscall
	
	lw $a0, integerVar
	add $a0, $a0, $a0
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, string1
	syscall
	
	l.d $f12, doubleVar
	li $v0, 3
	syscall
	
	li $v0, 10
	syscall