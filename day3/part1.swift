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
        
        guard let count = lines.first?.count else {
            throw LogicError()
        }
        
        var gammas = Array(repeating: 0, count: count)
        for line in lines {
            for (index, char) in line.enumerated() {
                gammas[index] += char == "0" ? 1 : -1
            }
        }
        
        func joined(array: [Int], comparator: (Int, Int) -> Bool) -> String {
            array
                .map { $0 < 0 ? "1" : "0"}
                .joined(separator: "")
        }
        
        guard
            let gamma = Int(joined(array: gammas, comparator: <), radix: 2),
            let epsilon = Int(joined(array: gammas, comparator: >), radix: 2)
        else { throw LogicError() }
        
        print(gamma * epsilon)
    } catch {
        print("Failed with error: \(error)")
    }
}
