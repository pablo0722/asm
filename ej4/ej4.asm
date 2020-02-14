; Se ingresan números enteros. El ingreso finaliza cuando la
; diferencia entre dos números consecutivos se repite. La
; computadora muestra el promedio de los números ingresados.





; INCLUSION DE ARCHIVOS
%include "common.inc"





; FUNCIONES EXPORTADAS
global main ; etiqueta que marca el inicio de la ejecucion





; SECCION DE LAS VARIABLES NO INICIALIZADAS
section .bss





; SECCION DE LAS VARIABLES INICIALIZADAS
section .data

N1:
    dd 0

N2:
    dd 0

diferencia:
    dd 0





; SECCION DE LAS CONSTANTES
section .text

ingreseNumero_str:
    db  "Ingrese un numero: ", 0

diferencia_str:
    db  "La diferencia con el numero anterior es de %d", 10, 0

diferenciaRepetida_str:
    db  "Diferencia repetida", 10, 0





; SECCION DE LAS FUNCIONES
section .text

ingresarNumero:
.start:    
    push ingreseNumero_str
    call printf ; printf ("Ingrese un numero: ");
    add esp, 4

    ; intercambio N1 con N2
    mov eax, [N1]
    mov ebx, [N2]
    mov [N1], ebx
    mov [N2], eax

    ; guardo nuevo numero en N1
    push N1
    push fmtUInt
	call scanf ; scanf ("%d", &N1)
    add esp, 8
ret

calcularDiferencia:
    ; hay que mostrar diferencia en valor absoluto

    mov eax, [N1]
    cmp eax,[N2]
    jg .N1MayorN2
.N1MenorN2:
    mov eax, [N2]
    sub eax, [N1]
ret
.N1MayorN2:
    mov eax, [N1]
    sub eax, [N2]
ret

mostrarDiferencia:
    push dword [diferencia]
    push diferencia_str
    call printf ; printf ("La diferencia con el numero anterior es de %d\n", diferencia)
    add esp, 8
ret

diferenciaRepetida:
    push diferenciaRepetida_str
    call printf
    add esp, 4
ret

main:   
    call ingresarNumero

.loop:
    call ingresarNumero
    call calcularDiferencia ; guarda la diferencia en eax
    cmp eax, [diferencia]
    je .exit
    mov [diferencia], eax ; no afecta flags
    call mostrarDiferencia
    jmp .loop

.exit:
    call diferenciaRepetida

    JMP salirDelPrograma
ret




