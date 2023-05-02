.data
buffer: .space 80
bufferArchivo1: .space 1000
bufferArchivo2: .space 1000
bufferA: .space 1000
prompt: .asciiz "\nBienvenido a la terminal, ingresa un comando: "
disponibles: .asciiz "\nComandos disponibles:\n"
help: .asciiz "help"
help1: .asciiz "help\n"
joke: .asciiz "joke\n"
song: .asciiz "song\n"
rev: .asciiz "rev\n"
cat: .asciiz "cat\n"
words: .asciiz "words\n"
exit: .asciiz "exit\n"
help_func: .asciiz "help: Imprime una lista de los comandos disponibles \n"
harg_func: .asciiz "help [arg]: Muestra la funcion del comando pasado en el argumento\n"
joke_func: .asciiz "joke: Muestra un chiste al azar\n"
song_func: .asciiz "song: genera una cancion\n"
rev_func: .asciiz "rev: Imprime la reversa de una cadena rev [arg]\n"
cat_func: .asciiz "cat: concatena dos archivos y los muestra en pantalla cat file file\n"
words_func: .asciiz "words [direccion de archivo]: Nos dice el numero de palabras en el archivo\n" 
exit_func: .asciiz "exit: Termina la ejecucion del programa\n"
errormsg: .asciiz "El comando ingresado no existe\n"
joke1: .asciiz "Por que los elefantes no pueden usar computadoras? Porque tienen miedo del raton\n"
joke2: .asciiz "¿Por que las arañas son buenas en informatica? Porque saben como crear una red\n"
joke3: .asciiz "¿Que le dice una impresora a otra impresora? ¿Este papel es tuyo o es impresión mia?\n"
warning: .asciiz "Los argumentos ingresados no son validos"
resPalabras: .asciiz "El numero de palabras en el archivo es: "
noWords: .asciiz "El archivo ingresado no tiene palabras"

.text
.globl main

main:
	sw $zero, bufferArchivo1
	sw $zero, bufferArchivo2
	sw $zero, bufferA
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
	li $t7, 2 #Numero de bytes que ocupa la palabra rev
	jal compara1
	beqz $t9, caso_rev
	
	#Caso cat
	la $s3, cat	#Cargamos a $s3 la direccion de cat
	li $t8, 0 #Contador de bytes
	li $t7, 2 #Numero de bytes que ocupa la palabra cat
	jal compara1
	beqz $t9, caso_cat
	
	#Caso words
	la $s3, words	#Cargamos a $s3 la direccion de words
	li $t8, 0 #Contador de bytes
	li $t7, 4 #Numero de bytes que ocupa la palabra words
	jal compara1
	beqz $t9, caso_words
	
	#Caso exit
	la $s3, exit	#Cargamos a $s3 la direccion de exit
	jal compara
	beqz $t9, caso_exit
	
	
	#Mensaje de error
	li $v0, 4
	la $a0, errormsg
	syscall
	j main
	
#Imprimimos todos los comandos disponibles
caso_help1:
	li $v0, 4
	la $a0, disponibles
	syscall
	la $a0, help1
	syscall
	la $a0, joke
	syscall
	la $a0, song
	syscall
	la $a0, rev
	syscall
	la $a0, cat
	syscall
	la $a0, words
	syscall
	la $a0, exit
	syscall
	
	j main
	
#Imprimimos la funcion del comando solicitado en los argumentos
caso_help: 

	la $s2, buffer	#Cargamos a $s2 la direccion del buffer
	la $s2, 5($s2)  #Saltamos a la direccion en donde empieza el argumento
	
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
	
	la $s3, words	#Cargamos a $s3 la direccion de joke
	jal compara
	beqz $t9, funcWords
	
	la $s3, exit	#Cargamos a $s3 la direccion de joke
	jal compara
	beqz $t9, funcExit
	
	#Mensaje de error
	li $v0, 4
	la $a0, errormsg
	syscall
	j main
#Funciones auxiliares del caso help
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
funcWords:
	la $a0, words_func
	li $v0, 4
	syscall
	j main
funcExit:
	la $a0, exit_func
	li $v0, 4
	syscall
	j main
		
#Caso de joke
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
	
