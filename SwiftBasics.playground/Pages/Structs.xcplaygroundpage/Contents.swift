struct TestStructure {
    var text: String
    static let anotherText: String = "Static Text"
    
    func printText() {
        print(text)
    }
}

let test1 = TestStructure(text: "Hello, World!")
var test2 = test1                // Pass by value
test2.text = "Goodbye, World!"
print(test1.text, test2.text)

//Failable Initializer
struct User {
    let username: String
    init?(username: String) {
        guard !username.isEmpty else { return nil }
        self.username = username
    }
}

let user1 = User(username: "Alice")
let user2 = User(username: "")

//Computed Property - computes the value whenever it is read.
struct Point {
    var x: Int
    var y: Int
    var distanceFromOrigin: Double {
        let a = Double(x)
        let b = Double(y)
        return (a*a + b*b).squareRoot()
    }
}

let point = Point(x: 4, y: 3)
print(point.distanceFromOrigin)

//Property Observers - only for stored properties
//willSet = Before changing value, didSet - After changing value
struct Task {
    var title: String {
        willSet {
            print("Task title will change from \(title) to \(newValue)")
        }
        didSet {
            print("Task title changed from \(oldValue) to \(title)")
        }
    }
}

var task = Task(title: "Hello")
task.title = "Goodbye"

//Mutating Methods - Used only on variable instances
struct Counter {
    var count: Int = 0
    
    mutating func increment() {
        count += 1
    }
}

var counter1 = Counter()
counter1.increment()

//Lazy Property - Computes and stores data on the first time it gets read
struct DataManager {
    lazy var data: String = {
        print("Preparing data...")
        return "Sample Data"
    }()
}

var dataManager = DataManager()
dataManager.data
