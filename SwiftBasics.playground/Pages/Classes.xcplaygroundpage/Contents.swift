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
    TestClass.staticText
    
    let testClass2: TestClass = testClass  //Pass by reference
    testClass2.number = 20  //This change affects both the variables
    
    print(testClass.number)
    print(testClass2.number)
}

//Inheritance
class ParentClass {
    var text: String
    var number: Int
    
    required init(text: String) {
        self.text = text
        self.number = 0
    }
    
    func printText() {
        print(text)
    }
}

class ChildClass: ParentClass {
    override var number: Int {
        didSet {
            print("Number changed from \(oldValue) to \(number)")
        }
    }
    
    init(text: String, number: Int) {
        super.init(text: text)
        self.number = number
    }
    
    required init(text: String) {
        super.init(text: text)
    }
    
    override func printText() {
        print("\(text) - \(number)")
    }
}

let parentObject: ParentClass = ChildClass(text: "Hello")

//Type Property and Method
//class keyword can be used on methods and computed properties which has to be overridden in subclass
class LevelTracker {
    nonisolated(unsafe) static var highestUnlockedLevel: Int = 1
    var currentLevel: Int = 1
    
    class func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    func advance(to level: Int) {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
        } else {
            print("Level \(level) is locked.")
        }
    }
}

LevelTracker.unlock(10)
LevelTracker.highestUnlockedLevel
LevelTracker.isUnlocked(5)
