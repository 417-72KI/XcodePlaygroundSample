//: [Previous](@previous)

import Foundation

struct HogeViewState: ViewState {
    var hoge: String
    var fuga: Int
    var foo: Bool
}

enum HogeViewAction: ViewAction {
    case fetched(String, Int, Bool)
    case hoge(String)
    case fuga(Int)
    case foo
}

extension HogeViewAction {
    static func transform(_ state: HogeViewState, action: HogeViewAction) -> HogeViewState {
        switch action {
        case let .fetched(hoge, fuga, foo):
            return state.mutate(keyPath: \.hoge, value: hoge)
                .mutate(keyPath: \.fuga, value: fuga)
                .mutate(keyPath: \.foo, value: foo)
        case let .hoge(value):
            return state.mutate(keyPath: \.hoge, value: value)
        case let .fuga(value):
            return state.mutate(keyPath: \.fuga, value: value)
        case .foo:
            return state.toggle(keyPath: \.foo)
        }
    }
}

// Before
// extension HogeViewAction {
//     static func transform(_ state: HogeViewState, action: HogeViewAction) -> HogeViewState {
//         var state = state
//         switch action {
//         case let .fetched(hoge, fuga, foo):
//             state.hoge = hoge
//             state.fuga = fuga
//             state.foo = foo
//         case let .hoge(value):
//             state.hoge = value
//         case let .fuga(value):
//             state.fuga = value
//         case .foo:
//             state.foo.toggle()
//         }
//         return state
//     }
// }

let state = HogeViewState(hoge: "", fuga: 0, foo: false)

HogeViewAction.transform(state, action: .hoge("hoge"))

//: [Next](@next)
