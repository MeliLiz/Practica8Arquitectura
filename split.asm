.data
cadena : .asciiz "cat str1"

.text
.globl main
main:
	la $s0, cadena
	li $t8, 0 #Contador
	
loop:
	lb $t0, 0($s0)
	beq $t0, $zero, fin
	beq $t0, 0x20, copiar
	
	addi $t8, $t8, 1
	addi $s0, $s0, 1
	j loop
	
copiar:
	sub $t7, $s0, $t8
	li $v0,4
	#move $a0, $t7
	#syscall
	addi $t7, $t7, 1
	add $t7, $t7,$t8
	move $a0, $t7
	syscall
	
	
fin:
	li $v0, 10
	syscall
