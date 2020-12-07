//: [Previous](@previous)
let hogeFoo: ReferenceWritableKeyPath<Hoge, String> = \.foo
let hogeBar = \Hoge.bar

let hoge = Hoge(foo: "foo", bar: "bar")

// old-type keyPath access
let foo = hoge.value(forKeyPath: #keyPath(Hoge.foo))
print(type(of: foo))
//print(#keyPath(Fuga.bar))

print(hoge.foo) // foo
hoge[keyPath: hogeFoo] = "hoge-foo"
print(hoge.foo) // hoge-foo
//hoge[keyPath: hogeBar] = "bar"

let fugaFoo: WritableKeyPath<Fuga, String> = \.foo
let fugaBar = \Fuga.bar

var fuga = Fuga(foo: "foo", bar: "bar")

print(fuga.foo) // foo
fuga[keyPath: fugaFoo] = "fuga-foo"
print(fuga.foo) // fuga-foo
//fuga[keyPath: fugaBar] = "bar"

let hogeFuga = (hoge, fuga)

let hogeKeyPath = \(Hoge, Fuga).0
let fugaKeyPath = \(hoge: Hoge, fuga: Fuga).fuga

hogeFuga[keyPath: hogeKeyPath]
hogeFuga[keyPath: fugaKeyPath]

let fooBar = FooBar(from: hogeFuga)

let fooBarHogeFoo = (\FooBar.hoge).appending(path: \Hoge.foo)

print(fooBar.hoge.foo)
fooBar[keyPath: fooBarHogeFoo] = "foo-bar-hoge-foo"
print(fooBar.hoge.foo)

let fooBarFugaFoo = (\FooBar.fuga).appending(path: \Fuga.foo)
//fooBar[keyPath: fooBarFugaFoo] = "foo-bar-fuga-foo"

//let invalidKeyPath = (\FooBar.hoge).appending(path: fugaFoo)

let baz = \Baz.description

// MARK: -

struct Department {
    var name: String
    var member: [Person]
}

extension Department {
    var boss: Person {
        member.min(by: \.id)!
    }
}

struct Person {
    var id: Int
    var name: String
}

let departments: [Department] = [
    .init(name: "General Affairs Department",
          member: [
            .init(id: 3, name: "Bob"),
            .init(id: 1, name: "Emma")
    ]),
    .init(name: "Development Department",
          member: [
            .init(id: 4, name: "Amelia"),
            .init(id: 2, name: "George")
    ])
]

// Before
departments.flatMap { $0.member }
    .map { $0.name }
departments.map { $0.boss }
    .map { $0.name }

// After
departments.flatMap(\.member)
    .map(\.name)
departments.map(\.boss)
    .map(\.name)

let bossKeyPath = \Department.boss
let nameKeyPath = \Person.name
let bossNameKeyPath = bossKeyPath.appending(path: nameKeyPath)

//departments.map(bossKeyPath)
//    .map(nameKeyPath)

//departments.map(bossNameKeyPath)

let trials = 1000
measure(trials: trials) {
    departments.flatMap { $0.member }
        .map { $0.name }
}.milliSecString

measure(trials: trials) {
    departments.flatMap(\.member)
        .map(\.name)
}.milliSecString

measure(trials: trials) {
    departments.lazy
        .flatMap { $0.member }
        .map { $0.name }
}.milliSecString

measure(trials: trials) {
    departments.lazy
        .flatMap(\.member)
        .map(\.name)
}.milliSecString

//: [Next](@next)
