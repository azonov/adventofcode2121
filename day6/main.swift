import Foundation

let filepath = "TestInput.txt"

class Fish: CustomStringConvertible {
    
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
    
    func inc() -> Bool{
        guard value != 0 else {
            value = 6
            return true
        }
        
        value -= 1
        return false
    }
    
    var description: String {
        "\(value)"
    }
}

class FS1 {
    
    private var fish: [Fish]
    
    init(fish: [Fish]) {
        self.fish = fish
    }
    
    func inc() {
        let newCount = fish.filter { $0.inc() }.count
        
        let created = (0..<newCount)
            .map { _ in Fish(value: 8) }
        
        fish.append(contentsOf: created)
    }
    
    var count: Int {
        fish.count
    }
}

class FS2 {
    
    private var counter: [Int: Int] = [:]
    
    init(fish: [Fish]) {
        for i in (0..<9) {
            self.counter[i] = 0
        }
        fish.forEach {
            self.counter[$0.value]! += 1
        }
    }
    
    func inc() {
        let newBabesCount = counter[0]!
        for i in (1..<9) {
            counter[i-1]! = counter[i]!
        }
        counter[6]! += newBabesCount
        counter[8] = newBabesCount
    }
    
    var count: Int {
        counter.values.reduce(0, +)
    }
}

func part1(days: Int) -> Int {
    guard
        let fish = try? String(contentsOfFile: filepath)
            .components(separatedBy: ",")
            .filter({ !$0.isEmpty })
            .compactMap(Int.init)
            .map(Fish.init)
    else { return 0 }
    
    let fs = FS1(fish: fish)
    (1...days).forEach { value in
        fs.inc()
    }
    
    return fs.count
}

func part2(days: Int) -> Int {
    guard
        let fish = try? String(contentsOfFile: filepath)
            .components(separatedBy: ",")
            .filter({ !$0.isEmpty })
            .compactMap(Int.init)
            .map(Fish.init)
    else { return 0 }
    
    let fs = FS2(fish: fish)
    (1...days).forEach { value in
        fs.inc()
    }
    
    return fs.count
}

print(part1(days: 80))
print(part2(days: 256))
