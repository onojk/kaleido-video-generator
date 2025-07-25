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
include src/filter/contrast0r/CMakeFiles/contrast0r.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/filter/contrast0r/CMakeFiles/contrast0r.dir/compiler_depend.make

# Include the progress variables for this target.
include src/filter/contrast0r/CMakeFiles/contrast0r.dir/progress.make

# Include the compile flags for this target's objects.
include src/filter/contrast0r/CMakeFiles/contrast0r.dir/flags.make

src/filter/contrast0r/CMakeFiles/contrast0r.dir/contrast0r.c.o: src/filter/contrast0r/CMakeFiles/contrast0r.dir/flags.make
src/filter/contrast0r/CMakeFiles/contrast0r.dir/contrast0r.c.o: /home/ubuntu/kaleido-video-generator/frei0r/src/filter/contrast0r/contrast0r.c
src/filter/contrast0r/CMakeFiles/contrast0r.dir/contrast0r.c.o: src/filter/contrast0r/CMakeFiles/contrast0r.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ubuntu/kaleido-video-generator/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/filter/contrast0r/CMakeFiles/contrast0r.dir/contrast0r.c.o"
	cd /home/ubuntu/kaleido-video-generator/build/src/filter/contrast0r && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT src/filter/contrast0r/CMakeFiles/contrast0r.dir/contrast0r.c.o -MF CMakeFiles/contrast0r.dir/contrast0r.c.o.d -o CMakeFiles/contrast0r.dir/contrast0r.c.o -c /home/ubuntu/kaleido-video-generator/frei0r/src/filter/contrast0r/contrast0r.c

src/filter/contrast0r/CMakeFiles/contrast0r.dir/contrast0r.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/contrast0r.dir/contrast0r.c.i"
	cd /home/ubuntu/kaleido-video-generator/build/src/filter/contrast0r && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/ubuntu/kaleido-video-generator/frei0r/src/filter/contrast0r/contrast0r.c > CMakeFiles/contrast0r.dir/contrast0r.c.i

src/filter/contrast0r/CMakeFiles/contrast0r.dir/contrast0r.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/contrast0r.dir/contrast0r.c.s"
	cd /home/ubuntu/kaleido-video-generator/build/src/filter/contrast0r && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/ubuntu/kaleido-video-generator/frei0r/src/filter/contrast0r/contrast0r.c -o CMakeFiles/contrast0r.dir/contrast0r.c.s

# Object files for target contrast0r
contrast0r_OBJECTS = \
"CMakeFiles/contrast0r.dir/contrast0r.c.o"

# External object files for target contrast0r
contrast0r_EXTERNAL_OBJECTS =

src/filter/contrast0r/contrast0r.so: src/filter/contrast0r/CMakeFiles/contrast0r.dir/contrast0r.c.o
src/filter/contrast0r/contrast0r.so: src/filter/contrast0r/CMakeFiles/contrast0r.dir/build.make
src/filter/contrast0r/contrast0r.so: src/filter/contrast0r/CMakeFiles/contrast0r.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ubuntu/kaleido-video-generator/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C shared module contrast0r.so"
	cd /home/ubuntu/kaleido-video-generator/build/src/filter/contrast0r && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/contrast0r.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/filter/contrast0r/CMakeFiles/contrast0r.dir/build: src/filter/contrast0r/contrast0r.so
.PHONY : src/filter/contrast0r/CMakeFiles/contrast0r.dir/build

src/filter/contrast0r/CMakeFiles/contrast0r.dir/clean:
	cd /home/ubuntu/kaleido-video-generator/build/src/filter/contrast0r && $(CMAKE_COMMAND) -P CMakeFiles/contrast0r.dir/cmake_clean.cmake
.PHONY : src/filter/contrast0r/CMakeFiles/contrast0r.dir/clean

src/filter/contrast0r/CMakeFiles/contrast0r.dir/depend:
	cd /home/ubuntu/kaleido-video-generator/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ubuntu/kaleido-video-generator/frei0r /home/ubuntu/kaleido-video-generator/frei0r/src/filter/contrast0r /home/ubuntu/kaleido-video-generator/build /home/ubuntu/kaleido-video-generator/build/src/filter/contrast0r /home/ubuntu/kaleido-video-generator/build/src/filter/contrast0r/CMakeFiles/contrast0r.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/filter/contrast0r/CMakeFiles/contrast0r.dir/depend

