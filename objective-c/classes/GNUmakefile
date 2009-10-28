#
# An example GNUmakefile
#

# Include the common variables defined by the Makefile Package
include $(GNUSTEP_MAKEFILES)/common.make

# Build a sample Objective-C program
TOOL_NAME = classes

# The Objective-C files to compile
classes_OBJC_FILES = Point.m classes.m

-include GNUmakefile.preamble

# Include in the rules for making GNUstep command-line programs
include $(GNUSTEP_MAKEFILES)/tool.make

-include GNUmakefile.postamble