#Caso de song
caso_song:
	#C
      li $v0, 33      # syscall number 31 (play note) permite que acabe
      li $a0, 60     # pitch (0-127)(c)
      li $a2, 1       # instrumento (0-127)
      li $a1, 1500   # duracon en milisegundos
      li $a3, 100    # volumen (0-127)
      syscall         # play note    	
      #C 
      li $v0, 33      # syscall number 31 (play note)
      li $a0, 60     # pitch (0-127)(c)
      li $a2, 1       # instrumento (0-127)
      li $a1, 1000   # duracon en milisegundos
      li $a3, 100   # volumen 
      syscall         # play note      
      #G
      li $v0, 33      # syscall number 31 (play note) permite que acabe
      li $a0, 67     # pitch (0-127)(c)
      li $a2, 1       # instrumento (0-127)
      li $a1, 1000   # duracon en milisegundos
      li $a3, 100    # volumen (0-127)
      syscall         # play note    	
      #G 
      li $v0, 33      # syscall number 31 (play note)
      li $a0, 67     # pitch (0-127)(c)
      li $a2, 1       # instrumento (0-127)
      li $a1, 1000   # duracon en milisegundos
      li $a3, 100   # volumen 
      syscall         # play note     
      #A
      li $v0, 33      # syscall number 31 (play note) permite que acabe
      li $a0, 69     # pitch (0-127)(c)
      li $a2, 1       # instrumento (0-127)
      li $a1, 1000   # duracon en milisegundos
      li $a3, 100    # volumen (0-127)
      syscall         # play note   	
      #A 
      li $v0, 33      # syscall number 31 (play note)
      li $a0, 69     # pitch (0-127)(c)
      li $a2, 1       # instrumento (0-127)
      li $a1, 1000   # duracon en milisegundos
      li $a3, 100   # volumen 
      syscall         # play note     
      #G
      li $v0, 33      # syscall number 31 (play note) permite que acabe
      li $a0, 67     # pitch (0-127)(c)
      li $a2, 1       # instrumento (0-127)
      li $a1, 1500   # duracon en milisegundos
      li $a3, 100    # volumen (0-127)
      syscall         # play note     
      #F
      li $v0, 33      # syscall number 31 (play note) permite que acabe
      li $a0, 65     # pitch (0-127)(c)
      li $a2, 1       # instrumento (0-127)
      li $a1, 1000   # duracon en milisegundos
      li $a3, 100    # volumen (0-127)
      syscall         # play note      
      #F
      li $v0, 33      # syscall number 31 (play note) permite que acabe
      li $a0, 65     # pitch (0-127)(c)
      li $a2, 1       # instrumento (0-127)
      li $a1, 1000   # duracon en milisegundos
      li $a3, 100    # volumen (0-127)
      syscall         # play note      
      #E
      li $v0, 33      # syscall number 31 (play note) permite que acabe
      li $a0, 64     # pitch (0-127)(c)
      li $a2, 1       # instrumento (0-127)
      li $a1, 1000   # duracon en milisegundos
      li $a3, 100    # volumen (0-127)
      syscall         # play note      
      #E
      li $v0, 33      # syscall number 31 (play note) permite que acabe
      li $a0, 64     # pitch (0-127)(c)
      li $a2, 1       # instrumento (0-127)
      li $a1, 1000   # duracon en milisegundos
      li $a3, 100    # volumen (0-127)
      syscall         # play note     
      #D
      li $v0, 33      # syscall number 31 (play note) permite que acabe
      li $a0, 62     # pitch (0-127)(c)
      li $a2, 1       # instrumento (0-127)
      li $a1, 1000   # duracon en milisegundos
      li $a3, 100    # volumen (0-127)
      syscall         # play note     
      #D
      li $v0, 33      # syscall number 31 (play note) permite que acabe
      li $a0, 62     # pitch (0-127)(c)
      li $a2, 1       # instrumento (0-127)
      li $a1, 1000   # duracon en milisegundos
      li $a3, 100    # volumen (0-127)
      syscall         # play note
      #C
      li $v0, 33      # syscall number 31 (play note) permite que acabe
      li $a0, 60     # pitch (0-127)(c)
      li $a2, 1       # instrumento (0-127)
      li $a1, 1500   # duracon en milisegundos
      li $a3, 100    # volumen (0-127)
      syscall         # play note  
       
	j main
	
#Caso de rev
caso_rev:
	la $a0, rev
	li $v0, 4
	syscall
	j main
	
#Caso de cat
caso_cat:
	la $s2, buffer
	addi $s2, $s2, 4 #Nos sqaltamos a la direccion de memoria en la que empieza el primer argumento
	
	li $t8, 0 	   #Contador del numero de bytes que usa la palabra 1
	li $t7, 0
	li $t6, 0x10010000 #inicializamos $t6
	
