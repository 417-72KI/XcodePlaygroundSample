import Foundation

@MainActor
public protocol CounterType: ObservableObject {
    var count: Int { get }

    init()

    func increment()
}

public class DefaultCounter: CounterType {
    @Published
    public var count = 0

    public required init() {
    }
}

public extension DefaultCounter {
    func increment() {
        // DispatchQueue.main.asyncなどで呼ぶとメインスレッドで動作しない
        print("viewDidLoad", Thread.isMainThread) // => false
        count += 1
    }
}
