PROJ_NAME = "main"
CC = gcc
CFlags = -g -Wall

default: $(PROJ_NAME)



$(PROJ_NAME): obj/main.o
	$(CC) $(CFlags) obj/main.o -o dist/${PROJ_NAME}.exe

obj/main.o: src/main.c
	$(CC) $(CFlags) -c src/main.c -o obj/main.o
