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



        ;extern printf            ;
        
	    ;extern scanf             ; FUNCIONES DE C (IMPORTADAS)

        ;extern exit              ;

        ;extern gets              ; GETS ES MUY PELIGROSA. SOLO USARLA EN EJERCICIOS BASICOS, JAMAS EN EL TRABAJO!!!







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
cadena_len:	equ	$ - cadena			;length of our dear string



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
cadenaStr_len:	equ	$ - cadenaStr			;length of our dear string

piso:
        db    "0", 0           ; Piso



techo:
        db    "0b", 0           ; techo


section .text                    ; SECCION DE LAS INSTRUCCIONES
 


leerCadena:                      ; RUTINA PARA LEER UNA CADENA USANDO GETS

        push cadena

        ;call gets

        add esp, 4

	ret



leerNumero:                   ; RUTINA PARA LEER UN NUMERO ENTERO USANDO SCANF

        push numero

        push fmtInt

        ;call scanf ; scanf ("%d", &numero)
        
	    mov dword [numero], 2

        add esp, 8

        ret
    


mostrarCadena:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF

	mov	edx, cadenaStr_len    ;message length
	mov	ecx, cadenaStr    ;message to write
	mov	ebx, 1	    ;file descriptor (stdout)
	mov	eax, 4	    ;system call number (sys_write)
	int	0x80        ;call kernel
	
        ;push cadenaStr
        ;call printf ; printf ("Ingrese un numero: ");

        ;add esp, 4

	ret
	
	
mostrarEnter:
    sub esp, 4
    sub esp, 4
    
	mov	edx, 1    ;message length
	mov	ecx, ' '   ;message to write
	mov [esp], ecx
	mov	ecx, esp    ;message to write
	mov	ebx, 1	    ;file descriptor (stdout)
	mov	eax, 4	    ;system call number (sys_write)
	int	0x80        ;call kernel

mostrarNumero:                ; RUTINA PARA MOSTRAR UN NUMERO ENTERO USANDO PRINTF

        ;push dword [numero]

        ;push fmtInt

        ;call printf ; printf ("%d", numero)
        
    sub esp, 4
    sub esp, 4
    
	mov	edx, 1    ;message length
	mov	ecx, ' '   ;message to write
	mov [esp], ecx
	mov	ecx, esp    ;message to write
	mov	ebx, 1	    ;file descriptor (stdout)
	mov	eax, 4	    ;system call number (sys_write)
	int	0x80        ;call kernel
	
	
    mov ecx, 0
    mov eax, [numero]
    cmp eax, 10
    jge .resta
    jmp .sigue
.resta:
    add ecx, 1
    mov ebx, 10
    sub eax, ebx ;eax = eax - ebx
    cmp eax, 10
    jge .resta
.sigue:
    mov [esp+4], eax
	mov	edx, 1    ;message length
	add ecx, '0'
	mov [esp], ecx
	mov	ecx, esp    ;message to write
	mov	ebx, 1	    ;file descriptor (stdout)
	mov	eax, 4	    ;system call number (sys_write)
	int	0x80        ;call kernel
        
	mov	edx, 1    ;message length
	mov	ecx, [esp+4]    ;message to write
	add ecx, '0'
	mov [esp], ecx
	mov	ecx, esp    ;message to write
	mov	ebx, 1	    ;file descriptor (stdout)
	mov	eax, 4	    ;system call number (sys_write)
	int	0x80        ;call kernel

    add esp, 8
        
	ret



mostrarCaracter:              ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF

        push dword [caracter]

        push fmtChar

        ;call printf

        add esp, 8

	ret



mostrarSaltoDeLinea:          ; RUTINA PARA MOSTRAR UN SALTO DE LINEA USANDO PRINTF

        push fmtLF

        ;call printf

        add esp, 4
	ret



salirDelPrograma:             ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT

	
	mov	eax, 1	    ;system call number (sys_exit)
	int	0x80        ;call kernel
        ;push 0

        ;call exit




_start:
main:		                  ; PUNTO DE INICIO DEL PROGRAMA

	call mostrarCadena ; printf("ingrese numero")
	call leerNumero ; scanf("%d", &numero)
	call mostrarNumero ; printf ("%d", numero)
	;mov ebx, [numero] ; ebx = numero
	call mostrarEnter ; printf ("%d", numero)

    mov ebx, [numero]
	mov ecx, 9 ; ecx = 9
.tabla:
	push eax
	push ebx
	push ecx
	push edx
	call mostrarNumero ; printf ("%d", numero)
	pop edx
	pop ecx
	pop ebx
	pop eax
	add [numero], ebx ; var1 = var1 + numero
	
    ;sub ecx, 1
	loop .tabla
	
	push eax
	push ebx
	push ecx
	push edx
	call mostrarNumero ; printf ("%d", numero)
	pop edx
	pop ecx
	pop ebx
	pop eax
	

    JMP salirDelPrograma




