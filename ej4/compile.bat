nasm -f win32 ej4.asm --PREFIX _ -I..
gcc ej4.obj -o ej4.exe -m32 -I..
ej4.exe