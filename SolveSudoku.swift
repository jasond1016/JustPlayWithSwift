//: Playground - noun: a place where people can play

import UIKit

var puzzle = [0,6,0,0,8,3,2,0,0,
              0,5,7,0,0,2,0,0,3,
              0,8,2,0,0,0,0,7,6,
              0,0,8,3,7,0,1,0,0,
              7,0,0,0,4,0,0,0,9,
              0,0,5,0,2,6,3,0,0,
              8,3,0,0,0,0,5,1,0,
              5,0,0,4,0,0,6,9,0,
              0,0,4,6,5,0,0,3,0
]

//var puzzleInSolving = puzzle
let trySetOriginal: Set = [1,2,3,4,5,6,7,8,9]
var trySet: Set = trySetOriginal

func checkRow(_ puzzle: [Int], _ num: Int, _ row: Int) -> Bool {
    for col in 0...8 {
        if puzzle[row * 9 + col] == num {
            return false
        }
    }
    return true
}

func checkCol(_ puzzle: [Int], _ num: Int, _ col: Int) -> Bool {
    for row in 0...8 {
        if puzzle[row * 9 + col] == num {
            return false
        }
    }
    return true
}

func checkSquare(_ puzzle: [Int], _ num: Int, _ row: Int, _ col: Int) -> Bool {
    let startRow = row / 3 * 3
    let startCol = col / 3 * 3
    for i in startRow...(startRow + 2) {
        for j in startCol...(startCol + 2) {
            if puzzle[i * 9 + j] == num {
                return false
            }
        }
    }
    return true
}

func checkAll(_ puzzle: [Int], _ tryNumber: Int, _ row: Int, _ col: Int) -> Bool {
    if checkRow(puzzle, tryNumber, row) && checkCol(puzzle, tryNumber, col) && checkSquare(puzzle, tryNumber, row, col) {
        return true
    }
    return false
}

func printOut(puzzle: [Int]) {
    for row in 0...8 {
        print(" -----------------------------------")
        print("| ", terminator: "")
        for col in 0...8 {
            print(puzzle[row * 9 + col], terminator: " | ")
        }
        print("")
    }
    print(" -----------------------------------")
}

func makePossibleSolutions(puzzle: [Int]) -> [Int: [Int]] {
    var possibleNums:[Int:[Int]] = [Int: [Int]]()
    for i in 0...80 {
        if puzzle[i] != 0 {
            continue
        }
        let row = i / 9
        let col = i % 9
        for tryNumber in 1...9 {
            if checkAll(puzzle, tryNumber, row, col) {
                if possibleNums[i] != nil {
                    possibleNums[i]!.append(tryNumber)
                } else {
                    possibleNums[i] = [tryNumber]
                }
//                print("tryNumber: \(tryNumber), possibleNums[\(i)]: \(possibleNums[i])")
            }
        }
    }
    return possibleNums
}

func fillInDeterminatedAnswer(puzzle: [Int]) -> [String: Any] {
    var puzzleInSolving = puzzle
    var possibleSolutions: [Int: [Int]] = [Int: [Int]]()
    var puzzleAndPossibleSolutions: [String: Any] = [String: Any]()
    var stillHaveDeterminatedAnswer: Bool = true
    while stillHaveDeterminatedAnswer {
        stillHaveDeterminatedAnswer = false
        possibleSolutions = makePossibleSolutions(puzzle: puzzleInSolving)
//        print(possibleSolutions)
        //    printOut(puzzle: puzzleInSolving)
        for i in possibleSolutions.keys {
            if possibleSolutions[i]?.count == 1 {
                stillHaveDeterminatedAnswer = true
                puzzleInSolving[i] = (possibleSolutions[i]?.first)!
            }
        }
//        printOut(puzzle: puzzleInSolving)
//        print(possibleSolutions)
//        print("-------------------------")
    }
    puzzleAndPossibleSolutions["puzzle"] = puzzleInSolving
    puzzleAndPossibleSolutions["possibleSolutions"] = possibleSolutions
    return puzzleAndPossibleSolutions
}

