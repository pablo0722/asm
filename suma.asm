; Se ingresa una matriz. La computadora muestra los valores en su diagonal principal.

;
;

; En Windows (1 en la consola de NASM; 2 y 3 en la consola de Visual Studio):

; 1) nasm -f win32 ej3.asm --PREFIX _

; 2) link /out:suma.exe suma.obj libcmt.lib

; 3) suma
;

; En Windows (1 en la consola de NASM; 2 y 3 en la consola de Windows, dentro de la carpeta [ajustando los nros. de version]: C:\Qt\Qt5.3.1\Tools\mingw482_32\bin ):

; 1) nasm -f win32 suma.asm --PREFIX _

; 2) gcc suma.obj -o suma.exe

; 3) suma

        global main              ; ETIQUETAS QUE MARCAN EL PUNTO DE INICIO DE LA EJECUCION
        
	global _start

        

	extern printf            ;
        
	extern scanf             ; FUNCIONES DE C (IMPORTADAS)

        extern exit              ;

        extern gets              ; GETS ES MUY PELIGROSA. SOLO USARLA EN EJERCICIOS BASICOS, JAMAS EN EL TRABAJO!!!






section .bss                     ; SECCION DE LAS VARIABLES



n:

	resd 1

numero:

	resd 1

numero1:

	resd 1 ; res d = reserve double word = 32 bits

numero2:

	resd 1


	
section .data            ; SECCION DE LAS CONSTANTES



fmtInt:
		; fmtInt = {'%', 'd', '\0'}
        db    "%d", 0 ; db = define byte
		;dw = define word
		;dd = define double word


fmtString:

        db    "%s", 0  		; FORMATO PARA CADENAS



fmtLF:
		; fmtLF = {'\n', '0'}
        db    0xA, 0       	; SALTO DE LINEA (LF)
		; no se puede poner "\n". Hay q poner el codigo ASCII
		


cadena:

	db	"n1: ",0
		


cadena2:

	db	"*",0

		



section .text            ; SECCION DE LAS INSTRUCCIONES


mostrarNumero:
		
	push dword [numero] ; var1 = 8
        
	push fmtInt ; var2 = "%d"
        
	call printf ; printf ("%d", var1);
        
	add esp, 8
        

ret

mostrarSaltoDeLinea:  ; RUTINA PARA MOSTRAR UN SALTO DE LINEA USANDO PRINTF
        
	push fmtLF
        
	call printf
        
	add esp, 4
        

ret

salirDelPrograma:     ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
        
	push 0 ; var1 = 0
        
	call exit ; exit(var1);

_start:

main:                    ; PUNTO DE INICIO DEL PROGRAMA
		
		
	MOV ECX, 0x18 ; ECX = 0x18
		
	MOV [numero1], ECX ; numero1 = 0x18
		
	MOV ECX, 3 ; ECX = 3
		
	MOV [numero2], ECX ; numero = 3

		
	MOV ESI, numero2 ; fuente = &numero2
		
	XOR EDX, EDX ; EDX = 0
		
	MOV EAX, [numero1] ; EAX = 0x18
		
	MOV EBX, [ESI] ; EBX = 3
		
	IDIV EBX ; EAX = 0x18 / 3 = 8
		
	MOV [numero], EAX ; numero = 8

		
	CALL mostrarNumero  ; mostrarNumero ();
		
	JMP salirDelPrograma

;
;	XOR
;	0 0 - 0
;	1 0 - 1
;	0 1 - 1
;	1 1 - 0

		
;EAX
;EBX
;ECX
;EDX

;ESI: source
;EDI: destino