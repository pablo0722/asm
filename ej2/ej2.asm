; Se ingresa una cadena. La computadora indica si es un palindromo.





; INCLUSION DE ARCHIVOS
%include "common.inc"





; FUNCIONES EXPORTADAS
global main ; etiqueta que marca el inicio de la ejecucion





; SECCION DE LAS VARIABLES NO INICIALIZADAS
section .bss

cadena:
    resb 32

idx:
    resd 1



; SECCION DE LAS VARIABLES INICIALIZADAS
section .data





; SECCION DE LAS CONSTANTES
section .text

enunciado_str:
    db "Se ingresa una cadena. La computadora indica si es un palindromo.", 10, 10, 0

ingreseCadena_str:
    db  "Ingrese una cadena: ", 0

esPalindromo_str:
    db  "La cadena ingresada SI es un palindromo", 10, 0

noEsPalindromo_str:
    db  "La cadena ingresada NO es un palindromo", 10, 0

cadenaVacia_str:
    db  "Cadena vacia", 10, 0





; SECCION DE LAS FUNCIONES
section .text

mostrarEnunciado:
    push enunciado_str
    call printf
    add esp, 4
ret

leerCadena:
    push cadena
    call gets ; gets (cadena)
    add esp, 4
ret

mostrarCadena:
    push cadena
    call printf ; printf (cadena)
    add esp, 4
ret

ingresarCadena:
    push ingreseCadena_str
    call printf ; printf ("Ingrese una cadena: ");
    add esp, 4

	call leerCadena ; gets (cadena)
ret

analizarPalindromo:
    push cadena
    call strlen
    add esp, 4
    ; eax es el tamaño de la cadena (es el indice del '\0' de la cadena)

    cmp eax, 0
    jle .cadena_vacia


    ; eax va a apuntar a los caracteres moviendose desde el final al comienzo
    ; bx va a contener el caracter apuntado por eax
    ; ecx va a apuntar a los caracteres moviendose desde comienzo al final
    ; dx va a contener el caracter apuntado por ecx
    ; va a dejar de comparar cuando ebx y edx sean distintos o cuando eax <= ecx

    dec eax ; eax es el indice del ultimo caracter de la cadena


    add eax, cadena ; eax apunta al ultimo caracter de la cadena


    mov ecx, cadena ; ecx apunta al primer caracter de la cadena
    
    jmp .compara_loop

.loop:
    dec eax ; muevo puntero eax un lugar hacia el comienzo de la cadena
    inc ecx ; muevo puntero ecx un lugar hacia el final de la cadena

.compara_loop:
    mov ebx, [eax]
    mov edx, [ecx]


    cmp eax, ecx
    jle .si_es_palindromo ; salgo del loop cuando eax <= ecx

    cmp bl, dl
    jne .no_es_palindromo ; salgo del loop cuando ebx y edx son distintos

    jmp .loop

.si_es_palindromo:
    push esPalindromo_str
    call printf
    add esp, 4
ret

.no_es_palindromo:
    push noEsPalindromo_str
    call printf
    add esp, 4
ret

.cadena_vacia:
    push cadenaVacia_str
    call printf
    add esp, 4
ret

main:
    call mostrarEnunciado
    call ingresarCadena
    call analizarPalindromo
    
    JMP salirDelPrograma
ret




