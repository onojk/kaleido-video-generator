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
include src/filter/c0rners/CMakeFiles/c0rners.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/filter/c0rners/CMakeFiles/c0rners.dir/compiler_depend.make

# Include the progress variables for this target.
include src/filter/c0rners/CMakeFiles/c0rners.dir/progress.make

# Include the compile flags for this target's objects.
include src/filter/c0rners/CMakeFiles/c0rners.dir/flags.make

src/filter/c0rners/CMakeFiles/c0rners.dir/c0rners.c.o: src/filter/c0rners/CMakeFiles/c0rners.dir/flags.make
src/filter/c0rners/CMakeFiles/c0rners.dir/c0rners.c.o: /home/ubuntu/kaleido-video-generator/frei0r/src/filter/c0rners/c0rners.c
src/filter/c0rners/CMakeFiles/c0rners.dir/c0rners.c.o: src/filter/c0rners/CMakeFiles/c0rners.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ubuntu/kaleido-video-generator/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/filter/c0rners/CMakeFiles/c0rners.dir/c0rners.c.o"
	cd /home/ubuntu/kaleido-video-generator/build/src/filter/c0rners && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT src/filter/c0rners/CMakeFiles/c0rners.dir/c0rners.c.o -MF CMakeFiles/c0rners.dir/c0rners.c.o.d -o CMakeFiles/c0rners.dir/c0rners.c.o -c /home/ubuntu/kaleido-video-generator/frei0r/src/filter/c0rners/c0rners.c

src/filter/c0rners/CMakeFiles/c0rners.dir/c0rners.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/c0rners.dir/c0rners.c.i"
	cd /home/ubuntu/kaleido-video-generator/build/src/filter/c0rners && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/ubuntu/kaleido-video-generator/frei0r/src/filter/c0rners/c0rners.c > CMakeFiles/c0rners.dir/c0rners.c.i

src/filter/c0rners/CMakeFiles/c0rners.dir/c0rners.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/c0rners.dir/c0rners.c.s"
	cd /home/ubuntu/kaleido-video-generator/build/src/filter/c0rners && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/ubuntu/kaleido-video-generator/frei0r/src/filter/c0rners/c0rners.c -o CMakeFiles/c0rners.dir/c0rners.c.s

# Object files for target c0rners
c0rners_OBJECTS = \
"CMakeFiles/c0rners.dir/c0rners.c.o"

# External object files for target c0rners
c0rners_EXTERNAL_OBJECTS =

src/filter/c0rners/c0rners.so: src/filter/c0rners/CMakeFiles/c0rners.dir/c0rners.c.o
src/filter/c0rners/c0rners.so: src/filter/c0rners/CMakeFiles/c0rners.dir/build.make
src/filter/c0rners/c0rners.so: src/filter/c0rners/CMakeFiles/c0rners.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ubuntu/kaleido-video-generator/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C shared module c0rners.so"
	cd /home/ubuntu/kaleido-video-generator/build/src/filter/c0rners && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/c0rners.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/filter/c0rners/CMakeFiles/c0rners.dir/build: src/filter/c0rners/c0rners.so
.PHONY : src/filter/c0rners/CMakeFiles/c0rners.dir/build

src/filter/c0rners/CMakeFiles/c0rners.dir/clean:
	cd /home/ubuntu/kaleido-video-generator/build/src/filter/c0rners && $(CMAKE_COMMAND) -P CMakeFiles/c0rners.dir/cmake_clean.cmake
.PHONY : src/filter/c0rners/CMakeFiles/c0rners.dir/clean

src/filter/c0rners/CMakeFiles/c0rners.dir/depend:
	cd /home/ubuntu/kaleido-video-generator/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ubuntu/kaleido-video-generator/frei0r /home/ubuntu/kaleido-video-generator/frei0r/src/filter/c0rners /home/ubuntu/kaleido-video-generator/build /home/ubuntu/kaleido-video-generator/build/src/filter/c0rners /home/ubuntu/kaleido-video-generator/build/src/filter/c0rners/CMakeFiles/c0rners.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/filter/c0rners/CMakeFiles/c0rners.dir/depend

