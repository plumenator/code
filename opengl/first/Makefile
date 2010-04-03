COMPILERFLAGS = -Wall

CC = gcc
CFLAGS = $(COMPILERFLAGS) -g $(INCDIRS)
LIBS = -lX11 -lXi -lXmu -lglut -lGL -lGLU -lm

GLXFirst : first.o
	$(CC) $(CFLAGS) -o GLXFirst $(LIBDIRS) first.c $(LIBS)
clean:
	rm -f *.o GLXfirst
