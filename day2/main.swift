import Foundation

let url = URL(string: "https://adventofcode.com/2021/day/2/input")!
var request = URLRequest(url: url)
request.setValue(
    "session=value",
    forHTTPHeaderField: "Cookie"
)

request.httpShouldHandleCookies = true

request.timeoutInterval = 2
var depth1 = 0
var horizontal1 = 0
var depth2 = 0
var horizontal2 = 0
var aim2 = 0

enum Command: String {
    case down
    case up
    case forward
}

Task(priority: .userInitiated) {
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        
        String(decoding: data, as: UTF8.self)
            .components(separatedBy: "\n")
            .filter { $0.count > 3 }
            .map { $0.components(separatedBy: " ") }
            .compactMap({ arr -> (Command, Int)? in
                guard
                    let first = arr.first,
                    let command = Command(rawValue: first),
                    let last = arr.last,
                    let amount = Int(last) else {
                        assertionFailure()
                        return nil
                    }
                return (command, amount)
            })
            .map({ (command, amount) -> (Command, Int) in
                switch command {
                case .down:
                    depth1 += amount
                case .up:
                    depth1 -= amount
                case .forward:
                    horizontal1 += amount
                }
                return (command, amount)
            })
            .forEach({ (command, amount) in
                switch command {
                case .down:
                    aim2 += amount
                case .up:
                    aim2 -= amount
                case .forward:
                    horizontal2 += amount
                    depth2 += aim2 * amount
                }
            })
        print("Part 1 answer: \(horizontal1 * depth1)")
        print("Part 2 answer: \(horizontal2 * depth2)")
    } catch {
        print("Request failed with error: \(error)")
    }
}
