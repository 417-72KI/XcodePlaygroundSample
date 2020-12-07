//: [Previous](@previous)
let trials = 10
func a() {
    func group(_ a: [Int]) -> [[Int]] {
        guard let x = a.first else { return [] }
        let xs = a.dropFirst()
        let eq: (Int) -> Bool = { $0 == x }
        let r1 = [[x] + xs.prefix(while: eq)]
        let r2 = group([Int](xs.drop(while: eq)))
        return r1 + r2
    }
    measure(trials: trials) {
        group([1,1,1,2,2,3,4,4,4,1,1])
    }.milliSecString
}

func b() {
    func group(_ a: [Int]) -> [[Int]] {
        guard let x = a.first else { return [] }
        let r1 = Array(a.prefix(while: { $0 == x }))
        let r2 = group(Array(a.dropFirst(r1.count)))
        return [r1] + r2
    }
    
    measure(trials: trials) {
        group([1,1,1,2,2,3,4,4,4,1,1])
    }.milliSecString
}

a()
print()
b()

//: [Next](@next)
