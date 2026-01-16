//Property Requirement
protocol Identifiable {
    var id: String { get }
}

//Method Requirement
protocol Drivable {
    func drive()
    mutating func accelerate()
}

//Protocol Inheritance
protocol Vehicle: Drivable, Identifiable {
    var name: String { get }
    var speed: Int { get }
    static var maxSpeed: Int { get }
    static func getType() -> String
}

//Protocol Extension
extension Vehicle {
    var description: String {
        "\(name), \(speed) mph"
    }
}

//Protocol Conformance
struct Car: Vehicle {
    static let maxSpeed: Int = 180
    var id: String
    var name: String
    var speed: Int
    func drive() {
        print("Driving Car")
    }
    static func getType() -> String {
        "Car"
    }
    mutating func accelerate() {
        speed += 10
    }
}

var vehicle: any Vehicle = Car(id: "C101", name: "Corolla", speed: 60)
vehicle.drive()
print(vehicle.description)

//Default Implementation
extension Vehicle {
    func drive() {
        print("Driving Vehicle")
    }
    static func getType() -> String {
        "Vehicle"
    }
}

class Plane: Vehicle {
    static let maxSpeed: Int = 300
    var id: String
    var name: String
    var speed: Int
    init(id: String, name: String, speed: Int) {
        self.id = id
        self.name = name
        self.speed = speed
    }
    func accelerate() {
        speed += 30
    }
}

var plane: Plane = Plane(id: "P101", name: "Boeing 737", speed: 500)
vehicle = plane as Vehicle
vehicle.accelerate()

vehicle.drive()
Plane.getType()

//Initializer Requirements
protocol SomeProtocol {
    init(someParameter: Int)
}

class someClass: SomeProtocol {
    //Can be implemented as either designated or convenience initializer
    required init(someParameter: Int) {}  //final class doesn't need 'required' keyword
}

class someSuperClass {
    init(someParameter: Int) {}
}

class someSubClass: someSuperClass, SomeProtocol {
    required override init(someParameter: Int) {  //Needs override keyword here to override initializer from super class
        super.init(someParameter: someParameter)
    }
}

//Adding Protocol Conformance with an Extension
struct Train {
    var speed: Int
    
    mutating func accelerate() {
        speed += 50
    }
}

extension Train: Drivable {
    func drive() {
        print("Driving Train")
    }
}

//Adopting a Protocol Using a Synthesized Implementation - works only if all the properties in that type conforms to that protocol
struct User: Equatable, Hashable, Codable {  //Equatable and Hashable cannot be synthesized for classes
    let id: Int
    let name: String
}

var user1 = User(id: 1, name: "AAA")
var user2 = User(id: 1, name: "AAA")
user1 == user2    //Synthesized '==' compares all stored properties in declaration order

//Implicit Conformance to a Protocol - Copyable, Sendable - for value types, BitwiseCopyable - for struct / enum containing only other BitwiseCopyable types.
//Suppressing implicit conformance
struct NonCopyable: ~Copyable {}
var nonCopyableVar = NonCopyable()
//var anotherNonCopyableVar = nonCopyableVar  //It throws error as the struct does not conform to Copyable

//Class-Only Protocols
protocol SomeClassOnlyProtocol: AnyObject {}
//struct ConformingToClassOnlyProtocol : SomeClassOnlyProtocol{}  //It will throw an error

//Protocol Composition
func service(_ item: Identifiable & Drivable) {
    print("Servicing item with id: \(item.id)")
    item.drive()
}

service(Car(id: "C001", name: "Toyota", speed: 60))
service(Plane(id: "P101", name: "Boeing 737", speed: 500))

//Delegation Pattern
//The Contract
protocol WeatherViewDelegate: AnyObject {
    func didTapRefresh()
    func didSelectCity(_ city: String)
}

//The Delegator
class WeatherView {
    weak var delegate: WeatherViewDelegate?
    
    func userTappedRefreshButton() {
        print("View: User tapped refresh button. Calling delegate...")
        delegate?.didTapRefresh()
    }
    
    func userSelectedCity(name: String) {
        print("View: User selected \(name). Calling delegate...")
        delegate?.didSelectCity(name)
    }
}

//The Delegate
class WeatherController: WeatherViewDelegate {
    let myView = WeatherView()
    
    init() {
        myView.delegate = self
    }
    
    func didTapRefresh() {
        print("Controller: User tapped refresh. Fetching new weather data from API...")
    }
    
    func didSelectCity(_ city: String) {
        print("Controller: User selected \(city). Navigating to city details...")
    }
}

let controller = WeatherController()
controller.myView.userTappedRefreshButton()
controller.myView.userSelectedCity(name: "New York")


//Opaque and Boxed Protocol Types
//Opaque(some) - Static Dispatch
protocol Animal {
    func makeSound()
}

struct Dog: Animal {
    var isHappy: Bool = true
    func makeSound() { print("Woof!") }
}

struct Cat: Animal {
    var isNaughty: Bool = true
    func makeSound() { print("Meow!") }
}

func getAnimal() -> some Animal {
    return Dog()
}

let animal = getAnimal()
animal.makeSound()

//Existential(any) - Dynamic Dispatch
var pet: any Animal = Dog()
pet.makeSound()

var anyPets: [any Animal] = [Dog(), Cat()]
for pet in anyPets {
    pet.makeSound()
}
