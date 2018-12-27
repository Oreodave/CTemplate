# critical variables
PROJ_NAME = main
TARGET = dist/$(PROJ_NAME)

# compiler options
CC = gcc
LCC = clang
CFLAGS = -g -Wall
LFLAGS = -target x86_64 $(CFLAGS) -IC:\MinGW\include

# folder/file options
SRC = src
OBJ = obj
SOURCES := $(wildcard $(SRC)/*.c)
OBJECTS := $(patsubst $(SRC)/%.c, $(OBJ)/%.o, $(SOURCES))
LOBJECTS := $(patsubst $(SRC)/%.c, $(OBJ)/%-clang.o, $(SOURCES))

# recipes
all: $(TARGET)
clang: $(TARGET)-clang

$(TARGET)-clang: $(LOBJECTS)
	$(LCC) $(LFLAGS) $^ -o $@.exe

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) $^ -o $@.exe

$(OBJ)/%-clang.o: $(SRC)/%.c
	$(LCC) $(LFLAGS) -MMD -c $^ -o $@

$(OBJ)/%.o: $(SRC)/%.c
	$(CC) $(CFLAGS) -MMD -c $^ -o $@
