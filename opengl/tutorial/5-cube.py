"""
Draw a 3d box, rotate the camera using the arrow keys.
Zoom in and out using = and -.
Toggle culling with c.
Switch between cull modes with f.
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

angleInc = 5
posInc = 0.1
drawMode = GL_LINE_LOOP
ortho = True
view_rotx, view_roty, view_posz = (0, 0, 0)

def display():
  
  boxWidth = 1
  boxHeight = 1
  boxDepth = 1
  
   # clear all pixels 
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
  
  glMatrixMode(GL_MODELVIEW)
  glLoadIdentity()


  # Position the Camera
  glTranslate(0, 0, view_posz)
  # Rotate the camera
  z = -1
  glTranslate(0, 0, (2*z-boxDepth)*0.5)
  glRotatef(view_rotx, 1, 0, 0)
  glRotatef(view_roty, 0, 1, 0)
  glTranslate(0, 0, -(2*z-boxDepth)*0.5)

   # Specify the vertices and indices
  vertices = [0,        0,         z,
              0,        boxHeight, z,
              boxWidth, boxHeight, z,
              boxWidth, 0,         z,
              0,        0,         z-boxDepth,
              0,        boxHeight, z-boxDepth,
              boxWidth, boxHeight, z-boxDepth,
              boxWidth, 0,         z-boxDepth]
  
  frontFace = [3, 2, 1, 0]
  backFace  = [4, 5, 6, 7]
  leftFace  = [1, 5, 4, 0]
  rightFace = [3, 7, 6, 2]
  bottomFace = [0, 4, 7, 3]
  topFace = [2, 6, 5, 1]
  
  glVertexPointer(3, GL_FLOAT, 0, vertices)
  
   # Enable vertex arrays
  glEnableClientState(GL_VERTEX_ARRAY)
  
   # Set the drawing color
  glColor3f(1, 0, 0)
  
  # Move the box to the middle of the screen
  glTranslate(-boxWidth*0.5, -boxHeight*0.5, 0)
  
   # Draw the box
  glDrawElements(GL_LINE_LOOP, len(frontFace), GL_UNSIGNED_INT, frontFace)
  glDrawElements(GL_LINE_LOOP, len(backFace), GL_UNSIGNED_INT, backFace)
  glDrawElements(drawMode, len(leftFace), GL_UNSIGNED_INT, leftFace)
  glDrawElements(drawMode, len(rightFace), GL_UNSIGNED_INT, rightFace)
  glDrawElements(drawMode, len(bottomFace), GL_UNSIGNED_INT, bottomFace)
  glDrawElements(drawMode, len(topFace), GL_UNSIGNED_INT, topFace)
  
   # Disable vertex arrays
  glEnableClientState(GL_VERTEX_ARRAY)
  
   # Swap the buffers (glFLush() implicit)
  glutSwapBuffers()
  
def special(k, x, y):
  global view_rotx, view_roty, view_rotz
  
  if k == GLUT_KEY_UP:
    view_rotx += angleInc
  elif k == GLUT_KEY_DOWN:
    view_rotx -= angleInc
  elif k == GLUT_KEY_LEFT:
    view_roty -= angleInc
  elif k == GLUT_KEY_RIGHT:
    view_roty += angleInc
  else:
        return
  glutPostRedisplay()

def key(k, x, y):
  global view_posz, drawMode, ortho
  
  if k == '=':
    view_posz += posInc
  elif k == '-':
    view_posz -= posInc
  elif k == 'm':
    drawMode = GL_LINE_LOOP if drawMode == GL_TRIANGLE_FAN else GL_TRIANGLE_FAN
  elif k == 'c':
    if glIsEnabled(GL_CULL_FACE):
      glDisable(GL_CULL_FACE)
    else:
      glEnable(GL_CULL_FACE)
  elif k == 'f':
    l = glGetFloatv(GL_CULL_FACE_MODE)
    if  l == GL_BACK:
      glCullFace(GL_FRONT)
    else:
      glCullFace(GL_BACK)
  elif k == 'p':
    ortho = not ortho
    reshape(windowWidth, windowHeight)
  else:
        return
  glutPostRedisplay()
    
def reshape(width, height):
  global windowWidth, windowHeight
  windowWidth, windowHeight = width, height
  
  # Setup the drawing area (bottomX bottomY, topX, topY)
  glViewport(0, 0, width, height)

  # Define the clipping volume (left, right, bottom, top, near, far)
  glMatrixMode(GL_PROJECTION)
  glLoadIdentity()
  if ortho:
    glOrtho(-1, 1, -1, 1, -1, 200)
  else:
    glFrustum(-1, 1, -1, 1, 1, 201)

  # Initialize the model-view matrix
  glMatrixMode(GL_MODELVIEW)
  glLoadIdentity()
    
def init():
   # select clearing color      
   glClearColor(0.0, 0.0, 0.0, 0.0)
   glEnable(GL_CULL_FACE)
   glShadeModel(GL_SMOOTH)
   glEnable(GL_DEPTH_TEST)

#  Declare initial window size, position, and display mode
#  (double buffer and RGBA).  Open window with "hello"
#  in its title bar.  Call initialization routines.
#  Register callback function to display graphics.
#  Enter main loop and process events.

glutInit(sys.argv)
glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH)

screenWidth, screenHeight = (glutGet(GLUT_SCREEN_WIDTH), glutGet(GLUT_SCREEN_HEIGHT))
windowWidth, windowHeight = (screenWidth/2, screenHeight/2)

glutInitWindowSize(windowWidth, windowHeight)
glutInitWindowPosition((screenWidth-windowWidth)/2, (screenHeight-windowHeight)/2)
glutCreateWindow("3D Box")
init()
glutSpecialFunc(special)
glutKeyboardFunc(key)
glutReshapeFunc(reshape)
OpenGL.GLUT.glutDisplayFunc(display)
glutMainLoop()
