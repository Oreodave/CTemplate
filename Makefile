# critical variables
PROJ_NAME = main
TARGET = dist/$(PROJ_NAME)

# compiler options
CC = gcc
LCC = clang
CFLAGS = -Og -g -Wall # debug flags
RFLAGS = -O3 -Wall # release flags

# folder/file options
SRC = src
OBJ = obj
SOURCES := $(wildcard $(SRC)/*.c)
OBJECTS := $(patsubst $(SRC)/%.c, $(OBJ)/%.o, $(SOURCES))
DOBJECTS := $(patsubst $(SRC)/%.c, $(OBJ)/%-gcc.o, $(SOURCES))
LOBJECTS := $(patsubst $(SRC)/%.c, $(OBJ)/%-clang.o, $(SOURCES))

# recipes
default: $(TARGET)-clang # default
release: $(TARGET) # release
gcc: $(TARGET)-gcc
all: $(TARGET)-gcc $(TARGET)-clang $(TARGET)


clean: 
	find . -maxdepth 2 -type f -name *.o -delete -or \
		-name *.d -delete -or \
		-name *.exe -delete

$(TARGET): $(OBJECTS)
	$(CC) $(RFLAGS) $^ -o $@.exe

$(OBJ)/%.o: $(SRC)/%.c
	$(CC) $(RFLAGS) -MMD -c $^ -o $@

$(TARGET)-gcc: $(DOBJECTS)
	$(CC) $(CFLAGS) $^ -o $@.exe

$(OBJ)/%-gcc.o: $(SRC)/%.c
	$(CC) $(CFLAGS) -MMD -c $^ -o $@

$(TARGET)-clang: $(LOBJECTS)
	$(LCC) $(CFLAGS) $^ -o $@.exe

$(OBJ)/%-clang.o: $(SRC)/%.c
	$(LCC) $(CFLAGS) -MMD -c $^ -o $@