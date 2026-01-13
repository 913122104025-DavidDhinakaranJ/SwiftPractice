//Synthesized Initializers (Value Types)
struct Point {
    var x: Int = 0
    var y: Int = 0
}

let p1 = Point()              //Uses default values
let p2 = Point(x: 5, y: 10)   //Memberwise initializer

//Custom Initializers
class Person {
    var name: String = "Anonymous"
    var age: Int = 0
    
    init(name: String, age: Int) {
        precondition(age >= 0, "Age must be non-negative")
        self.name = name
        self.age = age
    }
}

let person1 = Person(name: "Alice", age: 30)
//let person2 = Person(name: "Bob", age: -5)  //Precondition fails
//let person3 = Person()  //Synthesized initializer is disabled

//Failable Initializers
enum TemperatureUnit: Character {
    case celsius = "C", fahrenheit = "F", kelvin = "K"
    init?(symbol: Character) {
        switch symbol {
        case "C": self = .celsius
        case "F": self = .fahrenheit
        case "K": self = .kelvin
        default: return nil
        }
    }
}

let unit1 = TemperatureUnit(symbol: "C")
let unit2 = TemperatureUnit(symbol: "X")

//Throwing Initializers
enum FileError: Error { case typeMismatch }

struct FileHandler {
    let path: String
    init(path: String) throws {
        guard path.hasSuffix(".txt") else { throw FileError.typeMismatch }
        self.path = path
    }
}

let handler1 = try? FileHandler(path: "data.txt")
let handler2 = try? FileHandler(path: "config.json")

//Overloading initializers
struct Celsius {
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        self.temperatureInCelsius = (fahrenheit - 32) * 5/9
    }
    
    init(fromKelvin kelvin: Double) {
        self.temperatureInCelsius = kelvin - 273.15
    }
    
    init (_ celsius: Double) {
        self.temperatureInCelsius = celsius
    }
}

let temp1 = Celsius(fromFahrenheit: 212)
let temp2 = Celsius(fromKelvin: 373.15)
let temp3 = Celsius(100)

//Class Initializers
//Default Initializer
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}

let item1 = ShoppingListItem()  //Used only when all properties have default values and have no custom initializer

//Initializer Delegation for Value Types - An initializer calling another initializer
struct Fahrenheit {
    var temperatureInFahrenheit: Double
    init(_ fahrenheit: Double) {
        self.temperatureInFahrenheit = fahrenheit
    }
    init(fromKelvin kelvin: Double) {
        self.init((kelvin - 273.15) * 9/5 + 32)
    }
    init(fromCelsius celsius: Double) {
        self.init(celsius * 9/5 + 32)
    }
}

class BaseClass {
    var message: String
    
    init(message: String) {
        self.message = message
    }
    
    //Convenience Initializer - must call self.init
    convenience init() {
        self.init(message: "Hello World!")
    }
}

class DerivedClass: BaseClass {
    var number: Int
    
    //Designated Initializer - must call super.init if the class inherits another class
    init(message: String, number: Int) {
        self.number = number
        super.init(message: message)
    }
    
    //Initializer Overriding
    convenience override init(message: String) {
        self.init(message: message, number: 0)
    }
}

var derived = DerivedClass()
derived = DerivedClass(message: "Hi", number: 5)
derived = DerivedClass(message: "Hi")

class BaseWithFailableInitializer {
    var message: String
    init?(message: String) {
        if message.isEmpty { return nil }
        self.message = message
    }
}

class DerivedWithFailableInitializer: BaseWithFailableInitializer {
    //Override with a nonfailable initializer
    override init(message: String) {
        let safeMessage = message.isEmpty ? "No Message" : message
        super.init(message: safeMessage)!
    }
}

var base = DerivedWithFailableInitializer(message: "")

class RequiredBase {
    let text: String
    
    required init(text: String) {
        self.text = text
    }
}

class RequiredDerived: RequiredBase {
    let number: Int
    
    required init(text: String) {
        self.number = 0
        super.init(text: text)
    }
    
    init(text: String, number: Int) {
        self.number = number
        super.init(text: text)
    }
}

//Property Initializer
struct ChessBoard {
    let boardColors = {
        var temporaryBoard: [[String]] = []
        var isBlack: Bool = false
        for i in 1...8 {
            for j in 1...8 {
                isBlack ? temporaryBoard.append(["BLACK"]) : temporaryBoard.append(["WHITE"])
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        print("Initializing Board Colors")
        return temporaryBoard
    }()
    
    init() {
        print("Initializing Chess Board")
    }
}

let board = ChessBoard()
