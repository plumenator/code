import Graphics.UI.GLUT
import Graphics.Rendering.OpenGL

main = do
  getArgsAndInitialize
  createAWindow "Hello Window"
  mainLoop

createAWindow windowName = do
  createWindow windowName
  displayCallback $= clear [ColorBuffer]