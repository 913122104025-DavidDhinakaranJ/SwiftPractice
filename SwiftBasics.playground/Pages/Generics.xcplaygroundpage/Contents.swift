//Generic Functions
func swap<T>(_ a: inout T, _ b: inout T) {
    (a, b) = (b, a)
}
var x = "Hello, World!"
var y = "Learning Swift is fun!"
swap(&x, &y)
print(x)
print(y)

//Generic Types
struct Stack<Element> {
    private var elements: [Element] = []
    mutating func push(_ element: Element) {
        elements.append(element)
    }
    mutating func pop() -> Element? {
        return elements.popLast()
    }
}

//Extending a Generic Type
extension Stack {
    var top: Element? {
        return elements.last
    }
}

var intStack: Stack<Int> = Stack()
intStack.push(1)
intStack.top
intStack.pop()

var stringStack: Stack<String> = Stack()
stringStack.push("a")
stringStack.top
stringStack.pop()

//Type Constraint
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let intIndex = findIndex(of: 3, in: [1, 2, 3, 4])
let stringIndex = findIndex(of: "b", in: ["a", "b", "c"])

//Associated Types
protocol Container {
    associatedtype Item
    var count: Int { get }
    mutating func append(_ item: Item)
    subscript(_ i: Int) -> Item { get }
}

struct GenericContainer<T>: Container {
    private var items: [T] = []
    var count: Int { items.count }
    mutating func append(_ item: T) {
        items.append(item)
    }
    subscript(i: Int) -> T {
        get {
            return items[i]
        }
        set {
            items[i] = newValue
        }
    }
}

var stringContainer: GenericContainer<String> = GenericContainer()
stringContainer.append("Hello")
stringContainer.count

//Using a Protocol in Its Associated Type’s Constraints
protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item  //Adding Constraints to an Associated Type
    func suffix(startingAt startIndex: Int) -> Suffix
}

extension GenericContainer: SuffixableContainer {
    func suffix(startingAt startIndex: Int) -> GenericContainer {
        var result = GenericContainer()
        for index in startIndex..<items.count {
            result.append(items[index])
        }
        return result
    }
}

var intContainer: GenericContainer<Int> = GenericContainer()
intContainer.append(1)
intContainer.append(2)
intContainer.append(3)
var suffixIntContainer = intContainer.suffix(startingAt: 1)

//Generic Where Clause
func allItemsMatch<C1: Container, C2: Container>(_ container1: C1, _ container2: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable {
    if(container1.count != container2.count) {
        return false
    }
    
    for index in 0..<container1.count {
        if container1[index] != container2[index] {
            return false
        }
    }
    
    return true
}

allItemsMatch(intContainer, suffixIntContainer)

//Extensions with a Generic Where Clause
extension Stack where Element: Equatable {
    func isTop(_ value: Element) -> Bool {
        return top == value
    }
    
    func sum() -> Element where Element: Numeric {  //Contextual Where Clauses
        return elements.reduce(0, +)
    }
}

var stack: Stack<Int> = Stack()
stack.push(3)
stack.isTop(3)
stack.sum()

//Generic Subscripts
extension Container {
    subscript<Indices: Sequence>(_ indices: Indices) -> [Item] where Indices.Iterator.Element == Int {
        var items: [Item] = []
        for index in indices {
            items.append(self[index])
        }
        return items
    }
}

intContainer[[0, 2]]

//Type Erasure
protocol Storage {
    associatedtype Value
    mutating func store(_ value: Value)
    func retrieve() -> Value?
}

struct IntStorage: Storage {
    private var item: Int?
    mutating func store(_ value: Int) { item = value }
    func retrieve() -> Int? { return item }
}

struct StringStorage: Storage {
    private var item: String?
    mutating func store(_ value: String) { item = value }
    func retrieve() -> String? { return item }
}

struct AnyStorage<Value>: Storage {
    private let _store: (Value) -> Void
    private let _retrieve: () -> Value?

    init<S: Storage>(_ storage: S) where S.Value == Value {
        var storage = storage
        self._store = { storage.store($0) }
        self._retrieve = { storage.retrieve() }
    }

    mutating func store(_ value: Value) {
        _store(value)
    }

    func retrieve() -> Value? {
        _retrieve()
    }
}

var intStorage: AnyStorage<Int>
intStorage = AnyStorage(IntStorage())
intStorage.store(5)

var stringStorage: AnyStorage<String>
stringStorage = AnyStorage(StringStorage())
stringStorage.store("Hello")
