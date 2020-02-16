; INCLUSION DE FUNCIONES EXTERNAS
extern printf
extern scanf
extern scanf  ; FUNCIONES DE C (IMPORTADAS)
extern exit
extern gets   ; GETS ES MUY PELIGROSA. SOLO USARLA EN EJERCICIOS BASICOS, JAMAS EN EL TRABAJO!!!
extern getchar
extern strlen





; SECCION DE LAS CONSTANTES
section .text

fmtInt:
    db  "%d", 0         ; formato para numero entero 32bits signado

fmtUInt:
    db  "%u", 0         ; formato para numero entero 32bits no signado

fmtHex:
    db  "%#x", 0        ; formato para numero entero 32bits en hexa

fmtString:
    db  "%s", 0         ; formato para cadenas

fmtChar:
    db  " %c", 0        ; formato para caracteres. Espacio en blanco para ignorar espacios y '\n' en el scanf

fmtbyte:
    db  "%hhd", 0       ; formato para bytes

fmtNL:
    db    10, 0         ; SALTO DE LINEA (LF)

fmtSpace:
    db    " ", 0         ; Espacio

finDePrograma_str:
    db  10, "Fin de programa", 10, 0





; SECCION DE LAS CONSTANTES PARA DEBUG
section .text

fmtRegs:
    db  10, "eax: %#x, ebx: %#x, ecx: %#x, edx: %#x, esi: %#x, edi: %#x", 10, 0 ; formato para 6 numeros enteros 32bits en hexa (para los 6 registros)





; SECCION DE LAS FUNCIONES
section .text

mostrarEnter:
    push fmtNL
    call printf
    add esp, 4
ret

mostrarEspacio:
    push fmtSpace
    call printf
    add esp, 4
ret

salirDelPrograma:             ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
    push finDePrograma_str
    call printf ; printf("Fin de programa\n")
    add esp, 4

    push 0
    call exit ; exit(0)
    add esp, 4
ret





; SECCION DE LAS FUNCIONES PARA DEBUG
section .text

DEBUG_reset_regs: ; resetea todos los registros a cero
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor esi, esi
    xor edi, edi
ret

DEBUG_print_regs: ; imprime todos los registro
    pushad

    push edi
    push esi
    push edx
    push ecx
    push ebx
    push eax
    push fmtRegs
    call printf
    add esp, 28
    
    popad
ret