# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
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
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ubuntu/kaleido-video-generator/frei0r

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ubuntu/kaleido-video-generator/build

# Include any dependencies generated for this target.
include src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/compiler_depend.make

# Include the progress variables for this target.
include src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/progress.make

# Include the compile flags for this target's objects.
include src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/flags.make

src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/elastic_scale.cpp.o: src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/flags.make
src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/elastic_scale.cpp.o: /home/ubuntu/kaleido-video-generator/frei0r/src/filter/elastic_scale/elastic_scale.cpp
src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/elastic_scale.cpp.o: src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ubuntu/kaleido-video-generator/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/elastic_scale.cpp.o"
	cd /home/ubuntu/kaleido-video-generator/build/src/filter/elastic_scale && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/elastic_scale.cpp.o -MF CMakeFiles/elastic_scale.dir/elastic_scale.cpp.o.d -o CMakeFiles/elastic_scale.dir/elastic_scale.cpp.o -c /home/ubuntu/kaleido-video-generator/frei0r/src/filter/elastic_scale/elastic_scale.cpp

src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/elastic_scale.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/elastic_scale.dir/elastic_scale.cpp.i"
	cd /home/ubuntu/kaleido-video-generator/build/src/filter/elastic_scale && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ubuntu/kaleido-video-generator/frei0r/src/filter/elastic_scale/elastic_scale.cpp > CMakeFiles/elastic_scale.dir/elastic_scale.cpp.i

src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/elastic_scale.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/elastic_scale.dir/elastic_scale.cpp.s"
	cd /home/ubuntu/kaleido-video-generator/build/src/filter/elastic_scale && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ubuntu/kaleido-video-generator/frei0r/src/filter/elastic_scale/elastic_scale.cpp -o CMakeFiles/elastic_scale.dir/elastic_scale.cpp.s

# Object files for target elastic_scale
elastic_scale_OBJECTS = \
"CMakeFiles/elastic_scale.dir/elastic_scale.cpp.o"

# External object files for target elastic_scale
elastic_scale_EXTERNAL_OBJECTS =

src/filter/elastic_scale/elastic_scale.so: src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/elastic_scale.cpp.o
src/filter/elastic_scale/elastic_scale.so: src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/build.make
src/filter/elastic_scale/elastic_scale.so: src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ubuntu/kaleido-video-generator/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared module elastic_scale.so"
	cd /home/ubuntu/kaleido-video-generator/build/src/filter/elastic_scale && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/elastic_scale.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/build: src/filter/elastic_scale/elastic_scale.so
.PHONY : src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/build

src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/clean:
	cd /home/ubuntu/kaleido-video-generator/build/src/filter/elastic_scale && $(CMAKE_COMMAND) -P CMakeFiles/elastic_scale.dir/cmake_clean.cmake
.PHONY : src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/clean

src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/depend:
	cd /home/ubuntu/kaleido-video-generator/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ubuntu/kaleido-video-generator/frei0r /home/ubuntu/kaleido-video-generator/frei0r/src/filter/elastic_scale /home/ubuntu/kaleido-video-generator/build /home/ubuntu/kaleido-video-generator/build/src/filter/elastic_scale /home/ubuntu/kaleido-video-generator/build/src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/filter/elastic_scale/CMakeFiles/elastic_scale.dir/depend

