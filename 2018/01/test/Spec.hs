module Main where

import Test.HUnit
import Lib

partOneShared = TestCase (do result <- solvePuzzlePartOne "inputs/test.txt"
                             assertEqual "Shared example" result 3)
partOne0 = TestCase (do result <- solvePuzzlePartOne "inputs/test1-0.txt"
                        assertEqual "Part 1: Example 1" result 3)
partOne1 = TestCase (do result <- solvePuzzlePartOne "inputs/test1-1.txt"
                        assertEqual "Part 1: Example 2" result 0)
partOne2 = TestCase (do result <- solvePuzzlePartOne "inputs/test1-2.txt"
                        assertEqual "Part 1: Example 3" result (-6))

partTwoShared = TestCase (do result <- solvePuzzlePartTwo "inputs/test.txt"
                             assertEqual "Shared example" result 2)
partTwo0 = TestCase (do result <- solvePuzzlePartTwo "inputs/test2-0.txt"
                        assertEqual "Part 2: Example 1" result 0)
partTwo1 = TestCase (do result <- solvePuzzlePartTwo "inputs/test2-1.txt"
                        assertEqual "Part 2: Example 2" result 10)
partTwo2 = TestCase (do result <- solvePuzzlePartTwo "inputs/test2-2.txt"
                        assertEqual "Part 2: Example 3" result 5)
partTwo3 = TestCase (do result <- solvePuzzlePartTwo "inputs/test2-3.txt"
                        assertEqual "Part 2: Example 4" result 14)

partOneTests = TestList [partOneShared, partOne0, partOne1, partOne2]
partTwoTests = TestList [partTwoShared, partTwo0, partTwo1, partTwo2, partTwo3]
allTests = TestList [partOneTests, partTwoTests]

main = runTestTT allTests