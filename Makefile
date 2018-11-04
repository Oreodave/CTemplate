PROJ_NAME = "main"
CC = gcc
CFlags = -g -Wall
default: main

main: src/main.o
	$(CC) $(CFlags) src/main.o -o dist/${PROJ_NAME}.exe

main.o: src/main.c
	$(CC) $(CFlags) -c src/main.c -o src/main.o
