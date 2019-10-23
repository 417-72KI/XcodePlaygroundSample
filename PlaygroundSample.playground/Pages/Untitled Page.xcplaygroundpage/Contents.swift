import UIKit
import PlaygroundSupport

func measure <T> (_ f: () -> T) -> (result: T, duration: Double) {
    let startTime = CFAbsoluteTimeGetCurrent()
    let result = f()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    return (result, timeElapsed)
}

extension Double {
    var milliSecString: String {
        .init(format: "%.3f ms", self * 1000)
    }

    var microSecString: String {
        .init(format: "%.2f μs", self * 1000000)
    }
}

final class HogeViewController: UIViewController {
}

let nav = UINavigationController(rootViewController: UIViewController())
nav.viewControllers = (0...100).map { _ in UIViewController() }

let hogeVC = HogeViewController()
nav.viewControllers[nav.viewControllers.count / 2] = hogeVC

var func1: () -> HogeViewController? = {
    nav.viewControllers.first(where: { $0 is HogeViewController }) as? HogeViewController
}

var func2: () -> HogeViewController? = {
    nav.viewControllers.compactMap { $0 as? HogeViewController }.first
}

var func3: () -> HogeViewController? = {
    nav.viewControllers.lazy.compactMap { $0 as? HogeViewController }.first
}

let result1 = measure(func1)
let result2 = measure(func2)
let result3 = measure(func3)

[result1, result2, result3].lazy.map { $0.duration }
    .forEach { print($0.milliSecString) }
