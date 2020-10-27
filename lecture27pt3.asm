.data
	iS: .space 40
	iSLength: .word 41
	prompt: .asciiz "ENTER YOUR FAVORITE PIE: "
	first: .asciiz "SO YOU LIKE "
	pie: .asciiz " PIE"
	
.text
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 8
	la $a0, iS
	lw $a1, iSLength
	syscall
	
	li $v0, 4
	la $a0, first
	syscall
	
	li $v0, 4
	la $a0 iS
	syscall
	
	li $v0, 4
	la $a0, pie
	syscall
	
	li $v0, 10
	syscall