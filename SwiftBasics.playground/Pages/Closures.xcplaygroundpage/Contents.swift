//Assigning closure to variable
let myClosure: (String) -> Void = { (name: String) in
    print("Hello, \(name)!")
}
myClosure("World")

//Shorthand rules
let add: (Int, Int) -> Int = { $0 + $1 }
add(3, 4)

//Trailing Closure
func performOperation(a: Int, b: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(a, b)
}

performOperation(a: 3, b: 4) { $0 * $1 }

//Multiple Trailing closures
func processData(string: String, action: (String) -> Void, completion: (String) -> Void) {
    action(string)
    completion(string)
}

processData(string: "Hello, World!") {
    print("Processing \($0)")
} completion: { print("Completed \($0)") }

//Capturing values
let generateCounter: () -> () -> Int = {
    var total: Int = 0
    return {
        total += 1
        return total
    }
}

let counter1 = generateCounter()
counter1() 
counter1() 

let counter2 = generateCounter()
counter2() 
