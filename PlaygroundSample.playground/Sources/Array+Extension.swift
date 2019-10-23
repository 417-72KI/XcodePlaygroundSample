import Foundation

public extension Array where Element == Double {
    var average: Double { reduce(0.0) { $0 + $1 } / Double(count) }
}
