# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /mnt/c/Users/JLK/Desktop/Robo/triangulation

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /mnt/c/Users/JLK/Desktop/Robo/triangulation/build

# Include any dependencies generated for this target.
include CMakeFiles/Triangulartion.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/Triangulartion.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/Triangulartion.dir/flags.make

CMakeFiles/Triangulartion.dir/trianglation.cpp.o: CMakeFiles/Triangulartion.dir/flags.make
CMakeFiles/Triangulartion.dir/trianglation.cpp.o: ../trianglation.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/c/Users/JLK/Desktop/Robo/triangulation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/Triangulartion.dir/trianglation.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/Triangulartion.dir/trianglation.cpp.o -c /mnt/c/Users/JLK/Desktop/Robo/triangulation/trianglation.cpp

CMakeFiles/Triangulartion.dir/trianglation.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/Triangulartion.dir/trianglation.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /mnt/c/Users/JLK/Desktop/Robo/triangulation/trianglation.cpp > CMakeFiles/Triangulartion.dir/trianglation.cpp.i

CMakeFiles/Triangulartion.dir/trianglation.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/Triangulartion.dir/trianglation.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /mnt/c/Users/JLK/Desktop/Robo/triangulation/trianglation.cpp -o CMakeFiles/Triangulartion.dir/trianglation.cpp.s

# Object files for target Triangulartion
Triangulartion_OBJECTS = \
"CMakeFiles/Triangulartion.dir/trianglation.cpp.o"

# External object files for target Triangulartion
Triangulartion_EXTERNAL_OBJECTS =

Triangulartion: CMakeFiles/Triangulartion.dir/trianglation.cpp.o
Triangulartion: CMakeFiles/Triangulartion.dir/build.make
Triangulartion: /usr/local/lib/libopencv_dnn.so.4.5.0
Triangulartion: /usr/local/lib/libopencv_gapi.so.4.5.0
Triangulartion: /usr/local/lib/libopencv_highgui.so.4.5.0
Triangulartion: /usr/local/lib/libopencv_ml.so.4.5.0
Triangulartion: /usr/local/lib/libopencv_objdetect.so.4.5.0
Triangulartion: /usr/local/lib/libopencv_photo.so.4.5.0
Triangulartion: /usr/local/lib/libopencv_stitching.so.4.5.0
Triangulartion: /usr/local/lib/libopencv_video.so.4.5.0
Triangulartion: /usr/local/lib/libopencv_videoio.so.4.5.0
Triangulartion: /usr/local/lib/libopencv_imgcodecs.so.4.5.0
Triangulartion: /usr/local/lib/libopencv_calib3d.so.4.5.0
Triangulartion: /usr/local/lib/libopencv_features2d.so.4.5.0
Triangulartion: /usr/local/lib/libopencv_flann.so.4.5.0
Triangulartion: /usr/local/lib/libopencv_imgproc.so.4.5.0
Triangulartion: /usr/local/lib/libopencv_core.so.4.5.0
Triangulartion: CMakeFiles/Triangulartion.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/mnt/c/Users/JLK/Desktop/Robo/triangulation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable Triangulartion"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/Triangulartion.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/Triangulartion.dir/build: Triangulartion

.PHONY : CMakeFiles/Triangulartion.dir/build

CMakeFiles/Triangulartion.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/Triangulartion.dir/cmake_clean.cmake
.PHONY : CMakeFiles/Triangulartion.dir/clean

CMakeFiles/Triangulartion.dir/depend:
	cd /mnt/c/Users/JLK/Desktop/Robo/triangulation/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/c/Users/JLK/Desktop/Robo/triangulation /mnt/c/Users/JLK/Desktop/Robo/triangulation /mnt/c/Users/JLK/Desktop/Robo/triangulation/build /mnt/c/Users/JLK/Desktop/Robo/triangulation/build /mnt/c/Users/JLK/Desktop/Robo/triangulation/build/CMakeFiles/Triangulartion.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/Triangulartion.dir/depend

