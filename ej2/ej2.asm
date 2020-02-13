; Se ingresa una cadena. La computadora indica si es un palíndromo.





; INCLUSION DE ARCHIVOS
%include "common.inc"





; FUNCIONES EXPORTADAS
global main ; etiqueta que marca el inicio de la ejecucion





; SECCION DE LAS VARIABLES NO INICIALIZADAS
section .bss

cadena:
    resb 32
cadena_len equ $ - cadena ; largo de la cadena

idx:
    resd 1



; SECCION DE LAS VARIABLES INICIALIZADAS
section .data





; SECCION DE LAS CONSTANTES
section .text

ingreseCadena_str:
    db  "Ingrese una cadena: ", 0
ingreseCadena_len equ $ - ingreseCadena_str ; largo de la cadena

sonIguales_str:
    db  "son iguales", 10, 0
sonIguales_len equ $ - sonIguales_str ; largo de la cadena

sonDistintas_str:
    db  "son distintas", 10, 0
sonDistintas_len equ $ - sonDistintas_str ; largo de la cadena

finDePrograma_str:
    db  10, "Fin de programa", 10, 0
finDePrograma_len equ $ - finDePrograma_str ; largo de la cadena





; SECCION DE LAS FUNCIONES
section .text

leerCadena:
    push cadena
    call gets ; fgets (cadena, cadena_len, stdin)
    add esp, 4
ret

mostrarCadena:
    push cadena
    call printf ; printf (cadena)
    add esp, 4
ret

mostrarEnter:
    push fmtNL
    call printf
    add esp, 4
ret

ingresarCadena:
.start:    
    push ingreseCadena_str
    call printf ; printf ("Ingrese una cadena: ");
    add esp, 4

	call leerCadena ; fgets (cadena, cadena_len, stdin)
ret

salirDelPrograma:             ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
    push finDePrograma_str
    call printf ; printf("Fin de programa\n")
    add esp, 4

    push 0
    call exit ; exit(0)
    add esp, 4
ret

analizarPalindromo:
    push cadena
    call strlen
    add esp, 4

    mov [idx], eax
    sub dword eax, 1
    add eax, cadena

    mov eax, [eax]
    cmp al, [cadena]
    je .sonIguales
    push sonDistintas_str
    call printf
    add esp, 4
ret
.sonIguales: 
    push sonIguales_str
    call printf
    add esp, 4
ret

main:		                  ; PUNTO DE INICIO DEL PROGRAMA
    call ingresarCadena
    call analizarPalindromo
    
    JMP salirDelPrograma
ret




