PROJ_NAME = main
TARGET = dist/$(PROJ_NAME).exe
CC = gcc
CFLAGS = -g -Wall 
SRC = src
OBJ = obj

SOURCES := $(wildcard $(SRC)/*.c)
OBJECTS := $(patsubst $(SRC)/%.c, $(OBJ)/%.o, $(SOURCES))

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) $^ -o $@

$(OBJ)/%.o: $(SRC)/%.c
	$(CC) $(CFLAGS) -MMD -c $^ -o $@