#Funciones auxiliares de cat
loop:#Contar el numero de bytes que usa la primera cadena y copiarla a $t6
	lb $t0, 0($s2)#Cargamos el siguiente byte de la cadena en $t0
	
	beq $t0, $zero, fin #Si el byte es cero, hay mas de dos argumentos
	beq $t0, 0x20, copiar #Si el byte es espacio, ya llegamos al separador
	
	sb $t0, ($t6)  #Guardamos el siguiente byte de la cadena (aqui vamos poniendo la palabra 1) en el siguiente byte de $t6
	
	addi $t6, $t6, 1 #Vamos al siguiente byte de $t6 (primera subcadena)
	addi $t8, $t8, 1 #Aumentamos el contador
	addi $s2, $s2, 1 #Vamos al siguiente byte de $s0 (cadena)
	j loop	
copiar: #Copiar la segunda cadena en $t7

	sb $zero, ($t6)#agregamos el caracter nulo para que ahi se corte t6 (primera subcadena)
	
	sub $t7, $s2, $t8 #volver a la direccion donde empieza la cadena (en $t7 guardaremos la segunda subcadena)
	
	addi $t8, $t8, 1 #sumarle el byte del espacio al contador
	add $t7, $t7,$t8 #sumarle los bytes de la primera palabra (para que $t7 empiece en la dirección de memoria donde empieza la segunda palabra)
	
	#Quitar el newline d $t7
	move $t9, $zero
	li $t3, 0x0A
	jal sustituir
	
	subi $t8, $t8, 1
	la $s2, buffer  #Volovemos a poner la direccion de la cadena en $s0
	addi $s2, $s2, 4
	sub $t6, $t6, $t8 #Vamos a la direccion de memoria donde comienza la primera palabra
	
	#Ahora la primera subcadena esta en $t6 y la segunda en $t7
	
	# Abrimos el archivo1 para leer (El que no escribira)
  	li $v0, 13              # Syscall para abrir un archivo
  	move $a0, $t7        # Cargamos la direccion del archivo
  	li $a1, 0               # read mode 0 para leer, 1 para escribir
  	li $a2, 0               # Permisos por defecto
  	syscall
  	move $s0, $v0           # Descriptor del archivo.
  
  	# Lee los contenidos del archivo.
  	li $v0, 14              # Syscall para leer un archivo
  	move $a0, $s0           # Movemos el descriptor al $a0
  	la $a1, bufferArchivo2          # Carga la direccion del buffer a $a1
  	li $a2, 1000             # Limite de lectura, lee hasta 256 bytes.
  	syscall
  
  	#Cerramos el archivo
 	li $v0, 16              # Syscall para cerrar un archivo.
  	move $a0, $s0           # Movemos el descriptor del archivo a $a0
  	syscall
  
  	#Abrimos el segundo archivo para leer (el que escribira)
   	li $v0, 13              # Syscall para abrir un archivo
   	move $a0, $t6        # Cargamos la direccion del archivo
   	li $a1, 0               # read mode 0 para leer, 1 para escribir
   	li $a2, 0               # Permisos por defecto
   	syscall
   	move $s1, $v0           # Descriptor del archivo.
  
  	# Lee los contenidos del archivo.
  	li $v0, 14              # Syscall para leer un archivo
  	move $a0, $s1           # Movemos el descriptor al $a0
  	la $a1, bufferArchivo1          # Carga la direccion del buffer a $a1
  	li $a2, 1000             # Limite de lectura, lee hasta 256 bytes.
  	syscall
  
  	# Cerramos el archivo.
  	li $v0, 16    
  	move $a0, $s1
  	syscall
  
  	# Abrimos el archivo para escribir
  	li $v0, 13              # Syscall para abrir un archivo
  	move $a0, $t6        # Cargamos la direccion del archivo
  	li $a1, 1               # read mode 0 para leer, 1 para escribir
  	li $a2, 0               # Permisos por defecto
  	syscall
  	move $s2, $v0           # Descriptor del archivo.
  
  	#Escribir el archivo
  	li $v0, 15
  	move $a0, $s2		#Descriptor
  	la $a1, bufferArchivo1	#En $a1 ponemos los contenidos del archivo que escribe
  	la $t5, bufferArchivo2	#En $t5 ponemos el contenido del archivo que se lee
  
  	li $t8, 0 #contador
  
#Funciones para concatenar lo que esta en el primer buffer con lo del segundo
concat:
	lb $t0, 0($a1)	#Cargamos el byte actual de $a1 en $t0
	beqz $t0, concatena #Si el byte es cero, llegamos al final del archivo
	
	addi $a1, $a1, 1	#Aumentamos la direccion de $a1
	addi $t8, $t8, 1	#Aumentamos el contador
  	j concat
