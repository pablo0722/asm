; Se ingresa una matriz de NxM componentes. La computadora indica
; el elemento minimo de toda la matriz y las posiciones en que
; aparece.





; INCLUSION DE ARCHIVOS
%include "common.inc"





; FUNCIONES EXPORTADAS
global main ; etiqueta que marca el inicio de la ejecucion





; SECCION DE LAS CONSTANTES
section .text

N equ 3 ; numero de filas
    
M equ 4 ; numero de columnas

enunciado_str:
    db  "Se ingresa una matriz de NxM componentes. La computadora indica", 10, \
        "el elemento minimo de toda la matriz y las posiciones en que", 10, \
        "aparece.", 10, 10, 0

ingresarMatriz_str:
    db "Complete la matriz:", 10, 0

ingresarPosicionMatriz_str:
    db "[%d, %d]: ", 0

mostrarPosicionMatriz_str:
    db "[%3d, %3d]: %10d", 0

mostrarMatrizSinPosicion_str:
    db "%10d", 0

encontrarMinimo_str:
    db "El minimo es: %d, posicion [%d, %d]", 0





; SECCION DE LAS VARIABLES NO INICIALIZADAS
section .bss

matriz:
    resd N*M ; trato a la matriz de forma lineal

minimo:
    resd 1





; SECCION DE LAS VARIABLES INICIALIZADAS
section .data





; SECCION DE LAS FUNCIONES
section .text

mostrarEnunciado:
    push enunciado_str
    call printf
    add esp, 4
ret

ingresarMatriz:
    push ingresarMatriz_str
    call printf
    add esp, 4

    mov eax, matriz

    mov ecx, N
    ; for (i=N; i>0; i--) // recorre las filas
.loopN:
    push ecx ; salvo ecx

    mov ecx, M
    ; for (j=M; j>0; j--) // recorre las columnas
.loopM:
    push eax ; salvo eax
    push ecx ; guardo numero de columna}

    mov eax, M
    sub eax, ecx ; el ecx del loop anterior (numero de fila)
    push eax
    mov eax, N
    sub eax, [esp + 12] ; el ecx del loop anterior (numero de fila)
    push eax
    push ingresarPosicionMatriz_str
    call printf
    add esp, 12

    push dword [esp + 4] ; push eax guardado (posicion en la matriz)
    push fmtInt
    call scanf
    add esp, 8

    pop ecx ; recupero numero de columna
    pop eax ; recupero eax
    add eax, 4 ; muevo eax a la siguiente posicion
    loop .loopM

    push eax ; salvo eax
    call mostrarEnter
    pop eax ; recupero eax

    pop ecx ; recupero ecx
    loop .loopN
ret

; muestra cada elemento de la matriz junto con su posicion
mostrarMatriz:
    mov eax, matriz

    mov ecx, N
    ; for (i=N; i>0; i--) // recorre las filas
.loopN:
    push ecx ; salvo ecx

    mov ecx, M
    ; for (j=M; j>0; j--) // recorre las columnas
.loopM:
    push eax ; salvo eax
    push ecx ; guardo numero de columna
    
    mov ebx, [esp + 4] ; muevo a ebx el eax guardado (posicion en la matriz)
    push dword [ebx]
    mov eax, M
    sub eax, ecx ; el ecx del loop actual (numero de columna)
    push eax
    mov eax, N
    sub eax, [esp + 16] ; el ecx del loop anterior (numero de fila)
    push eax
    push mostrarPosicionMatriz_str
    call printf
    add esp, 16

    call mostrarEspacio

    pop ecx ; recupero numero de columna
    pop eax ; recupero eax
    add eax, 4 ; muevo eax a la siguiente posicion
    loop .loopM

    push eax ; salvo eax
    call mostrarEnter
    pop eax ; recupero eax

    pop ecx ; recupero ecx
    loop .loopN
ret

; muestra cada elemento de la matriz sin la posicion
mostrarMatrizSinPosicion:
    mov eax, matriz

    mov ecx, N
    ; for (i=N; i>0; i--) // recorre las filas
.loopN:
    push ecx ; salvo ecx

    mov ecx, M
    ; for (j=M; j>0; j--) // recorre las columnas
.loopM:
    push eax ; salvo eax
    push ecx ; guardo numero de columna
    
    mov ebx, [esp + 4] ; muevo a ebx el eax guardado (posicion en la matriz)
    push dword [ebx]
    push mostrarMatrizSinPosicion_str
    call printf
    add esp, 8

    call mostrarEspacio

    pop ecx ; recupero numero de columna
    pop eax ; recupero eax
    add eax, 4 ; muevo eax a la siguiente posicion
    loop .loopM

    push eax ; salvo eax
    call mostrarEnter
    pop eax ; recupero eax

    pop ecx ; recupero ecx
    loop .loopN
ret

encontrarMinimo:
    ; eax va a apuntar a cada elemento de la matriz
    ; ecx es el contador de los loops
    ; ebx va a guardar el minimo de la matriz
    ; esi va a guardar la fila del minimo de la matriz
    ; edi va a guardar la columna del minimo de la matriz
    mov eax, matriz

    mov ebx, [eax] ; muevo primer elemento de la matriz a ebx
    xor esi, esi
    xor edi, edi

    mov ecx, N
    ; for (i=N; i>0; i--) // recorre las filas
.loopN:
    push ecx

    mov ecx, M
    ; for (j=M; j>0; j--) // recorre las columnas
.loopM:    
    cmp [eax], ebx
    jg .popPrevLoop ; si el nuevo numero es mayor a 'minimo', continuo; sino, guardo el nuevo numero como 'minimo'
    mov ebx, [eax]
    mov esi, N
    sub esi, [esp] ; esi = ecx del loop anterior (numero de fila)
    mov edi, M
    sub edi, ecx ; edi = ecx del loop actual (nnumero de columna) 

.popPrevLoop:
    add eax, 4 ; muevo eax a la siguiente posicion
    inc edx
    loop .loopM

    pop ecx
    loop .loopN

    ; en este punto tengo al minimo guardado en ebx
    mov [minimo], ebx

    push edi
    push esi
    push ebx
    push encontrarMinimo_str
    call printf
    add esp, 16
ret

main:
    call mostrarEnunciado
    call ingresarMatriz

    call mostrarMatriz
    call mostrarEnter

    call mostrarMatrizSinPosicion
    call mostrarEnter

    call encontrarMinimo ; guarda en 'minimo' el valor del minimo de la matriz

    JMP salirDelPrograma
ret




