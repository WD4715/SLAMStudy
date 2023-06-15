cmake_minimum_required(VERSION 2.8)

project(StereoVision)

set(CMAKE_BUILD_TYPE "Release")
set(CMAKE_CXX_FLAGS "-std=c++17 -O3")

# 1. OpenCV
find_package(OpenCV 4 REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})

#2. Pangolin
find_package(Pangolin REQUIRED)
include_directories(${Pangolin_INCLUDE_DIRS})

#3. Eigen
include_directories("/usr/local/include/eigen3")

add_executable(StereoVision stereovision.cpp)
target_link_libraries(StereoVision ${OpenCV_LIBS} ${Pangolin_LIBRARIES})