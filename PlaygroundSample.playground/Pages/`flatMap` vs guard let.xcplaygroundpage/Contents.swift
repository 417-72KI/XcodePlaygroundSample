//: [Previous](@previous)

import Foundation

var func1: (String?) -> Int? = {
    guard let str = $0 else { return nil }
    return Int(str)
}

var func2: (String?) -> Int? = {
    if let str = $0 {
        return Int(str)
    } else {
        return nil
    }
}

var func3: (String?) -> Int? = { $0.flatMap(Int.init) }

var results = (0..<10000).lazy
    .map(String.init)
    .map { str in (measure { func1(str) }, measure { func2(str) }, measure { func3(str) }) }
    .map { ($0.0.1, $0.1.1, $0.2.1) }

print(results.map { $0.0 }.average.microSecString, results.map { $0.1 }.average.microSecString, results.map { $0.2 }.average.microSecString)

results = (0..<10000).lazy
    .map { _ in "hoge" }
    .map { str in (measure { func1(str) }, measure { func2(str) }, measure { func3(str) }) }
    .map { ($0.0.1, $0.1.1, $0.2.1) }

print(results.map { $0.0 }.average.microSecString, results.map { $0.1 }.average.microSecString, results.map { $0.2 }.average.microSecString)

results = (0..<10000).lazy
    .map { _ in String?.none }
    .map { str in (measure { func1(str) }, measure { func2(str) }, measure { func3(str) }) }
    .map { ($0.0.1, $0.1.1, $0.2.1) }

print(results.map { $0.0 }.average.microSecString, results.map { $0.1 }.average.microSecString, results.map { $0.2 }.average.microSecString)

//: [Next](@next)
