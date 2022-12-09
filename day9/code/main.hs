module Main where

import Data.Set (Set)
import Data.Foldable (foldl')
import System.Environment (getArgs)
import qualified Data.Set as Set

data Point = Point Int Int
  deriving (Show, Eq, Ord)

data Direction = DUp | DRight | DDown | DLeft
  deriving Show

move :: Point -> Direction -> Point
move (Point x y) DUp = Point x (y - 1)
move (Point x y) DRight = Point (x + 1) y
move (Point x y) DDown = Point x (y + 1)
move (Point x y) DLeft = Point (x - 1) y

signOf :: Int -> Int
signOf x = if x < 0 then -1 else (if x > 0 then 1 else 0)

adjustCoords :: Point -> Point -> Point
adjustCoords (Point headX headY) (Point tailX tailY) =
  if headX == tailX && (abs (headY - tailY)) == 2
  then Point tailX (tailY + (signOf (headY - tailY)))
  else
    if headY == tailY && (abs (headX - tailX)) == 2
    then Point (tailX + (signOf (headX - tailX))) tailY
    else
      if (abs (headX - tailX)) > 1 || (abs (headY - tailY)) > 1
      then Point
        (tailX + (signOf (headX - tailX)))
        (tailY + (signOf (headY - tailY)))
      else Point tailX tailY

adjustTail :: [Point] -> [Point]
adjustTail snake = head snake : zipWith adjustCoords snake (tail snake)

moveSnake :: ([Point], Set Point) -> Direction -> ([Point], Set Point)
moveSnake (snake, allTails) direction =
  let snake' = adjustTail $ move (head snake) direction : tail snake
  in (snake', Set.insert (last snake') allTails)

parseDirection :: Char -> Direction
parseDirection 'U' = DUp
parseDirection 'R' = DRight
parseDirection 'D' = DDown
parseDirection 'L' = DLeft

parseLine :: String -> [Direction]
parseLine (c:_:num) = take (read num) $ repeat (parseDirection c)

parseInput :: String -> [Direction]
parseInput inp = (lines inp) >>= parseLine

main :: IO ()
main = do
  inp <- getContents
  [part] <- getArgs
  let snakeLength = if part == "2" then 10 else 2
  let snake = take snakeLength $ repeat (Point 0 0)
  let (snake', allTails) = foldl' moveSnake (snake, Set.empty) (parseInput inp)
  print $ Set.size allTails
