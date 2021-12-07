import Foundation

let coordinates = [16,1,2,0,4,2,7,1,2,14]
let minC = coordinates.min()!
let maxC = coordinates.max()!

func part1() -> Int {
    var ans = Int.max
    for i in minC..<maxC {
        var fuel = 0
        for c in coordinates {
            fuel += max(c, i) -  min(c, i)
            if fuel > ans {
                break
            }
        }
        if fuel < ans {
            ans = fuel
        }
    }
    return ans
}

func part2() -> Int {
    var ans = Int.max
    var triang: [Int: Int] = [:]
    var value = 0
    triang[0] = 0
    for i in 1...maxC-minC {
        value += i
        triang[i] = value
    }
    for i in minC..<maxC {
        var fuel = 0
        for c in coordinates {
            let dif = max(c, i) -  min(c, i)
            fuel += triang[dif]!
            if fuel > ans {
                break
            }
        }
        if fuel < ans {
            ans = fuel
        }
    }
    return ans
}

print(part1())
print(part2())
