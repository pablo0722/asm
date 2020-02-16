; Se ingresan numeros enteros. El ingreso finaliza cuando la
; diferencia entre dos numeros consecutivos se repite. La
; computadora muestra el promedio de los numeros ingresados.





; INCLUSION DE ARCHIVOS
%include "common.inc"





; FUNCIONES EXPORTADAS
global main ; etiqueta que marca el inicio de la ejecucion





; SECCION DE LAS VARIABLES NO INICIALIZADAS
section .bss

N1:
    resd 1

N2:
    resd 1





; SECCION DE LAS VARIABLES INICIALIZADAS
section .data

diferencia:
    dd 0

sumaTotal:
    dd 0

numerosIngresados:
    dd 0





; SECCION DE LAS CONSTANTES
section .text

enunciado_str:
    db  "Se ingresan numeros enteros. El ingreso finaliza cuando la", 10, \
        "diferencia entre dos numeros consecutivos se repite. La", 10, \
        "computadora muestra el promedio de los numeros ingresados.", 10, 10, 0

ingreseNumero_str:
    db  "Ingrese un numero: ", 0

diferencia_str:
    db  "La diferencia con el numero anterior es de %d", 10, 0

diferenciaRepetida_str:
    db  "Diferencia repetida", 10, 0

promedio_str:
    db  "El promedio de los numeros ingresados es: %d", 10, 0





; SECCION DE LAS FUNCIONES
section .text

mostrarEnunciado:
    push enunciado_str
    call printf
    add esp, 4
ret

ingresarNumero:
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

    mov eax, [N1]
    add [sumaTotal], eax ; acumulo el numero
    inc dword [numerosIngresados] ; incremento cantidad de numeros ingresados
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

calcularPromedio:
    mov eax, [sumaTotal]
    mov ebx, [numerosIngresados]
    idiv ebx

    push eax
    push promedio_str
    call printf
    add esp, 8
ret

main:
    call mostrarEnunciado
    call ingresarNumero
    call ingresarNumero
    call calcularDiferencia ; guarda la diferencia en eax
    mov [diferencia], eax ; no afecta flags
    call mostrarDiferencia

.loop:
    call ingresarNumero
    call calcularDiferencia ; guarda la diferencia en eax
    cmp eax, [diferencia]
    je .finLoop
    mov [diferencia], eax ; no afecta flags
    call mostrarDiferencia
    jmp .loop

.finLoop:
    call diferenciaRepetida
    call calcularPromedio

    JMP salirDelPrograma
ret




