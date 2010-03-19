#include <stdio.h>
#include <stdlib.h>

#include <GL/glx.h>
#include <GL/gl.h>

#include <X11/X.h>
#include <X11/keysym.h>

#define TRUE 1
#define FALSE 0

int main() {
  Display *dpy = XOpenDisplay(getenv("DISPLAY"));

  int nelements;
  GLXFBConfig *cfg = glXGetFBConfigs(dpy, 0, &nelements);
  printf("Number of GLX Config elements returned: %d\n", nelements);

  /* Let's get the visual. */
  XVisualInfo *vi = glXGetVisualFromFBConfig(dpy, *cfg);

  /* Let's create an X window */
  Window xWin = XCreateWindow(dpy, RootWindow(dpy, vi->screen), 0, 0, 300, 300,
				0, vi->depth, InputOutput, vi->visual, 0, NULL);
  
  /* Now, we associate it with GLX, create a GLX window. */
  GLXWindow gWin = glXCreateWindow(dpy, *cfg, xWin, NULL);

  /* Time to create a GLX context */
  GLXContext ctx = glXCreateNewContext(dpy, *cfg, GLX_RGBA_TYPE, NULL, TRUE);

  /* Make it current */
  glXMakeContextCurrent(dpy, xWin, xWin, ctx);

  /* Is our context a direct rendering one? */
  printf("Our context is a %sdirect rendering context.\n", 
	 glXIsDirect(dpy, ctx)?"":"non-");

  /* Free the context */
  glXMakeContextCurrent(dpy, None, None, NULL);

  glXDestroyContext(dpy, ctx);
  glXDestroyWindow(dpy, gWin);
  XDestroyWindow(dpy, xWin);
  XCloseDisplay(dpy);
  return 0;
}
