//: [Previous](@previous)

import Foundation
import Combine

// MARK: - Collection(flatten)
run {
    let array: [[String]] = [["hoge", "fuga"], ["foo", "bar"], []]
    print(array.flatMap { $0 })
}

// MARK: - Collection(compactMap)
run {
    let array: [String] = ["https://google.co.jp", "https://yahoo.co.jp", "https://twitter.com", ""]
    print(array.map(URL.init) as [URL?])
    print(array.flatMap(URL.init))
    print(array.compactMap(URL.init))
}

// MARK: - Optional
run {
    let string: String? = "https://google.co.jp"
    print(string.flatMap(URL.init))
}
run {
    let string: String? = nil
    print(string.flatMap(URL.init))
}
// MARK: - Rx
run {

}
// MARK: - Combine(Swift5.1~)
enum HogeError: Error {
    case noString
    case urlParsed
}

run {
    Future<String, HogeError> { promise in
        promise(.success("https://google.co.jp"))
    }
    .flatMap { string in
        Future<URL, HogeError> { promise in
            guard let url = URL(string: string) else { return promise(.failure(.urlParsed)) }
            return promise(.success(url))
        }
    }
    .sink(
        receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("finished")
            case .failure(let error):
                print("error: \(error)")
            }
    },
        receiveValue: { url in print("URL: \(url)") }
    )
}
// MARK: - Result(Swift5~)
run {
    let r1: Result<String, HogeError> = .success("https://google.co.jp")
    r1.flatMap {

    }
    print(r1)
}
//: [Next](@next)
