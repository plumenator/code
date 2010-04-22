"""
Draw a 3d box, rotate the camera using the arrow keys.
"""
import sys, random

try:
  from OpenGL.GLUT import *
  from OpenGL.GL import *
  from OpenGL.GLU import *
except:
  print '''
ERROR: PyOpenGL not installed properly.  
        '''
  sys.exit()

# Initial screen size
screenWidth = 1000
screenHeight = 1000

view_rotx, view_roty, view_rotz = (0, 0, 0)

def display():
  
  boxWidth = screenWidth/5
  boxHeight = screenHeight/5
  boxDepth = (screenHeight+screenWidth)/10
  
   # clear all pixels 
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
  
  glMatrixMode(GL_MODELVIEW)
  glLoadIdentity()

  # Rotate the camera
  glTranslate(screenWidth/2, screenHeight/2, 0)
  glRotatef(view_rotx, 1, 0, 0)
  glRotatef(view_roty, 0, 1, 0)
  glTranslate(-screenWidth/2, -screenHeight/2, 0)
  
   # Specify the vertices and indices
  vertices = [0,        0,         0,
              0,        boxHeight, 0,
              boxWidth, boxHeight, 0,
              boxWidth, 0,         0,
              0,        0,         boxDepth,
              0,        boxHeight, boxDepth,
              boxWidth, boxHeight, boxDepth,
              boxWidth, 0,         boxDepth]
  
  frontFace = [0, 1, 2, 3]
  backFace  = [7, 6, 5, 4]
  leftFace  = [3, 7, 4, 0]
  rightFace = [1, 5, 6, 2]
  
  glVertexPointer(3, GL_FLOAT, 0, vertices)
  
   # Enable vertex arrays
  glEnableClientState(GL_VERTEX_ARRAY)
  
   # Set the drawing color
  glColor3f(1, 0, 0)
  
  # Move the box to the middle of the screen
  glTranslate((screenWidth-boxWidth)/2, (screenHeight-boxHeight)/2, 0)
  
   # Draw the box
  glDrawElements(GL_LINE_LOOP, len(frontFace), GL_UNSIGNED_INT, frontFace)
  glDrawElements(GL_LINE_LOOP, len(backFace), GL_UNSIGNED_INT, backFace)
  glDrawElements(GL_LINE_LOOP, len(leftFace), GL_UNSIGNED_INT, leftFace)
  glDrawElements(GL_LINE_LOOP, len(rightFace), GL_UNSIGNED_INT, rightFace)
  
   # Disable vertex arrays
  glEnableClientState(GL_VERTEX_ARRAY)
  
   # Swap the buffers (glFLush() implicit)
  glutSwapBuffers();
  
def special(k, x, y):
  global view_rotx, view_roty, view_rotz
  
  if k == GLUT_KEY_UP:
    view_rotx += 1.0
  elif k == GLUT_KEY_DOWN:
    view_rotx -= 1.0
  elif k == GLUT_KEY_LEFT:
    view_roty += 1.0
  elif k == GLUT_KEY_RIGHT:
    view_roty -= 1.0
  else:
        return
  glutPostRedisplay()
    
def reshape(width, height):
  # Setup the drawing area (bottomX bottomY, topX, topY)
  glViewport(0, 0, width, height)

  # Update the screen width and height
  global screenWidth, screenHeight
  screenWidth = width
  screenHeight = height
  
  # Define the clipping volume (left, right, bottom, top, near, far)
  glMatrixMode(GL_PROJECTION)
  glLoadIdentity()
  glOrtho(0, width, 0, height, -(screenHeight+screenWidth)/10, (screenHeight+screenWidth)/10);
  # Initialize the model-view matrix
  glMatrixMode(GL_MODELVIEW)
  glLoadIdentity();
    
def init():
   # select clearing color      
   glClearColor(0.0, 0.0, 0.0, 0.0)
   glFrontFace(GL_CCW)
   glCullFace(GL_BACK)
   glEnable(GL_CULL_FACE)
   #glShadeModel(GL_SMOOTH)
   #glEnable(GL_DEPTH_TEST)

#  Declare initial window size, position, and display mode
#  (double buffer and RGBA).  Open window with "hello"
#  in its title bar.  Call initialization routines.
#  Register callback function to display graphics.
#  Enter main loop and process events.

glutInit(sys.argv)
glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB)
glutInitWindowSize(screenWidth, screenHeight)
glutInitWindowPosition(100, 100)
glutCreateWindow("3D Box")
init()
glutSpecialFunc(special)
glutReshapeFunc(reshape)
OpenGL.GLUT.glutDisplayFunc(display)
glutMainLoop()
