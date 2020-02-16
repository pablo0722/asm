nasm -f win32 ej7.asm --PREFIX _ -I..
gcc ej7.obj -o ej7.exe -m32 -I..
ej7.exe