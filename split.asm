.data
cadena: .asciiz "f1.txt f2.txt"
espacio: .asciiz " "
.text 
.globl main
main:
	la $s0, cadena
	la $t5, espacio
	#li $t4, 0
	li $t4, 0x10010000
	
loop:
	
	lb $t2, 0($s0) #Cargar el byte actual
	beq $t2, $zero, fin   # Si es el final de la cadena, terminar
	beq $t2, 0x20, next   # Si es un espacio, avanzar a la siguiente subcadena
	
	sb $t2, 0($t4)
	
	
	
	addi $t4, $t4, 1
    	addi $s0, $s0, 1     # Avanzar al siguiente byte

    	j loop               # Volver al inicio del loop

next:
	li $v0, 4
	move $a0, $t4
	syscall
	addi $t4, $t4, 1
    	addi $s0, $s0, 1
	j loop
	#beq $t9, 0, save_t5
   	#beq $t9, 1, save_t6
    	#beq $t9, 2, save_t7

#save t5:
#save t6:
#save t7:

fin:
	li $v0, 10
	syscall

