enum Direction {
    case east, west, north, south
}

var dir: Direction = .north
print(dir)

//Switch with enums
switch dir {
case .north:
    print("Moving north")
case .south:
    print("Moving south")
case .east:
    print("Moving east")
case .west:
    print("Moving west")
}

//Enums with raw values
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

print(Planet.earth.rawValue)

//Enums with associated values
enum Transport {
    case car(fuelType: String)
    case train(numberOfWagons: Int)
}

var car: Transport = .car(fuelType: "diesel")
var train: Transport = .train(numberOfWagons: 42)

//Iterate through enums
enum Beverage: CaseIterable {
    case coffee, tea, juice
}

for beverage in Beverage.allCases {
    print(beverage)
}

//Enums with properties
enum Visibility {
    case visible, hidden
    
    var isVisible: Bool {
        switch self {
        case .visible:
            return true
        case .hidden:
            return false
        }
    }
}
let visibilityStatus = Visibility.hidden
print(visibilityStatus.isVisible)

//Enums with methods
enum TrafficLight {
    case red, green, yellow
    
    mutating func changeLight() {
        switch self {
        case .red:
            self = .green
        case .green:
            self = .yellow
        case .yellow:
            self = .red
        }
    }
}
var light: TrafficLight = .red
light.changeLight()
light.changeLight()

//Recursive Enumeration
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, four)

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case .number(let value):
        return value
    case .addition(let lhs, let rhs):
        return evaluate(lhs) + evaluate(rhs)
    case .multiplication(let lhs, let rhs):
        return evaluate(lhs) * evaluate(rhs)
    }
}

evaluate(product)

//Type Subscript
enum NumberWord: Int {
    case one = 1, two, three, four, five, six, seven, eight, nine, ten
    
    static subscript(number: Int) -> NumberWord? {
        return NumberWord(rawValue: number)
    }
}

var seven = NumberWord[7]

