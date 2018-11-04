CC = gcc
default: main


main: src/main.o
	$(CC) src/main.o -o dist/main.exe

main.o: src/main.c
	$(CC) -c src/main.c -o src/main.o
