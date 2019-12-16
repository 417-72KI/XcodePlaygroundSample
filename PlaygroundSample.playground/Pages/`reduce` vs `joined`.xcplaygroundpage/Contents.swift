//: [Previous](@previous)

import Foundation

let characters = ("a"..."z").characters
let str = String((0..<100).compactMap { _ in characters.randomElement() })

let array = (0..<1000).map { _ in str }

var func1: ([String]) -> String = {
    let messages = $0.reduce("") { messages, next in
        messages + "\n" + next
    }
    return messages
}

var func2: ([String]) -> String = { $0.joined(separator: "\n") }

var func3: ([String]) -> String = { $0.reduce(into: "") { $0 += "\n" + $1 } }

let result1 = measure { func1(array) }
let result2 = measure { func2(array) }
let result3 = measure { func3(array) }

print(result1.result == "\n\(result2.result)")
print(result1.result == result3.result)

print(result1.duration, result2.duration, result3.duration)

//: [Next](@next)
