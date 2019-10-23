//: [Previous](@previous)

import Foundation

func measure <T> (_ f: () -> T) -> (result: T, duration: Double) {
    let startTime = CFAbsoluteTimeGetCurrent()
    let result = f()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    return (result, timeElapsed)
}

extension Double {
    var milliSecString: String {
        .init(format: "%.3f ms", self * 1000)
    }

    var microSecString: String {
        .init(format: "%.2f μs", self * 1000000)
    }
}

extension Array where Element == Double {
    var average: Double {
        reduce(0.0) { $0 + $1 } / Double(count)
    }
}

var benchmark1: [Double] = []
var benchmark2: [Double] = []

var f1_equal_f2: (Int, Range<Int>) -> Bool = { num, range in
    func f1(num: Int, range: Range<Int>) -> Bool {
        range.contains(num)
    }

    func f2(num: Int, range: Range<Int>) -> Bool {
        range ~= num
    }

    let r1 = measure { f1(num: num, range: range) }
    let r2 = measure { f2(num: num, range: range) }

    print(num, r1.duration.microSecString, r2.duration.microSecString, separator: "\t\t")
    benchmark1.append(r1.duration)
    benchmark2.append(r2.duration)

    return r1.result == r2.result
}

let result = (0..<100).lazy
    .map { _ in 0..<10000 }
    .map { ((0..<10000).randomElement()!, $0) }
    .allSatisfy(f1_equal_f2)

print(result, benchmark1.average.microSecString, benchmark2.average.microSecString)

//: [Next](@next)
