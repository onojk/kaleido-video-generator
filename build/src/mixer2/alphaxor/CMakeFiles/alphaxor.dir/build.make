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
include src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/compiler_depend.make

# Include the progress variables for this target.
include src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/progress.make

# Include the compile flags for this target's objects.
include src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/flags.make

src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/alphaxor.cpp.o: src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/flags.make
src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/alphaxor.cpp.o: /home/ubuntu/kaleido-video-generator/frei0r/src/mixer2/alphaxor/alphaxor.cpp
src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/alphaxor.cpp.o: src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ubuntu/kaleido-video-generator/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/alphaxor.cpp.o"
	cd /home/ubuntu/kaleido-video-generator/build/src/mixer2/alphaxor && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/alphaxor.cpp.o -MF CMakeFiles/alphaxor.dir/alphaxor.cpp.o.d -o CMakeFiles/alphaxor.dir/alphaxor.cpp.o -c /home/ubuntu/kaleido-video-generator/frei0r/src/mixer2/alphaxor/alphaxor.cpp

src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/alphaxor.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/alphaxor.dir/alphaxor.cpp.i"
	cd /home/ubuntu/kaleido-video-generator/build/src/mixer2/alphaxor && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ubuntu/kaleido-video-generator/frei0r/src/mixer2/alphaxor/alphaxor.cpp > CMakeFiles/alphaxor.dir/alphaxor.cpp.i

src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/alphaxor.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/alphaxor.dir/alphaxor.cpp.s"
	cd /home/ubuntu/kaleido-video-generator/build/src/mixer2/alphaxor && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ubuntu/kaleido-video-generator/frei0r/src/mixer2/alphaxor/alphaxor.cpp -o CMakeFiles/alphaxor.dir/alphaxor.cpp.s

# Object files for target alphaxor
alphaxor_OBJECTS = \
"CMakeFiles/alphaxor.dir/alphaxor.cpp.o"

# External object files for target alphaxor
alphaxor_EXTERNAL_OBJECTS =

src/mixer2/alphaxor/alphaxor.so: src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/alphaxor.cpp.o
src/mixer2/alphaxor/alphaxor.so: src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/build.make
src/mixer2/alphaxor/alphaxor.so: src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ubuntu/kaleido-video-generator/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared module alphaxor.so"
	cd /home/ubuntu/kaleido-video-generator/build/src/mixer2/alphaxor && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/alphaxor.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/build: src/mixer2/alphaxor/alphaxor.so
.PHONY : src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/build

src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/clean:
	cd /home/ubuntu/kaleido-video-generator/build/src/mixer2/alphaxor && $(CMAKE_COMMAND) -P CMakeFiles/alphaxor.dir/cmake_clean.cmake
.PHONY : src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/clean

src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/depend:
	cd /home/ubuntu/kaleido-video-generator/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ubuntu/kaleido-video-generator/frei0r /home/ubuntu/kaleido-video-generator/frei0r/src/mixer2/alphaxor /home/ubuntu/kaleido-video-generator/build /home/ubuntu/kaleido-video-generator/build/src/mixer2/alphaxor /home/ubuntu/kaleido-video-generator/build/src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/mixer2/alphaxor/CMakeFiles/alphaxor.dir/depend

