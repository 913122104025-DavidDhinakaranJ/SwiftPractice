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
    var elements: [Element] = []
    mutating func push(_ element: Element) {
        elements.append(element)
    }
    mutating func pop() -> Element? {
        return elements.popLast()
    }
}

extension Stack {
    var top: Element? {
        return elements.last
    }
}


var intStack: Stack<Int> = Stack()
intStack.push(1)
intStack.push(2)

var stringStack: Stack<String> = Stack()
stringStack.push("a")
stringStack.push("b")

//Generic Constraints
func findIndex<U: Equatable>(of value: U, in array: [U]) -> Int? {
    return array.firstIndex(of: value)
}

findIndex(of: 2, in: [1, 2, 3])!

//Where Clause
protocol Container {
    associatedtype Item
    var items: [Item] { get }
}

func findIndex<C: Container>(of value: C.Item, in container: C) -> Int? where C.Item: Equatable {
    return container.items.firstIndex(of: value)
}

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

var intStorage = AnyStorage(IntStorage())
intStorage.store(5)

var stringStorage = AnyStorage(StringStorage())
stringStorage.store("Hello")
