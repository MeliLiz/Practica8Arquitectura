#Programa en MIPS que lee un archivo.
.data
archivo: .asciiz "/home/meli/Escritorio/P8/input.txt"  # Nombre del archivo a leer
archivo1: .asciiz "/home/meli/Escritorio/P8/input1.txt"
buffer: .space  256          # Buffer que contiene los datos del archivo.
buffer1: .space  256          # Buffer que contiene los datos del archivo.

.text
.globl main

main:
  # Abrimos el archivo1 para leer
  li $v0, 13              # Syscall para abrir un archivo
  la $a0, archivo1        # Cargamos la direccion del archivo
  li $a1, 0               # read mode 0 para leer, 1 para escribir
  li $a2, 0               # Permisos por defecto
  syscall
  move $s0, $v0           # Descriptor del archivo.
  

  # Lee los contenidos del archivo.
  li $v0, 14              # Syscall para leer un archivo
  move $a0, $s0           # Movemos el descriptor al $a0
  la $a1, buffer          # Carga la direccion del buffer a $a1
  li $a2, 256             # Limite de lectura, lee hasta 256 bytes.
  syscall
  
  #Cerramos el archivo
  li $v0, 16              # Syscall para cerrar un archivo.
  move $a0, $s0           # Movemos el descriptor del archivo a $a0
  syscall
  
  
  #Abrimos el segundo archivo para leer
   li $v0, 13              # Syscall para abrir un archivo
   la $a0, archivo        # Cargamos la direccion del archivo
   li $a1, 0               # read mode 0 para leer, 1 para escribir
   li $a2, 0               # Permisos por defecto
   syscall
   move $s1, $v0           # Descriptor del archivo.
  
  # Lee los contenidos del archivo.
  li $v0, 14              # Syscall para leer un archivo
  move $a0, $s1           # Movemos el descriptor al $a0
  la $a1, buffer1          # Carga la direccion del buffer a $a1
  li $a2, 256             # Limite de lectura, lee hasta 256 bytes.
  syscall
  
  # Cerramos el archivo.
  li $v0, 16    
  move $a0, $s1
  syscall
  
  
  # Abrimos el archivo para escribir
  li $v0, 13              # Syscall para abrir un archivo
  la $a0, archivo        # Cargamos la direccion del archivo
  li $a1, 1               # read mode 0 para leer, 1 para escribir
  li $a2, 0               # Permisos por defecto
  syscall
  move $s2, $v0           # Descriptor del archivo.
  
  #Escribir el archivo
  li $v0, 15
  move $a0, $s2		#Descriptor
  la $a1, buffer
  la $t5, buffer1
  
  li $t8, 0 #contador
  
concat:
	lb $t0, 0($a1)
	beqz $t0, concatena
	
	addi $a1, $a1, 1
	addi $t8, $t8, 1
  	j concat

concatena:
	lb $t0, ($t5)
	beqz $t0, ultima

	sb $t0, ($a1)
	
	addi $a1, $a1, 1
	addi $t8, $t8, 1
	addi $t5, $t5, 1
	
  	j concatena
  	
ultima:	
  sub $a1, $a1, $t8
  
  move $a2, $t8
  syscall
  #la $a1, buffer1
  #syscall
  
  # Cerramos el archivo.
  li $v0, 16    
  move $a0, $s2
  syscall
  

  
  
                  
                                  
                                                                  

  

  # Bai Bai
  li $v0, 10
  syscall
