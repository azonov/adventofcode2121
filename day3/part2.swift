import Foundation

let url = URL(string: "https://adventofcode.com/2021/day/3/input")!
var request = URLRequest(url: url)
request.setValue(
    "session=value",
    forHTTPHeaderField: "Cookie"
)

request.httpShouldHandleCookies = true

struct LogicError: Error {}

Task(priority: .userInitiated) {
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let lines = String(decoding: data, as: UTF8.self)
            .components(separatedBy: "\n")
            .filter{!$0.isEmpty}
        
        func repeats(in lines: [String], index: Int, comparator: (Int, Int) -> Bool) -> Character {
            var repeats: [Character: Int] = [:]
            for line in lines {
                let char = line[line.index(line.startIndex, offsetBy: index)]
                repeats[char, default: 0] += 1
            }
            return comparator(repeats["1"] ?? 0, repeats["0"] ?? 0)
            ? Character("1")
            : Character("0")
        }
        
        func calc(input: [String], comparator: (Int, Int) -> Bool) throws -> Int {
            var lines = input
            for bit in 0..<lines.first!.count {
                let repeats = repeats(in: lines, index: bit, comparator: comparator)
                for lineIndex in (0..<lines.count).reversed() {
                    let line = lines[lineIndex]
                    let char = line[line.index(line.startIndex, offsetBy: bit)]
                    if char != repeats {
                        lines.remove(at: lineIndex)
                        if lines.count < 2 {
                            return Int(lines.first!, radix: 2)!
                        }
                    }
                }
            }
            throw LogicError()
        }
        
        let oxygen = try calc(input: lines, comparator: >=)
        let CO2 = try  calc(input: lines, comparator: <)
        print(oxygen, CO2, oxygen * CO2)
        
    } catch {
        print("Failed with error: \(error)")
    }
}
