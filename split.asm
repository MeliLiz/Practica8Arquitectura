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
	sub $t7, $s0, $t8 #colver a la direccion donde empieza la cadea
	li $v0,4
	
	addi $t8, $t8, 1 #sumarle el byte del espacio al contador
	add $t7, $t7,$t8 #sumarle los bytes de la primera palabra
	move $a0, $t7	#obtenemos la segunda palabra
	syscall
	
	subi $t8, $t8, 1
	la $s0, cadena  #Volovemos a poner la direccion de la cadena en $s0
	li $t6, 0x10010000
	
loop1:
	lb $t0, ($s0)
	beq $t0, $zero, error
	beq $t0, 0x20, copy
	
	sb $t0, ($t6)
	
	addi $t6, $t6, 1
	addi $s0, $s0, 1
	j loop1
	
copy:
	#addi $t6, $t6, 1
	sb $zero, ($t6)#agregamos el caracter nulo para que ahi se corte t6
	sub $t6, $t6, $t8
	move $a0, $t6
	syscall
	
	
	
fin:
	li $v0, 10
	syscall
	
error:
