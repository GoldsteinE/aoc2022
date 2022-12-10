module Main where

import Data.Set (Set)
import Data.Foldable (foldl')
import System.Environment (getArgs)
import qualified Data.Set as Set

data Point     = Point Int Int deriving (Show, Eq, Ord)
data Direction = U | R | D | L deriving (Show, Read)

move :: Point -> Direction -> Point
move (Point x y) d = case d of
  U -> Point x (y - 1)
  R -> Point (x + 1) y
  D -> Point x (y + 1)
  L -> Point (x - 1) y

adjustCoords :: Point -> Point -> Point
adjustCoords (Point headX headY) (Point tailX tailY)
  | headX == tailX  && far headY tailY = Point tailX               (shift tailY headY)
  | headY == tailY  && far headX tailX = Point (shift tailX headX) tailY
  | far headX tailX || far headY tailY = Point (shift tailX headX) (shift tailY headY)
  | otherwise                          = Point tailX               tailY
  where
    far a b = abs (a - b) > 1
    shift a b = a + (signum (b - a))

adjustTail :: [Point] -> [Point]
adjustTail snake = head snake : zipWith adjustCoords snake (tail snake)

moveSnake :: ([Point], Set Point) -> Direction -> ([Point], Set Point)
moveSnake (snake, allTails) direction =
  let snake' = adjustTail $ move (head snake) direction : tail snake
  in (snake', Set.insert (last snake') allTails)

parseLine :: String -> [Direction]
parseLine (c:_:num) = take (read num) $ repeat (read [c])

parseInput :: String -> [Direction]
parseInput inp = lines inp >>= parseLine

main :: IO ()
main = do
  inp <- getContents
  [part] <- getArgs
  let snakeLength = if part == "2" then 10 else 2
  let snake = take snakeLength $ repeat (Point 0 0)
  let (snake', allTails) = foldl' moveSnake (snake, Set.empty) (parseInput inp)
  print $ Set.size allTails
