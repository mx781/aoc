module Lib
    (
        solvePuzzlePartOne,
        solvePuzzlePartTwo
    ) where

import System.IO
import Control.Monad

solvePuzzlePartOne :: FilePath -> IO Int
solvePuzzlePartOne inputFile = do
    contents <- readFile inputFile
    let instructions = parseInputToInstructions contents
    return $ sum instructions

solvePuzzlePartTwo :: FilePath -> IO Int
solvePuzzlePartTwo inputFile = do
    contents <- readFile inputFile
    let instructions = parseInputToInstructions contents
    return $ findFirstDuplicate instructions instructions 0 [0]

parseInputToInstructions :: String -> [Int]
parseInputToInstructions input = map parseToInt $ lines input

findFirstDuplicate :: [Int] -> [Int] -> Int -> [Int] -> Int
findFirstDuplicate allInstructions pendingInstructions frequency memory =
    let currentInstructions = if length pendingInstructions == 0
        then allInstructions
        else pendingInstructions;
        newFrequency = frequency + (head currentInstructions)
        seenBefore = elem newFrequency memory in
    if seenBefore
    then newFrequency
    else findFirstDuplicate allInstructions (tail currentInstructions) newFrequency (newFrequency : memory)

parseToInt :: String -> Int
parseToInt str =
    let sign = head str;
        num = tail str in
    if sign == '+'
    then read num :: Int
    else (read num :: Int) * (-1)
