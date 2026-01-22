//Bitwise Operators
extension UInt8 {
    func toBinaryString() -> String {
        let binaryString = String(self, radix: 2)
        let paddedString = String(repeating: "0", count: 8 - binaryString.count) + binaryString
        return paddedString
    }

}

//Bitwise NOT Operator
let x: UInt8 = 0b00001111
let notX = ~x
print(notX.toBinaryString())

//Bitwise AND Operator
let a: UInt8 = 0b00111111
let b: UInt8 = 0b11111100
let andAB = a & b
print(andAB.toBinaryString())

//Bitwise OR Operator
let orAB = a | b
print(orAB.toBinaryString())

//Bitwise XOR Operator
let xorAB = a ^ b
print(xorAB.toBinaryString())

//Bitwise Left and Right Shift Operators
let shiftedRight = x >> 1
print(shiftedRight.toBinaryString())
let shiftedLeft = x << 1
print(shiftedLeft.toBinaryString())

//Overflow Operators
let minInt8: Int8 = Int8.max &+ 1
let maxInt8: Int8 = Int8.min &- 1

//Custom Operators
precedencegroup ExponentialPrecedence {
    associativity : left
    higherThan : MultiplicationPrecedence
}
infix operator ** : ExponentialPrecedence

extension Int {
    static func ** (lhs: Int, rhs: Int) -> Int {
        if rhs == 0 { return 1 }
        if rhs < 0 { return 0 }
        return (1...rhs).reduce(1) { result, _ in result * lhs }
    }
}

print(5 * 5 ** 3)

//Result Builders
@resultBuilder
struct StringListBuilder {
    static func buildBlock(_ components: [String]...) -> [String] {
        var result = components.flatMap { $0 }
        result.insert("Block:", at: 0)
        return result
    }
    static func buildExpression(_ expression: String) -> [String] {
        ["String:" + expression]
    }
    static func buildExpression(_ expression: Int) -> [String] {
        ["Int: \(expression)"]
    }
    static func buildOptional(_ component: [String]?) -> [String] {
        guard var result = component else { return [] }
        result.insert("Optional:", at: 0)
        return result
    }
    static func buildEither(first component: [String]) -> [String] {
        var result = component
        result.insert("If:", at: 0)
        return result
    }
    static func buildEither(second component: [String]) -> [String] {
        var result = component
        result.insert("Else:", at: 0)
        return result
    }
    static func buildArray(_ components: [[String]]) -> [String] {
        var result = components.flatMap { $0 }
        result.insert("Array:", at: 0)
        return result
    }
    static func buildFinalResult(_ component: [String]) -> String {
        var result = "Result:\n"
        for part in component {
            result.append(part + "\n")
        }
        return result
    }
}

func makeList(@StringListBuilder _ builder: () -> String) -> String {
    builder()
}

let includeMaybe: Bool = true
let list = makeList {
    "Hello"
    "World"

    if includeMaybe {
        "Maybe"
    }
    
    for i in 1...3 {
        "Item \(i)"
    }

    if Bool.random() {
        "Random A"
    } else {
        "Random B"
    }
    
    switch(Int.random(in: 0..<3)) {
        case 0: "Switch 0"
        case 1: "Switch 1"
        case 2: "Switch 2"
        default: "Switch Default"
    }

    42
}

print(list)
