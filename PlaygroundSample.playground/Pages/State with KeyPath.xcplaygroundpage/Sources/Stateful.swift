import Foundation

public protocol ViewState {
}

public extension ViewState {
    func mutate<T>(keyPath: WritableKeyPath<Self, T>, value: T) -> Self {
        var new = self
        new[keyPath: keyPath] = value
        return new
    }

    func toggle(keyPath: WritableKeyPath<Self, Bool>) -> Self {
        let current = self[keyPath: keyPath]
        return mutate(keyPath: keyPath, value: !current)
    }
}

public protocol ViewAction {
    associatedtype State: ViewState

    /// `Reducer.reduce`の簡略版
    static func transform(_ state: State, action: Self) -> State
}
