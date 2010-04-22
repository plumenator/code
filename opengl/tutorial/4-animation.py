"""
Draw a bouncing box

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
screenWidth = 250
screenHeight = 250

# Initial position
xPosition, yPosition = (0, 0)

# Initial direction
xDirection, yDirection = (1, 1)

# Update interval
t = 10

# Position increment
inc = 25

def display(i):
   # clear all pixels 
   glClear(GL_COLOR_BUFFER_BIT)

   # Prevent the box from going out of the screen
   clipToWindow()

   glMatrixMode(GL_MODELVIEW)
   glLoadIdentity()
   glTranslate(xPosition, yPosition, 0);

   # Specify the vertices (in this case just one) as an array, as in (x, y)
   vertices = [0, 0,
               0, 50,
               50, 50,
               50, 0]

   glVertexPointer(2, GL_FLOAT, 0, vertices)

   # Enable vertex arrays
   glEnableClientState(GL_VERTEX_ARRAY)

   # Set the drawing color
   glColor3f(1, 0, 0)
   
   # Draw the vertices
   glDrawArrays(GL_TRIANGLE_FAN, 0, len(vertices)/2)

   # Disable vertex arrays
   glEnableClientState(GL_VERTEX_ARRAY)
   
   # Swap the buffers (glFLush() implicit)
   glutSwapBuffers();

   # Compute the new position
   updatePosition()

   glutTimerFunc(t, display, 1)

def clipToWindow():
  global xPosition, yPosition, xDirection, yDirection, inc
  xPosition = xPosition if xPosition + 50 <= screenWidth else screenWidth - 50
  yPosition = yPosition if yPosition + 50 <= screenHeight else screenHeight - 50

def updatePosition():
  global xPosition, yPosition, xDirection, yDirection, inc
  incX, incY = (random.randint(0, inc), random.randint(0, inc))
  xDirection = -xDirection if (xPosition + xDirection*incX > screenWidth - 50) or (xPosition + xDirection*incX < 0) else xDirection
  yDirection = -yDirection if (yPosition + yDirection*incY > screenHeight - 50) or (yPosition + yDirection*incY < 0) else yDirection
  xPosition = xPosition + xDirection*incX
  yPosition = yPosition + yDirection*incY
  
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
  glOrtho(0, width, 0, height, -1, 1);

  # Initialize the model-view matrix
  glMatrixMode(GL_MODELVIEW)
  glLoadIdentity();
    
def init():
   # select clearing color      
   glClearColor(0.0, 0.0, 0.0, 0.0)


#  Declare initial window size, position, and display mode
#  (double buffer and RGBA).  Open window with "hello"
#  in its title bar.  Call initialization routines.
#  Register callback function to display graphics.
#  Enter main loop and process events.

glutInit(sys.argv)
glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB)
glutInitWindowSize(screenWidth, screenHeight)
glutInitWindowPosition(100, 100)
glutCreateWindow("Bouncing rectangle")
init()
glutReshapeFunc(reshape)
OpenGL.GLUT.glutDisplayFunc(display, None)
glutTimerFunc(t, display, 1)
glutMainLoop()
