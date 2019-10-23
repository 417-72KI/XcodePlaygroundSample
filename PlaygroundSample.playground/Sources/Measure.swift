import Foundation

public func measure <T> (_ f: () -> T) -> (result: T, duration: Double) {
    let startTime = CFAbsoluteTimeGetCurrent()
    let result = f()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    return (result, timeElapsed)
}

public extension Double {
    var milliSecString: String { .init(format: "%.3f ms", self * 1000) }
    var microSecString: String { .init(format: "%.2f μs", self * 1000000) }
}
