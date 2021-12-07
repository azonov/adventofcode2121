import Foundation

let coordinates = [16,1,2,0,4,2,7,1,2,14]
let minCoordinate = coordinates.min()!
let maxCoordinate = coordinates.max()!

func minFuel(valueCalculator: (Int) -> Int) -> Int
{
    (minCoordinate...maxCoordinate)
        .map { value in
            coordinates.reduce(0, { $0 + valueCalculator(abs(value - $1)) })
        }
        .min()!
}

func part1() -> Int {
    minFuel(valueCalculator: { $0 })
}

func part2() -> Int {
    minFuel { $0 * ($0 + 1) / 2 }
}

print(part1())
print(part2())
