cmake_minimum_required(VERSION 3.3)
project(task2)
project(task3)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(SOURCE_FILES 2variant2task.c)
add_executable(task2 ${SOURCE_FILES})

add_executable(2variant3task 2variant3task.c)