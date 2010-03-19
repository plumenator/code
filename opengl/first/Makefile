COMPILERFLAGS = -Wall

CC = gcc
CFLAGS = $(COMPILERFLAGS) -g $(INCDIRS)
LIBS = -lX11 -lXi -lXmu -lglut -lGL -lGLU -lm

first : first.o
	$(CC) $(CFLAGS) -o first $(LIBDIRS) first.c $(LIBS)
clean:
	rm -f *.o
