nasm -f win32 ej1.asm --PREFIX _ -I..
gcc ej1.obj -o ej1.exe -m32 -I..
ej1.exe