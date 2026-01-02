class TestClass {
    var text: String
    var number: Int
    static let staticText: String = "Static Text"
    
    init(text: String, number: Int) {
        self.text = text
        self.number = number
    }
    
    convenience init() {
        self.init(text: "Hello, World!", number: 0)
    }
    
    deinit {
        print("TestClass deinit")
    }
    
    func testFunction() {
        print(text)
    }
}

do {
    let testClass: TestClass = TestClass(text: "Hello, World!", number: 10)
    testClass.testFunction()
    
    let testClass2: TestClass = testClass  //Pass by reference
    testClass2.number = 20  //This change affects both the variables
    
    print(testClass.number)
    print(testClass2.number)
}

//Inheritance
class ParentClass {
    var text: String
    
    required init(text: String) {
        self.text = text
    }
    
    func printText() {
        print(text)
    }
}

class ChildClass: ParentClass {
    var number: Int
    
    init(text: String, number: Int) {
        self.number = number
        super.init(text: text)
    }
    
    required init(text: String) {
        self.number = 0
        super.init(text: text)
    }
    
    override func printText() {
        print("\(text) - \(number)")
    }
}

let parentObject: ParentClass = ChildClass(text: "Hello")
