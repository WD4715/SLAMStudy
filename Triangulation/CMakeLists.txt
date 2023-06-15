cmake_minimum_required(VERSION 2.8)

project(Triangulartion)

set(CMAKE_BUILD_TYPE "Released")
set(CMAKE_CXX_FLAGS "-std=c++17 -O3")

find_package(OpenCV 4 REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})

add_executable(Triangulartion trianglation.cpp)
target_link_libraries(Triangulartion ${OpenCV_LIBS})