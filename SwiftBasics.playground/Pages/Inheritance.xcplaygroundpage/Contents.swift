//Single Inheritance
class Vehicle {
    func move() { print("Moving...") }
}

class Car: Vehicle {
    override func move() { print("Driving...") }
}

//Multilevel Inheritance
class Audi: Car {
    override func move() { print("Driving an Audi...") }
}

//Hierarchial Inheritance
class Shape {
    func area() -> Double { 0.0 }
}

class Circle: Shape {
    var r: Double = 1.0
    override func area() -> Double { .pi * r * r }
}

class Square: Shape {
    var s: Double = 1.0
    override func area() -> Double { s * s }
}

//Multiple Inheritance - Not Supported by classes

//static Vs class
class Base {
    class func kind() -> String { "Base" }  //class - overridable
    static func utility() {}                //static - not overridable
    final func baseOnly() {}                //final - not overridable
    var value: Int { 0 }                    //computed property
}

class Derived: Base {
    override class func kind() -> String { "Derived" }
    override var value: Int { 1 }
}
