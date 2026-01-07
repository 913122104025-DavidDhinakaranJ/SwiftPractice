protocol Identifiable {
    var id: String { get }
}

protocol Drivable {
    func drive()
}

//Protocol Inheritance
protocol Vehicle: Drivable, Identifiable {
    var name: String { get }
    var speed: Int { get }
}

//Protocol Extension
extension Vehicle {
    var description: String {
        "\(name), \(speed) mph"
    }
}

struct Car: Vehicle {
    var id: String
    var name: String
    var speed: Int
    
    func drive() {
        print("Driving Car")
    }
}

struct Bicycle: Vehicle {
    var id: String
    var name: String
    var speed: Int
    
    func drive() {
        print("Driving Bicycle")
    }
}

let car: Vehicle = Car(id: "C101", name: "Corolla", speed: 60)
let bike: Vehicle = Bicycle(id: "B101", name: "Schwinn", speed: 20)

car.drive()
bike.drive()

print(car.description)
print(bike.description)

//Default Implementation
extension Vehicle {
    func drive() {
        print("Driving Vehicle")
    }
}

struct Plane: Vehicle {
    var id: String
    var name: String
    var speed: Int
}

let plane: Vehicle = Plane(id: "P101", name: "Boeing 737", speed: 500)

plane.drive()

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

func run() {
    let animal = getAnimal()
    animal.makeSound()
}
run()

var mixedAnimal: [some Animal] = [Dog()]
type(of: mixedAnimal)

//Existential(any) - Dynamic Dispatch
var pet: any Animal = Dog()
pet.makeSound()

var mixedPet: [any Animal] = [Dog(), Cat()]
for pet in mixedPet {
    pet.makeSound()
}


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
