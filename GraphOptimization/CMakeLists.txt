cmake_minimum_required(VERSION 2.8)
project("PoseGraph")

set(CMAKE_BUILD_TYPE "Release")
set(CMAKE_CXX_FLAGS "-std=c++17 -O3")


#Sophus
find_package(Sophus REQUIRED)
find_package(FMT REQUIRED)
LIST(APPEND CMAKE_MODULE_PATH /mnt/c/Users/JLK/Desktop/Robo/thridpart/g2o/cmake_modules)
SET(g2o_ROOT /usr/local/include/g2o)
find_package(g2o REQUIRED)

include_directories(
                    ${Sophus_INCLUDE_DIRS}
                    "/usr/include/eigen3/"
                    ${G2O_INCLUDE_DIRS}
                    ${FMT_INCLUDE_DIRS}
                    )

add_executable(PoseGraph pose_graph_g2o_SE3.cpp)
target_link_libraries(PoseGraph
        ${Sophus_LIBRARIES}
        fmt::fmt
        g2o_core
        g2o_stuff
        g2o_types_slam3d
        )
