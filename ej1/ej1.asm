; Dado un entero N, tal que 0 < N < 11, la computadora muestra la tabla de multiplicar de N.





; INCLUSION DE ARCHIVOS
%include "common.inc"





; FUNCIONES EXPORTADAS
global main ; etiqueta que marca el inicio de la ejecucion





; SECCION DE LAS VARIABLES NO INICIALIZADAS
section .bss

numeroOriginal:
    resd 1

numero:
    resd 1



; SECCION DE LAS VARIABLES INICIALIZADAS
section .data





; SECCION DE LAS CONSTANTES
section .text

enunciado_str:
    db "Dado un entero N, tal que 0 < N < 11, la computadora muestra la tabla de multiplicar de N.", 10, 10, 0

ingreseNumero_str:
    db  "Ingrese un numero entre 1 y 10: ", 0

errorValidarDato_str:
    db  "Numero ingresado no cumple con la restriccion", 10, 0

imprimirNumero_str:
    db  "%d x %2d = %d", 0





; SECCION DE LAS FUNCIONES
section .text

mostrarEnunciado:
    push enunciado_str
    call printf
    add esp, 4
ret

leerNumero:                   ; RUTINA PARA LEER UN NUMERO ENTERO USANDO SCANF
    push numero
    push fmtInt
    call scanf ; scanf ("%d", &numero)
    add esp, 8
ret

validarNumero:
.mayor_a_cero:
    cmp dword [numero], 0
    jg .menor_a_once
    jmp .error
.menor_a_once:
    cmp dword [numero], 11
    jl .ok
    jmp .error
.error:
    push errorValidarDato_str
    call printf
    add esp, 4
    mov eax, 1
ret
.ok:
    xor eax, eax
ret

mostrarNumero:                ; RUTINA PARA MOSTRAR UN NUMERO ENTERO USANDO PRINTF
    ; en ecx tengo el numero de vuelta de forma decreciente
    mov eax, 10
    sub eax, ecx ; en eax tengo el numero de vuelta de forma normal (de 1 a 10)

    push dword [numero]
    push eax
    push ebx ; en ebx tengo el numero original
    push imprimirNumero_str
    call printf ; printf ("%d x %d = %d", numeroOriginal, vuelta, numero)
    add esp, 16
    call mostrarEnter
ret

ingresarNumero:
.comienzo:
    call mostrarEnunciado
    push ingreseNumero_str
    call printf ; printf ("Ingrese un numero: ");
    add esp, 4

	call leerNumero ; scanf("%d", &numero)

    call validarNumero ; chequea si 0 < numero <= 11
    cmp eax, 1
    je .comienzo ; if (ret_value == 1) goto .comienzo
ret

imprimirTabla:
    mov ebx, [numero] ; ebx = numero
	mov ecx, 9 ; for (ecx=9, ecx>0; ecx--)
.tabla:
	push ebx ; salvo registro ebx
	push ecx ; salvo registro ecx
	call mostrarNumero ; printf ("%d\n", numero)
	pop ecx ; recupero registro ecx
	pop ebx ; recupero registro ebx
	add [numero], ebx ; numero += ebx
	loop .tabla
	
	call mostrarNumero ; printf ("%d\n", numero)
ret

main:
    call ingresarNumero
    call imprimirTabla
    
    JMP salirDelPrograma
ret




