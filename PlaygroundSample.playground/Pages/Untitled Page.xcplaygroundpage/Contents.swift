import UIKit
import PlaygroundSupport

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
