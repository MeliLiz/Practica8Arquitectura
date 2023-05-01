.data
filename1:  .asciiz "/home/meli/Escritorio/P8/input.txt"  # Nombre del archivo a leer
filename2:  .asciiz "/home/meli/Escritorio/P8/input1.txt"
buffer:     .space  256

.text
main:
    # Abrir el primer archivo en modo de escritura
    li $v0, 13           # Cargar el código de servicio para abrir un archivo
    la $a0, filename1    # Cargar la dirección del nombre del archivo
    li $a1, 1            # Abrir el archivo en modo de escritura
    li $a2, 0            # Establecer los permisos del archivo en 0
    syscall
    move $s0, $v0        # Guardar el identificador del archivo en $s0

    # Abrir el segundo archivo en modo de lectura
    li $v0, 13           # Cargar el código de servicio para abrir un archivo
    la $a0, filename2    # Cargar la dirección del nombre del archivo
    li $a1, 0            # Abrir el archivo en modo de lectura
    li $a2, 0            # Establecer los permisos del archivo en 0
    syscall
    move $s1, $v0        # Guardar el identificador del archivo en $s1

    # Leer el contenido del segundo archivo y escribirlo en el primer archivo
    loop:
        li $v0, 14           # Cargar el código de servicio para leer un archivo
        move $a0, $s1        # Cargar el identificador del archivo
        la $a1, buffer       # Cargar la dirección del búfer de lectura
        
        li $v0, 4
        move $a0, $a1
        syscall
        li $v0, 14           # Cargar el código de servicio para leer un archivo
        move $a0, $s1        # Cargar el identificador del archivo
        li $a2, 256          # Establecer el tamaño máximo de lectura
        syscall
        beq $v0, 0, endloop  # Salir del ciclo si no hay más datos que leer

        li $v0, 15           # Cargar el código de servicio para escribir en un archivo
        move $a0, $s0        # Cargar el identificador del archivo
        la $a1, buffer       # Cargar la dirección del búfer de escritura
        move $a2, $v0        # Cargar la cantidad de bytes leídos
        syscall

        j loop

    endloop:

    # Cerrar los archivos
    li $v0, 16           # Cargar el código de servicio para cerrar un archivo
    move $a0, $s0        # Cargar el identificador del primer archivo
    syscall

    li $v0, 16           # Cargar el código de servicio para cerrar un archivo
    move $a0, $s1        # Cargar el identificador del segundo archivo
    syscall

    # Salir del programa
    li $v0, 10           # Cargar el código de servicio para salir del programa
    syscall
