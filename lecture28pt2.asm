#pringing number from 0 to 30

.data
	maxNum: .word 30
	newLine: .asciiz "\n"
	prompt: .asciiz "Enter max number: "
.text
	li $t1, 0
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
loop:
	bgt $t1, $t0, exit
	li $v0, 1
	move $a0, $t0
	syscall
	jal printNL
	addi $t0, $t0, -2
	j loop

printNL:
	li $v0, 4
	la $a0, newLine
	syscall
	jr $ra
exit:
	li $v0, 10
	syscall