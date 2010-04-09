"""
Draw four points on the screen
"""

import sys

try:
  from OpenGL.GLUT import *
  from OpenGL.GL import *
  from OpenGL.GLU import *
except:
  print '''
ERROR: PyOpenGL not installed properly.  
        '''
  sys.exit()


def display():
   # clear all pixels 
   glClear(GL_COLOR_BUFFER_BIT)

   # Specify the vertices (in this case just one) as an array, as in (x, y)
   vertices = [-0.8,0.8, 0.8,0.8, 0.8,-0.8, -0.8,-0.8]
   glVertexPointer(2, GL_FLOAT, 0, vertices)

   # Enable vertex arrays
   glEnableClientState(GL_VERTEX_ARRAY)

   # Set the drawing color
   glColor3f(1, 0, 0)
   
   # Draw the vertices
   glDrawArrays(GL_POINTS, 0, len(vertices)/2)

   # Disable vertex arrays
   glEnableClientState(GL_VERTEX_ARRAY)
   
   # don't wait!  
   # start processing buffered OpenGL routines 
   glFlush();

def init():
   # select clearing color 	
   glClearColor(0.0, 0.0, 0.0, 0.0)


#  Declare initial window size, position, and display mode
#  (single buffer and RGBA).  Open window with "hello"
#  in its title bar.  Call initialization routines.
#  Register callback function to display graphics.
#  Enter main loop and process events.

glutInit(sys.argv)
glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB)
glutInitWindowSize(250, 250)
glutInitWindowPosition(100, 100)
glutCreateWindow("Four points")
init()
glutDisplayFunc(display)
glutMainLoop()
