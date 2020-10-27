.data
	string1: .asciiz "TEST"
	d1: .double 69
	h1: .half 67
	h2: .half 68
	i1: .word 65
	i2: .word 66
.text
	li $v0, 10
	syscall