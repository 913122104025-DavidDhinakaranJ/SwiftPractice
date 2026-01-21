struct Car {
    let make: String
    init(make: String) {
        self.make = make
    }
    func start() {
        print("\(make) engine started.")
    }
}

struct Driver {
    var name: String
    init(name: String) {
        self.name = name
    }
    func drive(car: Car) {
        car.start()
        print("\(name) is driving the \(car.make)")
    }
}

let myCar = Car(make: "Camry")
let myDriver = Driver(name: "Taylor")
myDriver.drive(car: myCar)
