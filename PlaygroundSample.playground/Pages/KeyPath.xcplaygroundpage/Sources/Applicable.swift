import Foundation

public protocol Applicable {
}

public extension Applicable where Self: AnyObject {
    @discardableResult
    func apply(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }

    func apply<T>(keyPath: ReferenceWritableKeyPath<Self, T>, value: T) -> Self {
        self[keyPath: keyPath] = value
        return self
    }
}

public extension Applicable {
    func apply<T>(keyPath: WritableKeyPath<Self, T>, value: T) -> Self {
        var newValue = self
        newValue[keyPath: keyPath] = value
        return newValue
    }
}
