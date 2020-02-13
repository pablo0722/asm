; Se ingresa una cadena. La computadora indica si es un palíndromo.
;
;
; En Windows (1 en la consola de NASM; 2 y 3 en la consola de Visual Studio):
; 1) nasm -f win32 ejercicio2.asm --PREFIX _
; 2) link /out:ejercicio2.exe ejercicio2.obj libcmt.lib
; 3) ejercicio2
;
; En Windows (1 en la consola de NASM; 2 y 3 en la consola de Windows, dentro de la carpeta [ajustando los nros. de version]: C:\Qt\Qt5.3.1\Tools\mingw482_32\bin ):
; 1) nasm -f win32 ejercicio2.asm --PREFIX _
; 2) gcc -m32 ejercicio2.obj -o ejercicio2.exe
; 3) ejercicio2
;
; En GNU/Linux:
; 1) nasm -f elf ejercicio2.asm
; 2) ld -s -o ejercicio2 ejercicio2.o -lc -I /lib/ld-linux.so.2
; 3) ./ejercicio2
;
; En GNU/Linux de 64 bits (Previamente, en Ubuntu, hay que ejecutar: sudo apt-get install libc6-dev-i386):
; 1) nasm -f elf ejercicio2.asm
; 2) ld -m elf_i386 -s -o ejercicio2 ejercicio2.o -lc -I /lib/ld-linux.so.2
; 3) ./ejercicio2


        global main              ; ETIQUETAS QUE MARCAN EL PUNTO DE INICIO DE LA EJECUCION
        global _start

        extern printf            ;
        extern scanf             ; FUNCIONES DE C (IMPORTADAS)
        extern exit              ;
        extern gets              ; GETS ES MUY PELIGROSA. SOLO USARLA EN EJERCICIOS BASICOS, JAMAS EN EL TRABAJO!!!



section .bss                     ; SECCION DE LAS VARIABLES

numero:
        resd    1                ; 1 dword (4 bytes)

cadena:
        resb    0x0100           ; 256 bytes

caracter:
        resb    1                ; 1 byte (dato)
        resb    3                ; 3 bytes (relleno)



section .data                    ; SECCION DE LAS CONSTANTES

fmtInt:
        db    "%d", 0            ; FORMATO PARA NUMEROS ENTEROS

fmtString:
        db    "%s", 0            ; FORMATO PARA CADENAS

fmtChar:
        db    "%c", 0            ; FORMATO PARA CARACTERES

fmtLF:
        db    0xA, 0             ; SALTO DE LINEA (LF)

msgSI:
	db    "La palabra es un palindromo", 0

msgNO:
	db    "La palabra NO es un palindromo", 0

msgIng:
	db    "Ingrese una palabra", 0

section .text                    ; SECCION DE LAS INSTRUCCIONES
 
leerCadena:                      ; RUTINA PARA LEER UNA CADENA USANDO GETS
        push cadena
        call gets
        add esp, 4
        ret

leerNumero:                      ; RUTINA PARA LEER UN NUMERO ENTERO USANDO SCANF
        push numero
        push fmtInt
        call scanf
        add esp, 8
        ret
    
mostrarCadena:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
        push cadena
        push fmtString
        call printf
        add esp, 8
        ret

mostrarNumero:                   ; RUTINA PARA MOSTRAR UN NUMERO ENTERO USANDO PRINTF
        push dword [numero]
        push fmtInt
        call printf
        add esp, 8
        ret

mostrarCaracter:                 ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF
        push dword [caracter]
        push fmtChar
        call printf
        add esp, 8
        ret

mostrarSaltoDeLinea:             ; RUTINA PARA MOSTRAR UN SALTO DE LINEA USANDO PRINTF
        push fmtLF
        call printf
        add esp, 4
        ret

salirDelPrograma:                ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
        push 0
        call exit

_start:
main:                            ; PUNTO DE INICIO DEL PROGRAMA
        call leerCadena
        mov edi, 0
        mov eax, 0
	mov ecx, 0
	mov cadena, msgIng
	call mostrarCadena

longitud:
        mov al,[edi + cadena]
	inc ecx
        cmp al, 0 	;compara con null
        je recorrer	;si es igual a 0 

recorrer:


seguir:
        mov al,[edi + cadena]
        cmp al, 0 	;compara con null
        je finPrograma	;si es igual a 0 
        cmp al, 97	;compara con a
        jb dejar	;si es menor
        cmp al, 122	;compara con z
        ja dejar	;si es mayor
        sub al, 32 	;resta 32 pasa cazar la mayuscula si esta entre 97 y 122 y almacena en al

dejar:                
        mov [caracter], al 	;
        call mostrarCaracter
        inc edi			;suma 1 a edi
        jmp seguir 

finPrograma:
        call mostrarSaltoDeLinea
        jmp salirDelPrograma
