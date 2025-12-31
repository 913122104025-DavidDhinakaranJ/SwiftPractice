var name: String? = nil  //optional
name = "User"

//Optional Binding
if let name = name {
    print("Hello, \(name)!")
} else {
    print("Hello, world!")
}

//guard let
func checkUser(_ id: Int?) {
    guard let userID = id else {
        print("Invalid user")
        return
    }
    print("Valid user with ID \(userID)")
}

checkUser(nil)
checkUser(101)

//Nil-Coalescing (Default Value)
var age: Int? = nil
print("Age: \(age ?? 18)")

//optional chaining
let fruits: [String?]? = ["Apple", "Banana", "Cherry"]
let fruit = fruits?.first??.uppercased()

//Implicitly Unwrapped Optional
var name2: String! = nil
name2 = "User"
print(name2.count)

//Optional Pattern in Switch
var grade: Character? = "A"

switch grade {
case .some(let g):
    print("Excellent! (value: \(g))")
case .none:
    print("Not excellent.")
}

switch grade {
case let g?:
    print("Excellent! (value: \(g))")
case nil:
    print("Not excellent.")
}
