//Class
class Car {
    var color: String
    var brand: String
    var model: String
    var year: Int
    var isRunning: Bool = false
    
    init(color: String, brand: String, model: String, year: Int) {
        self.color = color
        self.brand = brand
        self.model = model
        self.year = year
    }
    
    func start() {
        isRunning = true
    }
    
    func stop() {
        isRunning = false
    }
}

//Object
var myCar = Car(color: "Red", brand: "Toyota", model: "Corolla", year: 2020)
myCar.start()
myCar.isRunning
myCar.stop()
