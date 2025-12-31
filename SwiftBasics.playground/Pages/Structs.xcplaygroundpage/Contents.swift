struct TestStructure {
    var text: String
    var number: Int
    
    init(text: String, number: Int) {
        self.text = text
        self.number = number
    }
    
    func printText() {
        print(text)
    }
    
    mutating func incrementNumber() {
        number += 1
    }
}

let test1 = TestStructure(text: "Hello, World!", number: 20)
var test2 = test1                // Pass by value
test2.text = "Goodbye, World!"
print(test1.text, test2.text)  

//Failable Initializer
struct User {
    let username: String
    init?(username: String) {
        guard !username.isEmpty else { return nil }
        self.username = username
    }
}

let user1 = User(username: "Alice")
let user2 = User(username: "")
