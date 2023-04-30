.data
errormsg: .asciiz "error"
print_command: .asciiz "print"
palabra1: .asciiz "palabra"
palabra2: .asciiz "palabra1"

.text
.globl main
main:
	la $s2, palabra1
	la $s3, palabra2
	jal cmploop
	
	li $v0, 10
	syscall

cmploop:
	lb $t2, ($s2)
	lb $t3, ($s3)
	bne $t2, $t3, cmpne
	
	beq $t2, $zero, cmpeq
	
	addi $s2, $s2, 1
	addi $s3, $s3, 1
	j cmploop
	
cmpne:
	la $a0, errormsg
	li $v0, 4
	syscall
	jr $ra
	
	
cmpeq:
	la $a0, print_command
	li $v0, 4
	syscall
	jr $ra
