COMPILERFLAGS = -Wall

CC = gcc
CFLAGS = $(COMPILERFLAGS) -g $(INCDIRS)
LIBS = -lX11 -lXi -lXmu -lglut -lGL -lGLU -lm

example : example.o
	$(CC) $(CFLAGS) -o example $(LIBDIRS) example.c $(LIBS)
clean:
	rm -f *.o
