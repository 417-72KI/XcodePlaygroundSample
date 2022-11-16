//: [Previous](@previous)

import UIKit
import SwiftUI
import XCPlayground
import PlaygroundSupport

@MainActor
struct HogeView<Counter: CounterType>: View {
    @StateObject var counter: Counter

    var body: some View {
        VStack {
            Text("Hello world!")
            Text("\(counter.count)")
            Button("Increment") {
                counter.increment()
            }
        }
    }
}

@MainActor
final class HogeViewController<Counter: CounterType>: UIHostingController<HogeView<Counter>> {
    let counter: Counter

    init() {
        counter = Counter()
        super.init(rootView: HogeView(counter: self.counter))
    }

    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            await increment()

            print(counter.count)
        }
    }
}

extension HogeViewController {
    func increment() async {
        counter.increment()
    }
}

Task { @MainActor in
    let vc = HogeViewController<DefaultCounter>()

    PlaygroundPage.current.liveView = vc
}

//: [Next](@next)
