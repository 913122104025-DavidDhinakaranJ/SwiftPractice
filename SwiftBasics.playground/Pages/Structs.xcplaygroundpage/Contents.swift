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
    
    static func +(lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
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

//Type Property and method
struct LevelTracker {
    nonisolated(unsafe) static var highestUnlockedLevel: Int = 1
    var currentLevel: Int = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    mutating func advance(to level: Int) {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
        } else {
            print("Level \(level) is locked.")
        }
    }
}

LevelTracker.unlock(10)
LevelTracker.highestUnlockedLevel
LevelTracker.isUnlocked(5)

//Property Wrappers
@propertyWrapper
struct HighScore {
    private var number: Int
    private(set) var projectedValue: Bool
    var wrappedValue: Int {
        get { number }
        set {
            if(newValue > number) {
                projectedValue = true
                number = newValue
            } else {
                projectedValue = false
            }
        }
    }
    
    init() {
        self.number = 0;
        self.projectedValue = false
    }
}

struct Player {
    @HighScore var score: Int
    
    func isHighScore() -> Bool {
        return $score
    }
}

var player = Player()
player.score = 100
player.isHighScore()
player.score = 50
player.isHighScore()

print(player.score)

//Subscript
struct Matrix {
    var rows: Int, columns: Int
    var grid: [Int]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.grid = Array(repeating: 0, count: rows * columns)
    }
    
    subscript(row: Int, column: Int) -> Int {
        get {
            return grid[(row * columns) + column]
        }
        set {
            grid[(row * columns) + column] = newValue
        }
    }
    
    func display() {
        for i in 0..<rows {
            for j in 0..<columns {
                print("\(self[i, j])", terminator: " ")
            }
            print()
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 0] = 0
matrix[0, 1] = 1
matrix[1, 0] = 2
matrix[1, 1] = 3
matrix.display()

//Nested types
struct Card {
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
    }
    
    let rank: Rank
    let suit: Suit
}

let spadeKing = Card(rank: .king, suit: .spades)
