nasm -f win32 ej2.asm --PREFIX _ -I..
gcc ej2.obj -o ej2.exe -m32 -I..
ej2.exe