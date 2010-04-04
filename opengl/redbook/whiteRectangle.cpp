#include <GL/gl.h>
#include <SDL/SDL.h>

#ifndef M_PI
#define M_PI 3.14159265
#endif

static GLint T0 = 0;
static GLint Frames = 0;

void draw(int width, int height)
{
  glClearColor(0, 0, 0, 1);
  glClear(GL_COLOR_BUFFER_BIT);

  GLfloat vertices[] = {
    width*(1/4.f), height*(1/4.f),
    width*(1/4.f), height*(3/4.f),
    width*(3/4.f), height*(3/4.f),
    width*(3/4.f), height*(1/4.f)
  };

  glEnableClientState(GL_VERTEX_ARRAY);
  glVertexPointer(2, GL_FLOAT, 0, vertices);

  glColor4f(1, 1, 1, 1);
  glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
  
  glDisableClientState(GL_VERTEX_ARRAY);

  SDL_GL_SwapBuffers();
  
  Frames++;
  {
    GLint t = SDL_GetTicks();
    if (t - T0 >= 5000) {
      GLfloat seconds = (t - T0) / 1000.0;
      GLfloat fps = Frames / seconds;
      printf("%d frames in %g seconds = %g FPS\n", Frames, seconds, fps);
      T0 = t;
      Frames = 0;
    }
  }
}

/* new window size or exposure */
void reshape(int width, int height)
{
  GLfloat h = (GLfloat) height / (GLfloat) width;

  glViewport(0, 0, (GLint) width, (GLint) height);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  glOrtho(0, width, 0, height, -1, 1);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
}

int main(int argc, char *argv[])
{
  SDL_Surface *screen;
  int done;
  Uint8 *keys;

  SDL_Init(SDL_INIT_VIDEO);
  SDL_GL_SetAttribute( SDL_GL_DOUBLEBUFFER, 1 );
  screen = SDL_SetVideoMode(300, 300, 16, SDL_OPENGL|SDL_RESIZABLE);
  if (!screen) {
    fprintf(stderr, "Couldn't set 300x300 GL video mode: %s\n", SDL_GetError());
    SDL_Quit();
    exit(2);
  }
  SDL_WM_SetCaption("White rectangle", "White rectangle");

  reshape(screen->w, screen->h);
  done = 0;
  while (!done) {
    SDL_Event event;

    while (SDL_PollEvent(&event)) {
      switch(event.type) {
      case SDL_VIDEORESIZE:
	SDL_GL_SetAttribute( SDL_GL_DOUBLEBUFFER, 1 );
	screen = SDL_SetVideoMode(event.resize.w, event.resize.h, 32,
				  SDL_OPENGL|SDL_RESIZABLE);
	if (screen) {
	  reshape(screen->w, screen->h);
	} else {
	  /* Uh oh, we couldn't set the new video mode?? */;
	}
	break;

      case SDL_QUIT:
	done = 1;
	break;
      }
    }
    keys = SDL_GetKeyState(NULL);

    if (keys[SDLK_ESCAPE]) {
      done = 1;
    }

    draw(screen->w, screen->h);
  }
  SDL_Quit();
  return 0;
}
