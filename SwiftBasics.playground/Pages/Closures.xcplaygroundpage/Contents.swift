import Foundation

//Assigning closure to variable
let myClosure = { (name: String) in
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

//Escaping Closures and Completion Handlers
func fetchUser(completion: @escaping (String) -> Void) {
    print("Start fetching...")
    
    DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
        let username = "Steve Jobs"
        print("Data received. Calling completion.")
        completion(username)
    }
}

print("Calling function")
fetchUser { name in
    print("User is: \(name)")
}
print("Function returned")

var completionHandlers: [() -> Void] = []

@MainActor
func addHandler(_ handler: @escaping () -> Void) {
    completionHandlers.append(handler)
}

addHandler {
    print("Hello from background!")
}

addHandler {
    print("Hello from main thread!")
}

completionHandlers.forEach { $0() }

//Autoclosures
func evaluate(completion: @autoclosure () -> Int, if condition: @autoclosure () -> Bool) {
    if condition() {
        print(completion())
    }
}

evaluate(completion: 5 * 10, if: 5 < 10)