func tryPossibleSolutions(puzzle: [Int], possibleSolutionsPara: [Int: [Int]], tryIndexPara: Int) -> Bool {
    var puzzleAndPossibleSolutions: [String: Any] = [String: Any]()
    var puzzleInSolving = puzzle
    var possibleSolutions = possibleSolutionsPara
    var tryIndex = tryIndexPara

    if !puzzleInSolving.contains(0) {
        printOut(puzzle: puzzleInSolving)
        print("puzzle solved.")
        return true
    }

    if possibleSolutions[tryIndex] == nil {
        tryIndex += 1
    }

    for i in possibleSolutions.keys {
        if possibleSolutions[i]?.count == 0 {
            return false
        } else {
            puzzleInSolving[i] = (possibleSolutions[i]?.last)!
        }
        puzzleAndPossibleSolutions = fillInDeterminatedAnswer(puzzle:puzzleInSolving)
        puzzleInSolving = puzzleAndPossibleSolutions["puzzle"] as! [Int]
        possibleSolutions = puzzleAndPossibleSolutions["possibleSolutions"] as! [Int: [Int]]
        if (tryPossibleSolutions(puzzle: puzzleInSolving, possibleSolutionsPara: possibleSolutions)) {

        }

    }
}

func solvePuzzle(puzzle: [Int]) {
    var puzzleAndPossibleSolutions: [String: Any] = [String: Any]()
    var puzzleInSolving = puzzle
    var possibleSolutions: [Int: [Int]] = [Int: [Int]]()

    puzzleAndPossibleSolutions = fillInDeterminatedAnswer(puzzle: puzzleInSolving)
    puzzleInSolving = puzzleAndPossibleSolutions["puzzle"] as! [Int]
    possibleSolutions = puzzleAndPossibleSolutions["possibleSolutions"] as! [Int: [Int]]

    if !puzzleInSolving.contains(0) {
        printOut(puzzle: puzzleInSolving)
        print("puzzle solved.")
        return
    }

//    var possibleSolutions = makePossibleSolutions(puzzle:puzzleInSolving)
//    print(possibleSolutions)
////    printOut(puzzle: puzzleInSolving)
//    for i in possibleSolutions.keys {
//        if possibleSolutions[i]?.count == 1 {
//            puzzleInSolving[i] = (possibleSolutions[i]?.first)!
//        }
//    }
////    printOut(puzzle: puzzleInSolving)
//
//    possibleSolutions = makePossibleSolutions(puzzle:puzzleInSolving)
//    print(possibleSolutions)
//    for i in possibleSolutions.keys {
//        if possibleSolutions[i]?.count == 1 {
//            puzzleInSolving[i] = (possibleSolutions[i]?.first)!
//        }
//    }
//    possibleSolutions = makePossibleSolutions(puzzle:puzzleInSolving)
//    print(possibleSolutions)

//    for row in 0...8 {
//        for col in 0...8 {
//            if puzzle[row * 9 + col] != 0 {
//                continue
//            }
//
////            trySet = trySetOriginal
//            if triedNumbers.count != 0 {
//                for triedNumber in triedNumbers {
//                    trySet.remove(triedNumber)
//                }
//            }
//            for tryNumber in trySet {
////                print("row: \(row), col: \(col)")
//                if checkAll(puzzleInSolving, tryNumber, row, col) {
//                    triedNumbers.append(tryNumber)
//                    puzzleInSolving[row * 9 + col] = tryNumber
//                    solvePuzzle(puzzle: puzzleInSolving, puzzleForRecover:puzzleForRecover, triedNumbersPara: [])
//                } else {
//                    print("puzzleInSolving:")
//                    printOut(puzzle: puzzleInSolving)
//                    print("puzzleForRecover:")
//                    printOut(puzzle: puzzleForRecover)
////                    trySet.remove(tryNumber)
//                    print("trySet")
//                    print(trySet)
//                }
//
//            }
//            puzzleInSolving = puzzleForRecover
//            solvePuzzle(puzzle: puzzleInSolving, puzzleForRecover:puzzleForRecover, triedNumbersPara: [])
//        }
//    }
}

//printOut(puzzle: puzzle)
//print("kkkkkkkkkkkkkk")
//var p = puzzle
//p[0] = 9
//printOut(puzzle: puzzle)
//print("kkkkkkkkkkkkkk")
//printOut(puzzle: p)

//solvePuzzle(puzzle: puzzle, puzzleForRecover:puzzle, trySetPass: trySetOriginal)

//print(trySet)
//trySet.remove(2)
//print(trySet)

solvePuzzle(puzzle:puzzle)
