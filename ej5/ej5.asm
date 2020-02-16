; Se ingresan 50 caracteres. La computadora los muestra ordenados y
; sin repeticiones.





; INCLUSION DE ARCHIVOS
%include "common.inc"





; FUNCIONES EXPORTADAS
global main ; etiqueta que marca el inicio de la ejecucion





; SECCION DE LAS VARIABLES NO INICIALIZADAS
section .bss

ultimoCaracterIngresado:
    resb 1





; SECCION DE LAS VARIABLES INICIALIZADAS
section .data

caracteres:
    TIMES 256 db 0 ; array de 256 caracteres (no se puede tener mas de 256 caracteres sin repetir)





; SECCION DE LAS CONSTANTES
section .text

numCaracteresAIngresar equ 50 ; constante para poder modificar facilmente la cantidad de caracteres a ingresar

enunciado_str:
    db  "Se ingresan 50 caracteres. La computadora los muestra ordenados y", 10, \
        "sin repeticiones.", 10, 10, 0

ingresarCaracter_str:
    db "Ingrese un caracter: ", 0

imprimirArray_str:
    db 10, "Caracteres ingresados ordenados y sin repetir:", 0





; SECCION DE LAS FUNCIONES
section .text

mostrarEnunciado:
    push enunciado_str
    call printf
    add esp, 4
ret

ingresarCaracter:
    push ingresarCaracter_str
    call printf
    add esp, 4

    push ultimoCaracterIngresado
    push fmtChar
    call scanf
    add esp, 8
ret

insertarOrdenado:
    ; no importa si el caracter es repetido.
    ;     Si esta repetido, se pisa con el mismo dato
    ;     si no esta repetido, piso el valor '0' (valor por default) con el dato

    mov eax, caracteres
    xor ebx, ebx ; limpio los 4 bytes de ebx
    mov bl, [ultimoCaracterIngresado] ; cargo caracter en el ultimo byte de ebx
    add eax, ebx
    mov [eax], bl
ret

imprimirArray:
    push imprimirArray_str
    call printf
    add esp, 4
    
    mov ecx, 256
    mov eax, caracteres
.loop:
    push ecx ; salvo ecx
    inc eax
    push eax ; salvo eax

    xor ebx, ebx
    mov bl, [eax]
    cmp bl, 0
    je .popPrevLoop

    push dword ebx
    push fmtChar
    call printf
    add esp, 8

.popPrevLoop:
    pop eax ; recupero eax
    pop ecx  ; recupero ecx
    loop .loop
ret

main:
    call mostrarEnunciado
    mov ecx, numCaracteresAIngresar

.loop:
    push ecx
    call ingresarCaracter ; guarda el caracter en ultimoCaracterIngresado
    call insertarOrdenado ; inserta ultimoCaracterIngresado en el array en la posicion que le corresponde
    pop ecx
    loop .loop

    call imprimirArray

    JMP salirDelPrograma
ret




