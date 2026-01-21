//Single Inheritance
class Vehicle {
    var isDrivable: Bool = true
    func move() { print("Moving...") }
}

//Car inheriting only from Vehicle
class Car: Vehicle {}

var myCar = Car()
myCar.move()
myCar.isDrivable



//Multilevel Inheritance
class Shape {
    var sides: Int
    var area: Double
    var description: String { "A shape with \(sides) sides and an area of \(area)." }
    
    init(sides: Int, area: Double) {
        self.sides = sides
        self.area = area
    }
}

class Quadrilateral: Shape {
    init(area: Double) {
        super.init(sides: 4, area: area)
    }
}

//Square inherits the Shape through Quadrilateral
class Square: Quadrilateral {
    var sideLength: Double
    
    init(sideLength: Double) {
        self.sideLength = sideLength
        super.init(area: sideLength * sideLength)
    }
}

var mySquare = Square(sideLength: 5.0)
mySquare.sideLength
mySquare.area
mySquare.description



//Hierarchial Inheritance - Both Human and Animal Inherits from Living Being
class LivingBeing {
    func breathe() {
        print("Breathing...")
    }
}

class Human: LivingBeing {
    func talk() {
        print("Talking...")
    }
}

class Animal: LivingBeing {
    func makeSound() {
        print("Making a sound...")
    }
}

var myHuman = Human()
myHuman.breathe()
myHuman.talk()

var myAnimal = Animal()
myAnimal.breathe()
myAnimal.makeSound()



//Multiple Inheritance - Not Supported by classes
//Can be implemented using Protocols
class Bird {
    func eat() {
        print("Eating...")
    }
}

protocol Flyable {
    func fly()
}

extension Flyable {
    func fly() {
        print("Flying...")
    }
}

class Parrot: Bird, Flyable {}

var myParrot = Parrot()
myParrot.eat()
myParrot.fly()



//Interface Inheritance
protocol Identifiable {
    var id: String { get }
}

protocol Describable {
    var description: String { get }
}

protocol Namable: Describable {
    var name: String { get }
}

protocol Product: Identifiable, Namable {}

struct Phone: Product {
    var id: String
    var name: String
    var description: String
}

var myPhone = Phone(id: "123", name: "iPhone 12", description: "A smart phone.")
myPhone.id
myPhone.name
myPhone.description