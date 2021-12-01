struct Day1 {
    
    /// Count the number of times a depth measurement increases from the previous measurement. (There is no measurement before the first measurement.) In the example above, the changes are as follows:
    /// 199 (N/A - no previous measurement)
    /// 200 (increased)
    /// 208 (increased)
    /// 210 (increased)
    /// 200 (decreased)
    /// 207 (increased)
    /// 240 (increased)
    /// 269 (increased)
    /// 260 (decreased)
    /// 263 (increased)
    /// In this example, there are 7 measurements that are larger than the previous measurement.
    /// How many measurements are larger than the previous measurement?
    static func part1(input: [Int]) -> Int{
        var counter = 0
        for i in 1..<input.count {
            if input[i] > input[i-1] {
                counter += 1
            }
        }
        return counter
    }
    
    /// Start by comparing the first and second three-measurement windows. The measurements in the first window are marked A (199, 200, 208); their sum is 199 + 200 + 208 = 607. The second window is marked B (200, 208, 210); its sum is 618. The sum of measurements in the second window is larger than the sum of the first, so this first comparison increased.
    /// Your goal now is to count the number of times the sum of measurements in this sliding window increases from the previous sum.
    static func part2(input: [Int]) -> Int {
        var counter = 0
        for i in 2..<input.count-1 {
            let sum1 = input[i-2] + input[i-1] + input[i]
            let sum2 = input[i-1] + input[i] + input[i + 1]
            
            if sum2 > sum1 {
                counter += 1
            }
        }
        return counter
    }
}


let answer1 = Day1.part1(input: [199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
let answer2 = Day1.part2(input: [199, 200, 208, 210, 200, 207, 240, 269, 260, 263])

print(answer1)
print(answer2)
