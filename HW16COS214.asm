.data
	prompt: .asciiz "Enter a number: "
	newLine: .asciiz "\n"
	iterationCount: .asciiz "Number of iterations: "
	space: .asciiz " "
.text
	#print prompt
	li $v0, 4
	la $a0, prompt
	syscall
	
	#get user input
	li $v0, 5
	syscall
	#move v0 = t0 to keep track of max number
	move $t0, $v0 
	#subi $t0, $t0, 1
	li $t4, 2
	
	#set the end value
	li $t1, 1
	
	#set the loop iteration to 1
	li $t2, 1
	j loop
	
exit:
	li $v0, 10
	syscall
loop:
	beq $t0, $t1, end
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	rem $t5, $t0, $t4
	beq $t5, 0, even
	mul $t0, $t0, 3
	add $t0, $t0, 1
	add $t2, $t2, 1
	j loop
	
end:
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	li $v0, 4
	la $a0, iterationCount
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	j exit

even:
	div $t0, $t0,$t4
	add $t2, $t2, 1
	j loop
