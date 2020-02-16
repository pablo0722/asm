nasm -f win32 ej8.asm --PREFIX _ -I..
gcc ej8.obj -o ej8.exe -m32 -I..
ej8.exe