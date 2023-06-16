cmake_minimum_required(VERSION 2.8)

project(OpticalFlow)

set(CMAKE_BUILD_TYPE "Release")
set(CMAKE_CXX_FLAGS "-std=c++17 -O3")

#1. OpenCV
find_package(OpenCV 4 REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})

#2. Eigen
include_directories("/usr/include/eigen3")

add_executable(OpticalFlow OpticalFlow.cpp)
target_link_libraries(OpticalFlow ${OpenCV_LIBS})