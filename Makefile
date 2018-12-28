# critical variables
PROJ_NAME = main
TARGET = dist/$(PROJ_NAME)

# compiler options
CC = gcc
LCC = clang
CFLAGS = -Og -g -Wall # debug flags
LFLAGS = -target i686-w64-windows-gnu $(CFLAGS) # clang flags
RFLAGS = -O3 -Wall # release flags

# folder/file options
SRC = src
OBJ = obj
SOURCES := $(wildcard $(SRC)/*.c)
OBJECTS := $(patsubst $(SRC)/%.c, $(OBJ)/%.o, $(SOURCES))
DOBJECTS := $(patsubst $(SRC)/%.c, $(OBJ)/%-debug.o, $(SOURCES))
LOBJECTS := $(patsubst $(SRC)/%.c, $(OBJ)/%-clang.o, $(SOURCES))

# recipes
all: $(TARGET)-debug # default
release: $(TARGET) # release
clang: $(TARGET)-clang # clang

$(TARGET): $(OBJECTS)
	$(CC) $(RFLAGS) $^ -o $@.exe

$(OBJ)/%.o: $(SRC)/%.c 
	$(CC) $(RFLAGS) -MMD -c $^ -o $@

$(TARGET)-debug: $(DOBJECTS)
	$(CC) $(CFLAGS) $^ -o $@.exe

$(OBJ)/%-debug.o: $(SRC)/%.c
	$(CC) $(CFLAGS) -MMD -c $^ -o $@

$(TARGET)-clang: $(LOBJECTS)
	$(LCC) $(LFLAGS) $^ -o $@.exe

$(OBJ)/%-clang.o: $(SRC)/%.c
	$(LCC) $(LFLAGS) -MMD -c $^ -o $@