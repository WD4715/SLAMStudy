cmake_minimum_required(VERSION 2.8)

project(PoseEstimation2d)

set(CMAKE_BUILD_TYPE "Release")
set(CMAKE_CXX_FLAGS "-std=c++17 -O3")

find_package(OpenCV 4 REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})

add_executable(PoseEstimation2d PoseEstimation2d.cpp)
target_link_libraries(PoseEstimation2d ${OpenCV_LIBS})
