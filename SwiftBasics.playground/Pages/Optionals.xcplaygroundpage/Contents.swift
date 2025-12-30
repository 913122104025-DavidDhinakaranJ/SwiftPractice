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

//Unwrapped Optional
let number: Int! = nil

//optional chaining
let fruits: [String] = ["Apple", "Banana", "Cherry"]
let fruit = fruits.first?.uppercased()
