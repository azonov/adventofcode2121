import Foundation
let separator = "\n\n"
let filepath = "Input.txt"

class Board {
    struct Coordinate: Hashable {
        let row: Int
        let col: Int
    }

    typealias HasWinCombination = Bool
    
    private var fastAccessDict: [Int: Coordinate] = [:]
    private var numInRow: [Int: Int] = [:]
    private var numInCol: [Int: Int] = [:]
    private var notCrossedCoordinatesWithValue: [Coordinate: Int] = [:]
    private var lastNum: Int?
    
    init(rawValue: String) {
        let elements = rawValue
            .components(separatedBy: "\n")
            .map { $0.components(separatedBy: " ").filter{ !$0.isEmpty } }
        for (rowIndex, rowValues) in elements.enumerated() {
            for (colIndex, element) in rowValues.enumerated() {
                fastAccessDict[Int(element)!] = Coordinate(row: rowIndex, col: colIndex)
                notCrossedCoordinatesWithValue[Coordinate(row: rowIndex, col: colIndex)] = Int(element)!
            }
        }
    }
    
    func crossIfExist(value: Int) -> HasWinCombination {
        guard let coordinates = fastAccessDict[value] else {
            return false
        }
        lastNum = value
        notCrossedCoordinatesWithValue[coordinates] = nil
        numInRow[coordinates.row, default: 0] += 1
        guard numInRow[coordinates.row]! < 5 else {
            return true
        }
        
        numInCol[coordinates.col, default: 0] += 1
        guard numInCol[coordinates.col]! < 5 else {
            return true
        }
        return false
    }
    
    func calculateScore() -> Int {
        let unmarkedSum = notCrossedCoordinatesWithValue.values.reduce(0, +)// sum of all unmarked numbers
        return unmarkedSum * lastNum!
    }
}
func part1() -> Int {
    guard let contents = try? String(contentsOfFile: filepath)
            .components(separatedBy: separator),
          let numbers = contents.first?
            .components(separatedBy: ",")
            .filter({!$0.isEmpty}) else {
              return 0
          }
    var boards = contents
    boards.remove(at: 0)
    let b = boards.map(Board.init)
    for number in numbers {
        for board in b {
            if board.crossIfExist(value: Int(number)!) {
                return board.calculateScore()
            }
        }
    }
    return 0
}
func part2() -> Int {
    guard let contents = try? String(contentsOfFile: filepath)
            .components(separatedBy: separator),
          let numbers = contents.first?
            .components(separatedBy: ",")
            .filter({!$0.isEmpty}) else {
              return 0
          }
    var boards = contents
    boards.remove(at: 0)
    var boardsIndexes = Set((0..<boards.count))
    let b = boards.map(Board.init)
    for number in numbers {
        for (index, board) in b.enumerated() {
            if boardsIndexes.contains(index), board.crossIfExist(value: Int(number)!) {
                boardsIndexes.remove(index)
                if boardsIndexes.count == 0 {
                    return board.calculateScore()
                }
            }
        }
    }
    return 0
}

print(part1())
print(part2())
