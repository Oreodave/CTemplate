## Metadata
cmake_minimum_required(VERSION 3.10.2)

set(This main) # Name of project
project(${This} C)

set(CMAKE_C_COMPILER clang) # compiler

set(CMAKE_C_STANDARD 11) # code standard
SET(CMAKE_POSITION_INDEPENDENT_CODE ON)

enable_testing()

## Variables for files
file(GLOB_RECURSE HEADERS "includes/*.h")
file(GLOB_RECURSE SRC "src/*.c")

## Executable recipes
add_executable(${This}-debug ${SRC} ${HEADERS})
add_executable(${This}-clean ${SRC} ${HEADERS})

target_compile_options(${This}-debug PUBLIC -O0 -g -Wall)
target_compile_options(${This}-clean PUBLIC -O3 -Wall)

## Tests
add_test(NAME run COMMAND ./${This}-debug WORKING_DIRECTORY ${CMAKE_BINARY_DIR})
