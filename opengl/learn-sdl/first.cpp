#include <iostream>
#include <GL/gl.h>
#include <SDL/SDL.h>

#ifndef PI
#define PI 3.14159265
#endif

int main(int argc, char *argv[])
{
  SDL_Init(SDL_INIT_VIDEO);

  SDL_Surface *screen = SDL_SetVideoMode(300, 300, 16, SDL_OPENGL|SDL_RESIZABLE);
  if ( ! screen ) {
    fprintf(stderr, "Couldn't set GL video mode: %s\n", SDL_GetError());
    SDL_Quit();
    exit(2);
  }
  
  SDL_WM_SetCaption("Gears", "gears");

  int done = 0;
  while ( ! done ) {
    SDL_Event event;

    while ( SDL_PollEvent(&event) ) {
      switch(event.type) {
      case SDL_VIDEORESIZE:
	std::cout << "Resized" << std::endl;
        screen = SDL_SetVideoMode(event.resize.w, event.resize.h, 16,
                                  SDL_OPENGL|SDL_RESIZABLE);
        if ( screen ) {
          // reshape(screen->w, screen->h);
        } else {
          /* Uh oh, we couldn't set the new video mode?? */;
        }
        break;

      case SDL_QUIT:
        done = 1;
        break;
      }
    }
    unsigned char *keys = SDL_GetKeyState(NULL);

    if ( keys[SDLK_ESCAPE] ) {
      done = 1;
    }
    if ( keys[SDLK_UP] ) {
      // view_rotx += 5.0;
    }
    if ( keys[SDLK_DOWN] ) {
      // view_rotx -= 5.0;
    }
    if ( keys[SDLK_LEFT] ) {
      // view_roty += 5.0;
    }
    if ( keys[SDLK_RIGHT] ) {
      // view_roty -= 5.0;
    }
    if ( keys[SDLK_z] ) {
      if ( SDL_GetModState() & KMOD_SHIFT ) {
        // view_rotz -= 5.0;
      } else {
        // view_rotz += 5.0;
      }
    }

    // draw();
  }
  SDL_Quit();

  return 0;
}
