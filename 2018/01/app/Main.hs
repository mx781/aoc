module Main where

import Lib

main :: IO ()
main = do
    resultPartOne <- solvePuzzlePartOne "inputs/input.txt"
    print $ "Result for part one: " ++ show resultPartOne
    resultPartTwo <- solvePuzzlePartTwo "inputs/input.txt"
    print $ "Result for part two: " ++ show resultPartTwo
