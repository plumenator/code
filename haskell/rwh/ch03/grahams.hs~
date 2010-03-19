module Main where
import List
import Text.Regex.Posix
import GHC.Float
import Graphics.UI.Gtk  hiding (fill)
import Graphics.Rendering.Cairo
import Data.IORef

data State = State { 
    inputPoints :: IORef [(Double,Double)]
}

newState :: IO State
newState = do 
    ips <- newIORef []
    return $ State { inputPoints = ips }
                     
main = do
    initGUI

    window <- windowNew
    set window [windowTitle := "Graham", 
                containerBorderWidth := 10]

    vbox <- vBoxNew False 0
    containerAdd window vbox

    state <- newState 
    canvas <- drawingAreaNew
    onSizeRequest canvas $ return (Requisition 400 400)
    onButtonPress canvas (addPoint canvas state)

    boxPackStartDefaults vbox canvas
    widgetModifyBg canvas StateNormal (Color 0 0 0)

    button <- buttonNewFromStock stockClear
    onButtonPress button $ clearPoints canvas state

    boxPackStartDefaults vbox button

    onDestroy window mainQuit

    widgetShowAll window
    mainGUI

addPoint :: DrawingArea -> State -> Event -> IO Bool
addPoint canvas (State { inputPoints = ips }) (Button { eventX = x, eventY = y }) = do
    oldIps <- readIORef ips
    newIps <- return ((x,y):oldIps)
    writeIORef ips newIps
    drawWin <- widgetGetDrawWindow canvas
    grahamPs <- return (graham newIps)
    renderWithDrawable drawWin (render newIps grahamPs)
    return True

clearPoints :: DrawingArea -> State -> Event -> IO Bool
clearPoints canvas (State { inputPoints = ips }) (Button { eventX = x, eventY = y }) = do
    writeIORef ips []
    drawWin <- widgetGetDrawWindow canvas
    renderWithDrawable drawWin paint
    return True

render :: [(Double,Double)] -> [(Double,Double)] -> Render()
render ips ops = do
    setSourceRGB 0 0 0 
    paint

    renderPoints ips
    if (length ops) > 2 then renderPolygon ops
                        else return ()
   
renderPoints :: [(Double,Double)] -> Render ()
renderPoints ((px, py):ps) = do 
    setSourceRGB 0 1 0
    arc px py 5 0 (2*pi)
    fill
    renderPoints ps
renderPoints [] = do return ()

renderPolygon :: [(Double,Double)] -> Render ()
renderPolygon ((px, py):ps) = do
    setSourceRGBA 1 1 0 0.5
    moveTo px py 
    lines ps  
    lineTo px py
    fill
    where lines ((px, py):ps) = do
              lineTo px py 
              lines ps
          lines [] = do return ()

renderPolygon [] = do return ()
  
cross (x1, y1) (x2, y2) (x3, y3) = 
    (x2 - x1)*(y3 - y1) - (y2 - y1)*(x3 - x1)

pivot ps = minimumBy cmp ps  
           where cmp a b = case yc of EQ -> xc
                                      _  -> yc 
                          where xc = compare (fst a) (fst b)
                                yc = compare (snd a) (snd b)

pivotSort ps = (px, py):(sortBy cmp ps') 
               where cmp (x1, y1) (x2, y2) = compare a1 a2 
                                             where a1 = atan2 (y1 - py) (x1 - px) 
                                                   a2 = atan2 (y2 - py) (x2 - px)
                     ps' = filter ((/=)(px, py)) ps
                     (px, py) = pivot ps

graham ps = outer (drop 2 ps') [(ps' !! 1), (ps' !! 0)]
            where ps' = pivotSort ps
                  outer ps rs = if ps /= [] then outer (tail ps) (inner (head ps) rs)
                                            else rs
                  inner p ps = if (length ps) >= 2 && (cross (ps !! 1) (ps !! 0) p) <= 0 
                               then inner p (tail ps)
                               else p:ps
