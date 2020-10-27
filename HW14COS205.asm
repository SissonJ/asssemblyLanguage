#Jack Sisson 2283

.data
	firstNumb: .asciiz "Enter the first number: "
	secondNumb: .asciiz "Enter the second number: "
	thirdNumb: .asciiz "Enter the thrid number: "
	result: .asciiz "The result is: "
	numb1: .word 0
	numb2: .word 0
	
.text
	li $v0, 4 #to print string
	la $a0, firstNumb #load the label
	syscall
	
	li $v0, 5 #read user input(INT)
	syscall
	
	sw $v0, numb1
	
	li $v0, 4 #to print string
	la $a0, secondNumb #load the label
	syscall
	
	li $v0, 5 #read user input(INT)
	syscall
	
	lw $t1, numb1
	sw $v0, numb2
	lw $t2, numb2
	add $t3, $t2, $t1
	sw $t3, numb1
	
	li $v0, 4 #to print string
	la $a0, thirdNumb #load the label
	syscall
	
	li $v0, 5 #read user input(INT)
	syscall
	
	lw $t1, numb1
	sw $v0, numb2
	lw $t2, numb2
	add $t3, $t2, $t1
	sw $t3, numb1
	
	li $v0, 4 #to print string
	la $a0, result #load the label
	syscall
	
	#load back into a0
	lw $a0, numb1
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall