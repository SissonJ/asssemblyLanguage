.data
maxNum: .word 12
newLine: .asciiz "\n"
.text
main:
lw $t0, maxNum
move $a0, $t0
print:
blt $a0, 0, exit
li $v0, 1
syscall
li $v0, 4
la $a0, newLine
syscall
subi $t0, $t0, 2
move $a0, $t0
j print
exit:
li $v0, 10
syscall