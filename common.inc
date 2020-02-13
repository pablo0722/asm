; INCLUSION DE FUNCIONES EXTERNAS
extern printf ;
extern scanf  ; FUNCIONES DE C (IMPORTADAS)
extern exit   ;
extern gets   ; GETS ES MUY PELIGROSA. SOLO USARLA EN EJERCICIOS BASICOS, JAMAS EN EL TRABAJO!!!
extern strlen





section .text

fmtInt:
    db  "%d", 0         ; formato para numero entero 32bits

fmtString:
    db  "%s", 0         ; formato para cadenas

fmtChar:
    db    "%c", 0   ; FORMATO PARA CARACTERES

fmtNL:
    db    10, 0             ; SALTO DE LINEA (LF)