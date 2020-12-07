import Foundation

public func measure<T>(_ f: () -> T) -> (result: T, duration: Double) {
    let startTime = CFAbsoluteTimeGetCurrent()
    let result = f()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    return (result, timeElapsed)
}

public func measure<T>(trials numOfTrials: Int, _ f: () -> T) -> Double {
    let total = (0..<numOfTrials)
        .map { _ in measure(f).duration }
        .do { print($0.milliSecString) }
        .reduce(0.0, +)
    return total / Double(numOfTrials)
}

public extension Double {
    var milliSecString: String { .init(format: "%.3f ms", self * 1000) }
    var microSecString: String { .init(format: "%.2f μs", self * 1000000) }
}

extension Collection {
    @inlinable func `do`(_ body: (Self.Element) throws -> Void) rethrows -> Self {
        try forEach(body)
        return self
    }
}
