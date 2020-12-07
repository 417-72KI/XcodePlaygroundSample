import Foundation

public class Hoge: NSObject {
    @objc public var foo: String
    public let bar: String

    public init(foo: String, bar: String) {
        self.foo = foo
        self.bar = bar
    }
}

public struct Fuga {
    public var foo: String
    public let bar: String

    public init(foo: String, bar: String) {
        self.foo = foo
        self.bar = bar
    }
}

public struct FooBar {
    public var hoge: Hoge
    public var fuga: Fuga
}

public extension FooBar {
    init(from tuple: (Hoge, Fuga)) {
        self.init(hoge: tuple[keyPath: \(Hoge, Fuga).0],
                  fuga: tuple[keyPath: \(hoge: Hoge, fuga: Fuga).fuga])
    }
}

public enum Baz {
    case foo
    case bar
}

public extension Baz {
    var description: String { "baz" }
}
