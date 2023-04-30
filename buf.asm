.data
buffer: .space 80
prompt: .asciiz "Bienvenido a la terminal, ingresa un comando: "
amugus: .asciiz "amugus"
exit_msg: .asciiz "Cuando el ayudante es sus \n"
beep: .asciiz "beep"
errormsg: .asciiz "Error, comando no valido\n"
exit: .asciiz "exit"

.text
.globl main

main:
	#imprimimos mensaje para ingresar comando
	li $v0, 4
	la $a0, prompt
	syscall
	
	#Leer string del usuario
	li $v0, 8	#Leer string del usuario
	la $a0, buffer	#Apartar en $a0 un buffer de tamaño 80
	li $a1, 81	#Tamaño maximo
	syscall		
	
	#Caso amugus
	la $t0, buffer	#Cargamos a $t0 la direccion del buffer
	la $t1, amugus	#Cargamos a $t1 la direccion de amugus
	lb $t2, ($t0)	#Cargamos el primer byte del input en $t2
	lb $t3, ($t1)	#Cargamos el primer byte de "amugus" en $t3
	beq $t2, $t3, case_amugus	#Si coinciden
	
	#Caso exit
	la $t1, exit	#Cargamos la direccion de "exit" en $t1
	lb $t3, ($t1)	#Cargamos primer byte de "exit" en $t3
	beq $t2, $t3, exit_program #Si coinciden
	
	#Caso beep
	la $t1, beep	#Cargamos la direccion de "exit" en $t1
	lb $t3, ($t1)	#Cargamos primer byte de "exit" en $t3
	beq $t2, $t3, case_beep  #Si coinciden
	
	#Mensaje de error
	li $v0, 4
	la $a0, errormsg
	syscall
	j main
	
case_amugus:
	li $v0, 4
	la $a0, exit_msg
	syscall
	j main
	
case_beep:
	li $v0, 33
	li $a0, 74
	li $a1, 1000
	li $a2, 24
	li $a3, 127
	syscall
	li $a0, 74
	syscall
	li $a0, 81
	syscall
	li $a0, 80
	syscall
	j main

exit_program:
	li $v0, 10
	syscall
	
	