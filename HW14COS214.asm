#Jack Sisson 2283

.data
	prompt: .asciiz "Enter a number: "
	isFac: .asciiz ": Is a factor"
	isntFac: .asciiz ": Is not a factor\n"
	isPrime: .asciiz " that is prime\n"
	isNPrime: .asciiz "\n"
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
	
	#set the start value
	li $t1, 1
	
loop:
	#exit the loop if start value is greater than max value
	bge $t1, $t0, exit
	#print out t1
	li $v0, 1
	move $a0, $t1
	syscall
	#jump to test function
	jal test
	#jal testPrime
	#increment t1
	addi $t1, $t1, 1
	#jump back to begining of loop
	j loop
	
	
exit:
	li $v0, 10
	syscall
	
test:
	#test if t1 is a factor
	rem $t2, $t0, $t1
	beqz $t2, isFactor
	j isNFactor
	
isFactor:
	#print that it is a factor
	li $v0, 4
	la $a0, isFac
	syscall
	move $t4, $ra
	jal testPrime
	#jump back to the loop
	move $ra, $t4
	jr $ra
	
isNFactor:
	#print that is is not a factor
	li $v0, 4
	la $a0, isntFac
	syscall
	jr $ra
	
testPrime:
	#tests to see if t1 is prime or not
	li $t2, 2
	beq  $t1, 2, prime
	j loop2
loop2:
	rem $t3, $t1, $t2
	beqz $t3, notPrime
	addi $t2, $t2, 1
	blt $t2, $t1, loop2
	j prime
	
notPrime:
	#print that is is not a factor
	li $v0, 4
	la $a0, isNPrime
	syscall
	jr $ra
prime :
	#print that is is not a factor
	li $v0, 4
	la $a0, isPrime
	syscall
	jr $ra
