//Compile-Time Polymorphism
//Method Overloading
class Calculator {
    func sum(_ numbers: Int...) -> Int {
        return numbers.reduce(0, +)
    }
    
    func sum(_ numbers: Double...) -> Double {
        return numbers.reduce(0.0, +)
    }
}

let calc = Calculator()
print(calc.sum(1, 2, 3)) 
print(calc.sum(1.5, 2.5, 3.5)) 

//Operator Overloading
struct Vector {
    var x: Double
    var y: Double
    
    static func + (lhs: Vector, rhs: Vector) -> Vector {
        return Vector(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

let vector1 = Vector(x: 1, y: 2)
let vector2 = Vector(x: 3, y: 4)
let resultVector = vector1 + vector2



//Runtime Polymorphism
//Class Based Polymorphism
class Vehicle {
    func drive() {
        print("Driving a vehicle")
    }
}

class Car: Vehicle {
    override func drive() {
        print("Driving a car")
    }
}

class Bike: Vehicle {
    override func drive() {
        print("Driving a bike")
    }
}

func drive(vehicle: Vehicle) {
    vehicle.drive()
}

drive(vehicle: Car())
drive(vehicle: Bike())

//Protocol Based Polymorphism
protocol Shape {
    var area: Double { get }
}

class Circle: Shape {
    var radius: Double
    var area: Double { return .pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}

class Rectangle: Shape {
    var width: Double
    var height: Double
    var area: Double { return width * height }
    init(width: Double, height: Double) { self.width = width; self.height = height }
}

func printArea(of shape: any Shape) {
    print("The area is \(shape.area)")
}

printArea(of: Circle(radius: 3))
printArea(of: Rectangle(width: 4, height: 5))
