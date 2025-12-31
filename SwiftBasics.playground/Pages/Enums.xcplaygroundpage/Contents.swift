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
enum Beverage: String, CaseIterable {
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

