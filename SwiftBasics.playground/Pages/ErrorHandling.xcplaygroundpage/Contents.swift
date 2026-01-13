//Defining error
enum MathError: Error {
    case divisionByZero
    case notANumber
    case unknown
}

let mathError: MathError = .unknown

//throws, try, catch
func divide(_ a: Int, _ b: Int) throws(MathError) -> Int {
    guard b != 0 else { throw MathError.divisionByZero }
    return a / b
}

do {
    let result = try divide(10, 0)
    print(result)
} catch MathError.divisionByZero {
    print("Error: Cannot divide by Zero")
} catch MathError.notANumber {
    print("Error: Not a Number")
} catch MathError.unknown {
    print("Error: Unknown")
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
