//functions
func greet(name: String = "Anonymous") -> String {
    return "Hello, \(name)!"
}

print(greet())

//variadic parameters
func sum(_ numbers: Int...) -> Int {
    return numbers.reduce(0, +)
}

print(sum(1, 2, 5, 10))

//In Out Parameters
func swap(a: inout Int, b: inout Int) {
    let temp = a
    a = b
    b = temp
}

var x = 10, y = 20
swap(&x, &y)
print("x: \(x), y: \(y)")

let sumOfNumbers: (Int...) -> Int = sum  //Assigning a function to a variable
print(sumOfNumbers(1, 2, 3, 4))

//Nested functions
func outerFunction() {
    func innerFunction() {
        print("Hello from the inner function!")
    }
    innerFunction()
}
outerFunction()

print(1...5)

//Assigning function to variables
let swapper: (inout Int, inout Int) -> Void = swap
swapper(&x, &y)
print("x: \(x), y: \(y)")

//Passing functions as arguments
func performOperation(_ a: Int, _ b: Int, _ operation: (Int, Int) -> Int) -> Int {
    return operation(a, b)
}

func add(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiply(_ a: Int, _ b: Int) -> Int {
    return a * b
}

let result1 = performOperation(5, 3, add)
let result2 = performOperation(5, 3, multiply)

//Returning function
func makeAdder() -> (Int, Int) -> Int {
    return (+)
}

let addFunction = makeAdder()
let result3 = addFunction(5, 3)