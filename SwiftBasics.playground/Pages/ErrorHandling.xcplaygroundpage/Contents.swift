//Defining error
enum MathError: Error {
    case divisionByZero
    case notANumber(value: any Sendable)
    case unknown
}

let mathError: MathError = .unknown

//throwing function
func divide(_ a: Int, _ b: Int) throws(MathError) -> Int {
    guard b != 0 else { throw MathError.divisionByZero }
    return a / b
}

do {
    let result = try divide(10, 2)
    print(result)
} catch MathError.divisionByZero {
    print("Error: Cannot divide by Zero")
} catch MathError.notANumber(let value) {
    print("Error: Not a Number \(value)")
} catch MathError.unknown {
    print("Error: Unknown")
}

//throwing initializer
struct Divider {
    var dividend: Int
    var divisor: Int
    init (dividend: Int, divisor: Int) throws {
        guard divisor != 0 else { throw MathError.divisionByZero }
        self.dividend = dividend
        self.divisor = divisor
    }
}

do {
    let divider = try Divider(dividend: 10, divisor: 2)
    print("Dividend: \(divider.dividend), Divisor: \(divider.divisor)")
} catch MathError.divisionByZero {
    print("Error: Cannot divide by Zero")
} catch {
    print("An unexpected error occurred: \(error).")
}

//Optional try
let optionalResult = try? divide(10, 0)
print(optionalResult ?? "No Value")

let optionalResult2 = try! divide(10, 2)
print(optionalResult2)

//rethrows
func execute(_ task: () throws -> Void) rethrows {
    try task()
}

execute { print("Division") }

do {
    try execute { print(try divide(10, 0)) }
} catch {
    print("Error: \(error)")
}
