; Se ingresa una matriz de NxN componentes enteras. La computadora
; muestra el producto de los valores ubicados en la diagonal
; principal.





; INCLUSION DE ARCHIVOS
%include "common.inc"





; FUNCIONES EXPORTADAS
global main ; etiqueta que marca el inicio de la ejecucion





; SECCION DE LAS CONSTANTES
section .text

N equ 3 ; numero de filas y de columnas (es una matriz cuadrada)

enunciado_str:
    db  "Se ingresa una matriz de NxN componentes enteras. La computadora", 10, \
        "muestra el producto de los valores ubicados en la diagonal", 10, \
        "principal.", 10, 10, 0

ingresarMatriz_str:
    db "Complete la matriz:", 10, 0

ingresarPosicionMatriz_str:
    db "[%d, %d]: ", 0

mostrarPosicionMatriz_str:
    db "[%3d, %3d]: %10d", 0

mostrarMatrizSinPosicion_str:
    db "%10d", 0

producto_str:
    db "el producto de la diagonal principal es %d", 10, 0





; SECCION DE LAS VARIABLES NO INICIALIZADAS
section .bss

matriz:
    resd N*N ; trato a la matriz de forma lineal





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
.loopN1:
    push ecx ; salvo ecx

    mov ecx, N
    ; for (j=M; j>0; j--) // recorre las columnas
.loopN2:
    push eax ; salvo eax
    push ecx ; guardo numero de columna}

    mov eax, N
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
    loop .loopN2

    push eax ; salvo eax
    call mostrarEnter
    pop eax ; recupero eax

    pop ecx ; recupero ecx
    loop .loopN1
ret

; muestra cada elemento de la matriz junto con su posicion
mostrarMatriz:
    mov eax, matriz

    mov ecx, N
    ; for (i=N; i>0; i--) // recorre las filas
.loopN1:
    push ecx ; salvo ecx

    mov ecx, N
    ; for (j=M; j>0; j--) // recorre las columnas
.loopN2:
    push eax ; salvo eax
    push ecx ; guardo numero de columna
    
    mov ebx, [esp + 4] ; muevo a ebx el eax guardado (posicion en la matriz)
    push dword [ebx]
    mov eax, N
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
    loop .loopN2

    push eax ; salvo eax
    call mostrarEnter
    pop eax ; recupero eax

    pop ecx ; recupero ecx
    loop .loopN1
ret

; muestra cada elemento de la matriz sin la posicion
mostrarMatrizSinPosicion:
    mov eax, matriz

    mov ecx, N
    ; for (i=N; i>0; i--) // recorre las filas
.loopN1:
    push ecx ; salvo ecx

    mov ecx, N
    ; for (j=M; j>0; j--) // recorre las columnas
.loopN2:
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
    loop .loopN2

    push eax ; salvo eax
    call mostrarEnter
    pop eax ; recupero eax

    pop ecx ; recupero ecx
    loop .loopN1
ret

calcularProducto:
    ; ebx va a apuntar a cada elemento de la matriz
    ; ecx es el contador de los loops
    ; eax va a acumular los resultados de las multiplicaciones
    mov ebx, matriz
    mov eax, 1 ; valor neutro de la multiplicacion

    mov ecx, N
    ; for (i=N; i>0; i--) // recorre las filas
.loopN1:
    push ecx ; salvo ecx

    mov ecx, N
    ; for (j=M; j>0; j--) // recorre las columnas
.loopN2:

    cmp ecx, [esp] ; comparo ecx del loop actual con el del loop anterior
    jne .continuo ;  si no son iguales continuo. si son iguales, multiplico
    imul dword [ebx] ; eax = eax * [ebx]. eax va a acumular los resultados de las multiplicaciones
.continuo:
    add ebx, 4 ; muevo ebx a la siguiente posicion
    loop .loopN2

    pop ecx ; recupero ecx
    loop .loopN1

    push eax
    push producto_str
    call printf
    add esp, 8
ret

main:
    call mostrarEnunciado
    call ingresarMatriz

    call mostrarMatriz
    call mostrarEnter

    call mostrarMatrizSinPosicion
    call mostrarEnter

    call calcularProducto ; calcula el producto de la diagonal principal

    JMP salirDelPrograma
ret




