//Adding Properties
extension Int {
    var isEven: Bool { return self.isMultiple(of: 2) }
    var isOdd: Bool { return !self.isEven }
    var squared: Self { return self * self }
    static let evenPrime: Self = 2
}
var num: Int = 10
print(num.isEven)
print(num.isOdd)
num.squared

//Adding Methods
extension Int {
    mutating func increment() { self += 1 }
    mutating func decrement() { self -= 1 }
    static func random(in range: ClosedRange<Int>) -> Int {
        let min = range.lowerBound
        let max = range.upperBound
        return Int.random(in: min..<(max + 1))
    }
}
var count: Int = 0
count.increment()
count.decrement()
var randomNum: Int = .random(in: 1...10)

//Adding Subscripts
extension String {
    subscript(index: Int) -> Character? {
        guard index >= 0, index < self.count else { return nil }
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}

let string = "Hello, World!"
print(string[12] ?? "Index Out of Range")

//Adding Nested Types
extension Int {
    enum Kind {
        case positive, negative, zero
    }
    
    var kind: Kind {
        switch self {
        case ..<0: return .negative
        case 0: return .zero
        default: return .positive
        }
    }
}

num.kind

//Adding Initializer for Value Type
extension Int {
    init(range: ClosedRange<Int>) {
        var value: Int = 0
        for num in range {
            value += num
        }
        self = value
    }
}

let sum = Int(range: 1...5)

//Adding Initializer for Class
class Integer {
    var value: Int
    init(value: Int) {
        self.value = value
    }
}

extension Integer {
    //Only convenience initializer can be added in extension
    convenience init?(string: String) {
        guard let v = Int(string) else { return nil }
        self.init(value: v)
    }
}

let intFromString: Integer? = Integer(string: "5")
