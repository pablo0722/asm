nasm -f win32 ej6.asm --PREFIX _ -I..
gcc ej6.obj -o ej6.exe -m32 -I..
ej6.exe