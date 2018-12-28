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
default: $(TARGET)-debug # default
all: $(TARGET)-debug $(TARGET)-clang $(TARGET)
release: $(TARGET) # release
clang: $(TARGET)-clang # clang

$(TARGET): $(OBJECTS)
	echo Linking release objects;
	$(CC) $(RFLAGS) $^ -o $@.exe

$(OBJ)/%.o: $(SRC)/%.c 
	echo Compiling release objects;
	$(CC) $(RFLAGS) -MMD -c $^ -o $@

$(TARGET)-debug: $(DOBJECTS)
	echo Linking debug objects;
	$(CC) $(CFLAGS) $^ -o $@.exe

$(OBJ)/%-debug.o: $(SRC)/%.c
	echo Compiling debug objects;
	$(CC) $(CFLAGS) -MMD -c $^ -o $@

$(TARGET)-clang: $(LOBJECTS)
	echo Linking clang objects;
	$(LCC) $(LFLAGS) $^ -o $@.exe

$(OBJ)/%-clang.o: $(SRC)/%.c
	echo Compiling clang objects
	$(LCC) $(LFLAGS) -MMD -c $^ -o $@