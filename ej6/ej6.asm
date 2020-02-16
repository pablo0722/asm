; Se ingresan los 10 numeros ganadores de un sorteo. A
; continuacion, se ingresan numeros. La computadora indica si los
; numeros ingresados estan entre los sorteados y en que posicion.





; INCLUSION DE ARCHIVOS
%include "common.inc"





; FUNCIONES EXPORTADAS
global main ; etiqueta que marca el inicio de la ejecucion





; SECCION DE LAS VARIABLES NO INICIALIZADAS
section .bss

ganadores:
    resd 10

sorteado:
    resd 1





; SECCION DE LAS VARIABLES INICIALIZADAS
section .data





; SECCION DE LAS CONSTANTES
section .text

enunciado_str:
    db  "Se ingresan los 10 numeros ganadores de un sorteo. A", 10, \
        "continuacion, se ingresan numeros. La computadora indica si los", 10, \
        "numeros ingresados estan entre los sorteados y en que posicion.", 10, 10, 0

ingresarSorteado_str:
    db "Ingrese numero a sortear: ", 0

esPerdedor_str:
    db "El numero sorteado NO se encuentra entre los ganadores", 10, 0

esGanador_str:
    db "El numero sorteado es ganador en la posicion %d", 10, 0

mostrarGanadores_str:
    db "Los numeros ganadores son: ", 0





; SECCION DE LAS FUNCIONES
section .text

ingresarGanador_str:
    db "Ingrese un numero ganador: ", 0

mostrarEnunciado:
    push enunciado_str
    call printf
    add esp, 4
ret

ingresarGanadores:
    mov ecx, 10
    mov eax, ganadores

.loop:
    push ecx ; salvo ecx
    push eax ; salvo eax

    push ingresarGanador_str
    call printf
    add esp, 4

    mov eax, [esp] ; recupero eax pero no lo saco del stack
    push fmtInt
    call scanf
    add esp, 4

    pop eax ; recupero eax
    add eax, 4 ; muevo eax a la siguiente posicion
    pop ecx ; recupero ecx
    loop .loop
ret

ingresarSorteado:
    push ingresarSorteado_str
    call printf
    add esp, 4

    push sorteado
    push fmtInt
    call scanf
    add esp, 8
ret

informarPosicion:
    mov eax, ganadores
    mov ebx, [sorteado]
    mov ecx, 10

.loop:
    cmp [eax], ebx
    je .esGanador

    add eax, 4 ; muevo eax a la siguiente posicion
    loop .loop

.esPerdedor:
    push esPerdedor_str
    call printf
    add esp, 4
    jmp .fin

.esGanador:
    ; transformo contador en formato creciente
    mov eax, 11 ; 11 para que muestre desde la posicion 1 y no la 0
    sub eax, ecx

    push eax
    push esGanador_str
    call printf
    add esp, 8
    jmp .fin

.fin:
ret

mostrarGanadores:
    push mostrarGanadores_str
    call printf
    add esp, 4

    mov ecx, 10
    mov eax, ganadores

.loop:
    push ecx ; salvo ecx
    push eax ; salvo eax
    
    push dword [eax]
    push fmtInt
    call printf
    add esp, 8

    call mostrarEspacio

    pop eax ; recupero eax
    add eax, 4 ; muevo eax a la siguiente posicion
    pop ecx ; recupero ecx
    loop .loop
    
    call mostrarEnter
ret

main:
    call mostrarEnunciado

    call ingresarGanadores
    call mostrarGanadores

.loop: ; while (1)
    call ingresarSorteado ; ingresa un numero sorteado y lo guarda en 'sorteado'
    call informarPosicion ; informa si es un ganador y en que posicion se encuentra
    jmp .loop
    
    call mostrarGanadores ; para debug

    JMP salirDelPrograma
ret




