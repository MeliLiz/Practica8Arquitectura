.data
cadena : .asciiz "cat str1"

.text
.globl main
main:
	la $s0, cadena
	li $t8, 0 	   #Contador del numero de bytes que usa la palabra 1
	li $t6, 0x10010000 #inicializamos $t6
	
loop:#Contar el numero de bytes que usa la primera cadena y copiarla a $t6
	
	lb $t0, 0($s0)#Cargamos el siguiente byte de la cadena en $t0
	
	beq $t0, $zero, fin #Si el byte es cero, terminamos
	beq $t0, 0x20, copiar #Si el byte es espacio, ya llegamos al separador
	
	sb $t0, ($t6)  #Guardamos el siguiente byte de la cadena (aqui vamos poniendo la palabra 1) en el siguiente byte de $t6
	
	addi $t6, $t6, 1 #Vamos al siguiente byte de $t6 (primera subcadena)
	addi $t8, $t8, 1 #Aumentamos el contador
	addi $s0, $s0, 1 #Vamos al siguiente byte de $s0 (cadena)
	j loop
	
copiar: #Copiar la segunda cadena en $t7

	sb $zero, ($t6)#agregamos el caracter nulo para que ahi se corte t6 (primera subcadena)
	
	sub $t7, $s0, $t8 #volver a la direccion donde empieza la cadena (en $t7 guardaremos la segunda subcadena)
	
	li $v0,4
	
	addi $t8, $t8, 1 #sumarle el byte del espacio al contador
	add $t7, $t7,$t8 #sumarle los bytes de la primera palabra (para que $t7 empiece en la dirección de memoria donde empieza la segunda palabra)
	
	move $a0, $t7	#obtenemos la segunda palabra
	syscall
	
	subi $t8, $t8, 1
	la $s0, cadena  #Volovemos a poner la direccion de la cadena en $s0
	sub $t6, $t6, $t8 #Vamos a la direccion de memoria donde comienza la primera palabra
	
	move $a0, $t6
	syscall
	
	#Ahora la primera subcadena esta en $t6 y la segunda en $t7
	
	
	
fin:
	li $v0, 10
	syscall
	
