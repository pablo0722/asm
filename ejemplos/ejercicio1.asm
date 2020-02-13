; Dado un entero N, tal que 0 < N < 11, la computadora muestra la tabla de multiplicar de N.
;

;
; En Windows (1 en la consola de NASM; 2 y 3 en la consola de Visual Studio):

; 1) nasm -f win32 ejercicio1.asm --PREFIX _

; 2) link /out:ejercicio1.exe ejercicio1.obj libcmt.lib

; 3) ejercicio1
;

; En Windows (1 en la consola de NASM; 2 y 3 en la consola de Windows, dentro de la carpeta [ajustando los nros. de version]: C:\Qt\Qt5.3.1\Tools\mingw482_32\bin ):

; 1) nasm -f win32 ejercicio1.asm --PREFIX _

; 2) gcc -m32 ejercicio1.obj -o ejercicio1.exe

; 3) ejercicio1
;

; En GNU/Linux:

; 1) nasm -f elf ej3.asm

; 2) ld -s -o ej3 ej3.o -lc -I /lib/ld-linux.so.2

; 3) ./ej3

;

; En GNU/Linux de 64 bits (Previamente, en Ubuntu, hay que ejecutar: sudo apt-get install libc6-dev-i386):

; 1) nasm -f elf ej3.asm

; 2) ld -m elf_i386 -s -o ej3 ej3.o -lc -I /lib/ld-linux.so.2

; 3) ./ej3




        

	global main		; ETIQUETAS QUE MARCAN EL PUNTO DE INICIO DE LA EJECUCION

        global _start



        extern printf            ;
        
	extern scanf             ; FUNCIONES DE C (IMPORTADAS)

        extern exit              ;

        extern gets              ; GETS ES MUY PELIGROSA. SOLO USARLA EN EJERCICIOS BASICOS, JAMAS EN EL TRABAJO!!!







section .bss                     ; SECCION DE LAS VARIABLES



numero:

        resd    1                ; 1 dword (4 bytes)



caracter:

        resb    1                ; 1 byte (dato)

        resb    3                ; 3 bytes (relleno)



matriz:
	resd	100		 ;  matriz como maximo de 10x10
		

n:
	resd	1		 ;  lado de la matriz (cuadrada)


f:
	resd	1		 ; fila

c:
	resd	1		 ; columna





section .data                    ; SECCION DE LAS CONSTANTES


cadena:
        db    "Ingrese un numero entre 1 y 10", 0



fmtInt:

        db    "%d", 0            ; FORMATO PARA NUMEROS ENTEROS



fmtString:

        db    "%s", 0            ; FORMATO PARA CADENAS



fmtChar:

        db    "%c", 0            ; FORMATO PARA CARACTERES



fmtLF:

        db    0xA, 0             ; SALTO DE LINEA (LF)



nStr:

	db    "N: ", 0		 ; Cadena "N: "



filaStr:

	db    "Fila:", 0	 ;  Cadena "Fila:"
	


columnaStr:

	db    "Columna:", 0	 ;  Cadena "Columna:"



cadenaStr:

	db    "Ingrese un numero: ", 0	 ;  Cadena "Ingrese un numero: "

piso:
        db    "0", 0           ; Piso



techo:
        db    "0b", 0           ; techo


section .text                    ; SECCION DE LAS INSTRUCCIONES
 


leerCadena:                      ; RUTINA PARA LEER UNA CADENA USANDO GETS

        push cadena

        call gets

        add esp, 4

	ret



leerNumero:                   ; RUTINA PARA LEER UN NUMERO ENTERO USANDO SCANF

        push numero

        push fmtInt

        call scanf ; scanf ("%d", &numero)

        add esp, 8

        ret
    


mostrarCadena:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF

        push cadenaStr
        call printf ; printf ("Ingrese un numero: ");

        add esp, 4

	ret

mostrarNumero:                ; RUTINA PARA MOSTRAR UN NUMERO ENTERO USANDO PRINTF

        push dword [numero]

        push fmtInt

        call printf ; printf ("%d", numero)

        add esp, 8
        
	ret



mostrarCaracter:              ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF

        push dword [caracter]

        push fmtChar

        call printf

        add esp, 8

	ret



mostrarSaltoDeLinea:          ; RUTINA PARA MOSTRAR UN SALTO DE LINEA USANDO PRINTF

        push fmtLF

        call printf

        add esp, 4
	ret



salirDelPrograma:             ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT

        push 0

        call exit




_start:
main:		                  ; PUNTO DE INICIO DEL PROGRAMA

	call mostrarCadena ; printf("ingrese numero")
	call leerNumero ; scanf("%d", &numero)
	call mostrarNumero ; printf ("%d", numero)
	mov ebx, [numero] ; ebx = numero
	mov ecx, 10 ; ecx = 10

tabla:
	mov ecx, 10 ; var1 = 10
	add ebx,ebx ; ebx = numero + numero
        mov [numero], ebx ; numero = numero + numero

	call mostrarNumero ; printf ("%d", numero)

	loop tabla

        JMP salirDelPrograma




