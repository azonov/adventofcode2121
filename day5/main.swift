import Foundation
let separator = " -> "
let filepath = "Input.txt"
struct Coordinates: Hashable {
    var x: Int
    var y: Int
    
    init(rawValue: String) {
        let comp = rawValue.components(separatedBy: ",")
        guard
            comp.count == 2, let first = comp.first, let last = comp.last,
            let firstInt = Int(first), let lastInt = Int(last)
        else {
            fatalError()
        }
        
        x = firstInt
        y = lastInt
    }
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

class Field {
    private var vents: [Coordinates: Int] = [:]
    
    func handle(coordinates: (start: Coordinates, end: Coordinates)) {
        let lines = generateLine(from: coordinates)
        for line in lines {
            vents[line, default: 0] += 1
        }
    }
    
    private func generateLine(from coordinates: (start: Coordinates, end: Coordinates)) -> [Coordinates] {
        if coordinates.start.x == coordinates.end.x {
            return (min(coordinates.start.y, coordinates.end.y)...max(coordinates.start.y, coordinates.end.y))
                .map({ Coordinates(x: coordinates.start.x, y: $0) })
        } else if coordinates.start.y == coordinates.end.y {
            return (min(coordinates.start.x, coordinates.end.x)...max(coordinates.start.x, coordinates.end.x))
                .map({ Coordinates(x: $0, y: coordinates.start.y) })
        } else {
            let h = coordinates.start.x - coordinates.end.x
            let v = coordinates.start.y - coordinates.end.y
            let xDif = h > 0 ? -1 : 1
            let yDif = v > 0 ? -1 : 1
            var result: [Coordinates] = []
            var coordinate = coordinates.start
            result.append(coordinate)
            while coordinate != coordinates.end {
                coordinate = Coordinates(x: coordinate.x + xDif, y: coordinate.y + yDif)
                result.append(coordinate)
            }
            return result
        }
    }
    
    func calculateLeastTwoLinesOverlap() -> Int {
        vents.values.filter { $0 > 1 }.count
    }
}

func part1() -> Int {
    guard
        let contents = try? String(contentsOfFile: filepath)
            .components(separatedBy: "\n")
            .filter({ !$0.isEmpty })
            .map({ $0.components(separatedBy: separator) })
            .map({ (Coordinates(rawValue: $0.first!), Coordinates(rawValue: $0.last!)) })
    else { return 0 }
    let coordinates = contents.filter { (lhc, rhc) in lhc.x  == rhc.x || lhc.y == rhc.y }
    let field = Field()
    for coordinate in coordinates {
        field.handle(coordinates: coordinate)
    }
    return field.calculateLeastTwoLinesOverlap()
}

func part2() -> Int {
    guard
        let contents = try? String(contentsOfFile: filepath)
            .components(separatedBy: "\n")
            .filter({ !$0.isEmpty })
            .map({ $0.components(separatedBy: separator) })
            .map({ (Coordinates(rawValue: $0.first!), Coordinates(rawValue: $0.last!)) })
    else { return 0 }
    let coordinates = contents
    let field = Field()
    for coordinate in coordinates {
        field.handle(coordinates: coordinate)
    }
    return field.calculateLeastTwoLinesOverlap()
}

print(part1())
print(part2())
