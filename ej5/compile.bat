nasm -f win32 ej5.asm --PREFIX _ -I..
gcc ej5.obj -o ej5.exe -m32 -I..
ej5.exe