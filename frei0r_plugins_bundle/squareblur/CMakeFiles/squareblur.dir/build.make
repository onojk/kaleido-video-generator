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
CMAKE_BINARY_DIR = /home/ubuntu/kaleido-video-generator/frei0r/build

# Include any dependencies generated for this target.
include src/filter/squareblur/CMakeFiles/squareblur.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/filter/squareblur/CMakeFiles/squareblur.dir/compiler_depend.make

# Include the progress variables for this target.
include src/filter/squareblur/CMakeFiles/squareblur.dir/progress.make

# Include the compile flags for this target's objects.
include src/filter/squareblur/CMakeFiles/squareblur.dir/flags.make

src/filter/squareblur/CMakeFiles/squareblur.dir/squareblur.c.o: src/filter/squareblur/CMakeFiles/squareblur.dir/flags.make
src/filter/squareblur/CMakeFiles/squareblur.dir/squareblur.c.o: ../src/filter/squareblur/squareblur.c
src/filter/squareblur/CMakeFiles/squareblur.dir/squareblur.c.o: src/filter/squareblur/CMakeFiles/squareblur.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ubuntu/kaleido-video-generator/frei0r/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/filter/squareblur/CMakeFiles/squareblur.dir/squareblur.c.o"
	cd /home/ubuntu/kaleido-video-generator/frei0r/build/src/filter/squareblur && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT src/filter/squareblur/CMakeFiles/squareblur.dir/squareblur.c.o -MF CMakeFiles/squareblur.dir/squareblur.c.o.d -o CMakeFiles/squareblur.dir/squareblur.c.o -c /home/ubuntu/kaleido-video-generator/frei0r/src/filter/squareblur/squareblur.c

src/filter/squareblur/CMakeFiles/squareblur.dir/squareblur.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/squareblur.dir/squareblur.c.i"
	cd /home/ubuntu/kaleido-video-generator/frei0r/build/src/filter/squareblur && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/ubuntu/kaleido-video-generator/frei0r/src/filter/squareblur/squareblur.c > CMakeFiles/squareblur.dir/squareblur.c.i

src/filter/squareblur/CMakeFiles/squareblur.dir/squareblur.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/squareblur.dir/squareblur.c.s"
	cd /home/ubuntu/kaleido-video-generator/frei0r/build/src/filter/squareblur && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/ubuntu/kaleido-video-generator/frei0r/src/filter/squareblur/squareblur.c -o CMakeFiles/squareblur.dir/squareblur.c.s

# Object files for target squareblur
squareblur_OBJECTS = \
"CMakeFiles/squareblur.dir/squareblur.c.o"

# External object files for target squareblur
squareblur_EXTERNAL_OBJECTS =

src/filter/squareblur/squareblur.so: src/filter/squareblur/CMakeFiles/squareblur.dir/squareblur.c.o
src/filter/squareblur/squareblur.so: src/filter/squareblur/CMakeFiles/squareblur.dir/build.make
src/filter/squareblur/squareblur.so: src/filter/squareblur/CMakeFiles/squareblur.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ubuntu/kaleido-video-generator/frei0r/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C shared module squareblur.so"
	cd /home/ubuntu/kaleido-video-generator/frei0r/build/src/filter/squareblur && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/squareblur.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/filter/squareblur/CMakeFiles/squareblur.dir/build: src/filter/squareblur/squareblur.so
.PHONY : src/filter/squareblur/CMakeFiles/squareblur.dir/build

src/filter/squareblur/CMakeFiles/squareblur.dir/clean:
	cd /home/ubuntu/kaleido-video-generator/frei0r/build/src/filter/squareblur && $(CMAKE_COMMAND) -P CMakeFiles/squareblur.dir/cmake_clean.cmake
.PHONY : src/filter/squareblur/CMakeFiles/squareblur.dir/clean

src/filter/squareblur/CMakeFiles/squareblur.dir/depend:
	cd /home/ubuntu/kaleido-video-generator/frei0r/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ubuntu/kaleido-video-generator/frei0r /home/ubuntu/kaleido-video-generator/frei0r/src/filter/squareblur /home/ubuntu/kaleido-video-generator/frei0r/build /home/ubuntu/kaleido-video-generator/frei0r/build/src/filter/squareblur /home/ubuntu/kaleido-video-generator/frei0r/build/src/filter/squareblur/CMakeFiles/squareblur.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/filter/squareblur/CMakeFiles/squareblur.dir/depend

