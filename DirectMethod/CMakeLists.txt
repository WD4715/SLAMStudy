cmake_minimum_required(VERSION 3.1)

project(DirectMethod)

set(CMAKE_BUILD_TYPE "Release")

set(CMAKE_CXX_FLAGS "-std=c++17 -O3")

find_package(OpenCV 4 REQUIRED)
find_package(Sophus REQUIRED)
find_package(Pangolin REQUIRED)
find_package(FMT REQUIRED)
include_directories(
        ${OpenCV_INCLUDE_DIRS}
        ${Sophus_INCLUDE_DIRS}
        "/usr/include/eigen3/"
        ${Pangolin_INCLUDE_DIRS}
        ${FMT_INCLUDE_DIRS}
)
add_executable(DirectMethod DirectMethod.cpp)
target_link_libraries(DirectMethod ${OpenCV_LIBS} ${Pangolin_LIBRARIES} fmt::fmt)