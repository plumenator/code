#
# An example GNUmakefile
#

# Include the common variables defined by the Makefile Package
include $(GNUSTEP_MAKEFILES)/common.make

# Build a simple Objective-C program
TOOL_NAME = hello

# The Objective-C files to compile
hello_OBJC_FILES = hello.m

-include GNUmakefile.preamble

# Include in the rules for making GNUstep command-line programs
include $(GNUSTEP_MAKEFILES)/tool.make

-include GNUmakefile.postamble
