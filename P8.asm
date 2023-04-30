.data
buffer: .space 80
prompt: .asciiz "\nBienvenido a la terminal, ingresa un comando: "
disponibles: .asciiz "\nComandos disponibles:\n"
help: .asciiz "help"
help1: .asciiz "help\n"
joke: .asciiz "joke\n"
song: .asciiz "song\n"
rev: .asciiz "rev\n"
cat: .asciiz "cat\n"
exit: .asciiz "exit\n"
help_func: .asciiz "help: Imprime una lista de los comandos disponibles \n"
harg_func: .asciiz "help [arg]: Muestra la funcion del comando pasado en el argumento\n"
joke_func: .asciiz "joke: Muestra un chiste al azar\n"
song_func: .asciiz "song: genera una cancion\n"
rev_func: .asciiz "rev: Imprime la reversa de una cadena rev [arg]\n"
cat_func: .asciiz "cat: concatena dos archivos y los muestra en pantalla cat file file\n"
exit_func: .asciiz "exit: Termina la ejecucion del programa\n"
errormsg: .asciiz "El comando ingresado no existe\n"
joke1: .asciiz "Por que los elefantes no pueden usar computadoras? Porque tienen miedo del raton\n"
joke2: .asciiz "¿Por que las arañas son buenas en informatica? Porque saben como crear una red\n"
joke3: .asciiz "¿Que le dice una impresora a otra impresora? ¿Este papel es tuyo o es impresión mia?\n"

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
	
	la $s2, buffer	#Cargamos a $s2 la direccion del buffer
	
	
	#Caso help
	la $s3, help1	#Cargamos a $s3 la direccion de help1
	jal compara
	beqz $t9, caso_help1
	
	#Caso help args
	la $s2, buffer	#Cargamos a $s2 la direccion del buffer
	la $s3, help	#Cargamos a $s3 la direccion de help
	li $t8, 0 #Contador de bytes
	li $t7, 3 #Numero de bytes que ocupa la palabra help
	jal compara1
	beqz $t9, caso_help
	
	#Caso joke
	la $s3, joke	#Cargamos a $s3 la direccion de joke
	jal compara
	beqz $t9, caso_joke
	
	#Caso song
	la $s3, song	#Cargamos a $s3 la direccion de song
	jal compara
	beqz $t9, caso_song
	
	#Caso rev
	#la $s2, buffer	#Cargamos a $s2 la direccion del buffer
	la $s3, rev	#Cargamos a $s3 la direccion de help
	li $t8, 0 #Contador de bytes
	li $t7, 2 #Numero de bytes que ocupa la palabra help
	jal compara1
	beqz $t9, caso_rev
	
	#Caso cat
	la $s3, cat	#Cargamos a $s3 la direccion de cat
	jal compara
	beqz $t9, caso_cat
	
	#Caso exit
	la $s3, exit	#Cargamos a $s3 la direccion de exit
	jal compara
	beqz $t9, caso_exit
	
	#Mensaje de error
	li $v0, 4
	la $a0, errormsg
	syscall
	j main
	
caso_help1:#Imprimimos todos los comandos disponibles
	la $a0, disponibles
	li $v0, 4
	syscall
	la $a0, help_func
	li $v0, 4
	syscall
	la $a0, harg_func
	li $v0, 4
	syscall
	la $a0, joke_func
	li $v0, 4
	syscall
	la $a0, song_func
	li $v0, 4
	syscall
	la $a0, rev_func
	li $v0, 4
	syscall
	la $a0, cat_func
	li $v0, 4
	syscall
	la $a0, exit_func
	li $v0, 4
	syscall
	j main
	
caso_help:
	la $s2, buffer	#Cargamos a $s2 la direccion del buffer
	la $s2, 5($s2)
	
	la $s3, help1	#Cargamos a $s3 la direccion de help
	jal compara
	beqz $t9, funcHelp
	
	la $s3, joke	#Cargamos a $s3 la direccion de joke
	jal compara
	beqz $t9, funcJoke
	
	la $s3, song	#Cargamos a $s3 la direccion de joke
	jal compara
	beqz $t9, funcSong
	
	la $s3, rev	#Cargamos a $s3 la direccion de joke
	jal compara
	beqz $t9, funcRev
	
	la $s3, cat	#Cargamos a $s3 la direccion de joke
	jal compara
	beqz $t9, funcCat
	
	la $s3, exit	#Cargamos a $s3 la direccion de joke
	jal compara
	beqz $t9, funcExit
	
	#Mensaje de error
	li $v0, 4
	la $a0, errormsg
	syscall
	j main
	
	
funcHelp:
	la $a0, help_func
	li $v0, 4
	syscall
	la $a0, harg_func
	syscall
	j main
	
funcJoke:
	la $a0, joke_func
	li $v0, 4
	syscall
	j main
	
funcSong:la $a0, song_func
	li $v0, 4
	syscall
	j main
	
funcRev:
	la $a0, rev_func
	li $v0, 4
	syscall
	j main
	
funcCat:
	la $a0, cat_func
	li $v0, 4
	syscall
	j main
	
funcExit:
	la $a0, exit_func
	li $v0, 4
	syscall
	j main
	
#Funcion joke
caso_joke:
	li $v0, 42	#Genera numeros pseudoaleatorios
	li $a1, 3	#upper bound
	syscall
	beq $a0, $zero, j1	#joke1
	beq $a0, 1, j2		#joke2
	#joke3
	la $a0, joke3
	li $v0, 4
	syscall
	j main
j1:#Imprime joke1
	la $a0, joke1
	li $v0, 4
	syscall
	j main
j2:#Imprime joke2
	la $a0, joke2
	li $v0, 4
	syscall
	j main
	
caso_song:
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
	
caso_rev:
	la $a0, rev
	li $v0, 4
	syscall
	j main
	
caso_cat:
	la $a0, cat
	li $v0, 4
	syscall
	j main
	
caso_exit:
	la $a0, exit
	li $v0, 4
	syscall
	li $v0, 10
	syscall
	
#Codigo para comparar cadenas
compara:
	lb $t2, ($s2)
	lb $t3, ($s3)
	bne $t2, $t3, diferentes
	
	beq $t2, $zero, iguales
	
	addi $s2, $s2, 1
	addi $s3, $s3, 1
	j compara
	
#Codigo para comparar comandos con argumentos
compara1:
	lb $t2, 0($s2)
	lb $t3, 0($s3)
	
	bne $t2, $t3, diferentes
	
	beq $t2, $zero, iguales
	
	beq $t8, $t7, iguales #Si ya se compararon los primeros bytes (los que ocupa la palabra del comando)
	
	addi $t8, $t8, 1 
	addi $s2, $s2, 1
	addi $s3, $s3, 1
	j compara1
	
	
diferentes:
	li $t9, 1 #En t9 ponemos 1
	jr $ra
	
	
iguales:
	move $t9, $zero #En t9 ponemos 0
	jr $ra
	
	