concatena:
	lb $t0, ($t5)	#Cargamos el byte actual del archivo 2
	beqz $t0, ultima	#Si el byte actual es cero, llegamos al final del archivo

	sb $t0, ($a1)	#Guardamos el byte en la direccion de $a1
	
	addi $a1, $a1, 1	#Aumentamos la direccion de $a1
	addi $t8, $t8, 1	#Aumentamos el contador
	addi $t5, $t5, 1	#Aumentamos la direccion de $t5
	
  	j concatena	
ultima:	
 	#Ahora $t8 tiene el numero de bytes totales de los dos archivos

 	sub $a1, $a1, $t8 #Regresamos a la direccion de memoria donde empezaba originalmente $a1
  
 	move $a2, $t8	    #el numero de bytes que leera seran los que leyo el contador
  	syscall
  
  	#Imprimimos lo que se acaba de escribir en el archivo
  	li $v0, 4
  	move $a0, $a1
  	syscall
  
  	# Cerramos el archivo.
  	li $v0, 16    
  	move $a0, $s2
  	syscall
	
	j main
fin: #Si en cat se pasan menos de dos argumentos, se imprime un warning
	la $a0, warning
	li $v0, 4
	syscall
	j main

#Caso words
caso_words:
	la $s2, buffer	#Cargamos lo del usuario en $s2
	addi $s2, $s2, 6 #Nos saltamos a la direccion de memoria donde empieza el primer argumento
	move $t7, $s2	#En $t7 ponemos el argumento, que sera la direccion del archivo
	
	#Preparamos los argumentos para llamar a jal
	li $t3, 0x0A
	move $t9, $zero
	jal sustituir #Nos regresa la cadena sin el newline
	
	#Abrimos el archivo
	li $v0, 13              # Syscall para abrir un archivo
        move $a0, $t7        # Cargamos la direccion del archivo
  	li $a1, 0               # read mode 0 para leer, 1 para escribir
  	li $a2, 0               # Permisos por defecto
  	syscall
  	move $s0, $v0           # Descriptor del archivo.
  	
  	## Lee los contenidos del archivo.
  	li $v0, 14              # Syscall para leer un archivo
  	move $a0, $s0           # Movemos el descriptor al $a0
  	la $a1, bufferA          # Carga la direccion del buffer a $a1
  	li $a2, 1000             # Limite de lectura, lee hasta 256 bytes.
  	syscall
  	
  	#Cerramos el archivo
  	li $v0, 16              # Syscall para cerrar un archivo.
  	move $a0, $s0           # Movemos el descriptor del archivo a $a0
  	syscall
  	
  	#El contenido del archivo ahora esta en $a1
  	li $t8, 0 #Contador de palabras
cuentaPalabras:
	lb $t0, ($a1)
	
	beqz $t0, numPalabras	#Si ya llegamos al final del archivo
	beq $t0, 0x20, aumentaContador	#espacio
	
	addi $a1, $a1,1
	j cuentaPalabras
aumentaContador:
	addi $t8, $t8, 1 #Aumentamos el contador
	addi $a1, $a1,1	#Aumentamos en un byte la direccion de la cadena
	j cuentaPalabras
numPalabras:#Imprimimos el numero de palabras en el archivo
	beqz $t8, sinPalabras #Si el numero de palabras es 0
	li $v0, 4
	la $a0, resPalabras
	syscall
	addi $t8, $t8, 1 #Aumentamos el contador para que se tome en cuenta la ultima palabra que termina en newline
	li $v0, 1
	move $a0, $t8 
	syscall
	j main
sinPalabras:
	li $v0, 4
	la $a0, noWords
	syscall
	j main
	
#Caso exit	
caso_exit:
	li $v0, 10
	syscall
	
#Codigo para sustituir en una palabra que esta en $t7 un caracter que esta en $t3 por 0, el contador esta en $t9
sustituir:
	lb $t2, ($t7)	#Cargamos en $t2 el byte actual de la cadena
	beq $t2, $t3, sust
	
	beq $t2, $zero, terminaPalabra #Si no tiene el caracter de $t3
	
	addi $t7, $t7, 1	#Nos movemos al siguiente byte de la palabra
	addi $t9, $t9, 1	#Aumentamos el contador
	j sustituir
sust:
	sb $zero, ($t7)
	sub $t7, $t7, $t9
	jr $ra
terminaPalabra:
	sub $t7, $t7, $t9
	jr $ra

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
	
	
