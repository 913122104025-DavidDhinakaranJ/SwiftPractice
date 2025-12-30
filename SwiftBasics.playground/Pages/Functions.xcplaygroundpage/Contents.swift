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
