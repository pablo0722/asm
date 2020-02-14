; Se ingresa una cadena. La computadora la muestra en mayusculas.





; INCLUSION DE ARCHIVOS
%include "common.inc"





; FUNCIONES EXPORTADAS
global main ; etiqueta que marca el inicio de la ejecucion





; SECCION DE LAS VARIABLES NO INICIALIZADAS
section .bss

cadena:
    resb    0x0100           ; 256 bytes

caracter:
    resb    1                ; 1 byte (dato)
    resb    3                ; 3 bytes (relleno)



; SECCION DE LAS VARIABLES INICIALIZADAS
section .data





; SECCION DE LAS CONSTANTES
section .text

ingreseCadena_str:
    db  "Ingrese una cadena: ", 0

cadenaMayuscula_str:
    db  "Cadena en mayusculas: ", 0





; SECCION DE LAS FUNCIONES
section .text

ingresarCadena:
.start:    
    push ingreseCadena_str
    call printf ; printf ("Ingrese una cadena: ");
    add esp, 4

	call leerCadena ; gets (cadena)
ret

leerCadena:                      ; rutina para leer una cadena usando gets
    push cadena
    call gets
    add esp, 4
    ret

mostrarCaracter:                 ; rutina para mostrar un caracter usando printf
    push dword [caracter]
    push fmtChar
    call printf
    add esp, 8
    ret

main:
    call ingresarCadena
    
    push cadenaMayuscula_str
    call printf ; printf ("Cadena en mayusculas: ");
    add esp, 4

    mov edi,0
    mov eax, 0   
    
.seguir:
    mov al, [edi + cadena]
    cmp al, 0 	;compara con null
    je .finPrograma	;si es igual a 0 
    cmp al, 97	;compara con a
    jb .dejar	;si es menor
    cmp al, 122	;compara con z
    ja .dejar	;si es mayor
    sub al, 32 	;resta 32 pasa cazar la mayuscula si esta entre 97 y 122 y almacena en al

.dejar:
    mov [caracter], al
    call mostrarCaracter
    inc edi
    jmp .seguir 

.finPrograma:
    call mostrarEnter
    jmp salirDelPrograma
