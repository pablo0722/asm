nasm -f win32 ej3.asm --PREFIX _ -I..
gcc ej3.obj -o ej3.exe -m32 -I..
ej3.exe