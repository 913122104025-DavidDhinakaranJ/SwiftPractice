//async and await
func performTask(id: Int) async -> String {
    try? await Task.sleep(for: .seconds(id))
    return "Task\(id) Completed"
}

Task {
    let result = await performTask(id: 0)
    print(result)
}

print("Another Task Started")

//Asynchronous Sequences
let numbers = [1, 2, 3, 4, 5]
let squaredNumbers = AsyncStream<Int> { continuation in
    Task {
        for number in numbers {
            try! await Task.sleep(for: .seconds(1))
            continuation.yield(number * number)
        }
        continuation.finish()
    }
}

Task {
    for await number in squaredNumbers {
        print(number)
    }
}

//Calling Asynchronous Functions in Parallel
Task {
    async let result1 = performTask(id: 1)
    async let result2 = performTask(id: 2)
    await print(result1)
    await print(result2)
}

//Structured Concurrency
//Task Groups
Task {
    await withTaskGroup(of: String.self) { group in
        for id in 3...5 {
            group.addTask {
                await performTask(id: id)
            }
        }
        
        for await result in group {
            print(result)
        }
    }
}

//Task Cancellation
let sumOfSquaresTask = Task {
    try await withThrowingTaskGroup(of: Int.self) { group in
        for num in 1...10 {
            group.addTaskUnlessCancelled {
                try await Task.sleep(for: .seconds(num))
                return num * num
            }
        }
        var result: Int128 = 0
        for try await num in group {
            result &+= Int128(num)
        }
        return result
    }
}

Task {
    try! await Task.sleep(for: .seconds(6))
    sumOfSquaresTask.cancel()
}

Task {
    do {
        let total = try await sumOfSquaresTask.value
        print("Total: \(total)")
    } catch is CancellationError {
        print("Task was cancelled successfully.")
    }
}

//Unstructured Concurrency
func load() {
    //This task continues running even after load() returns.
    let task = Task {
        while !Task.isCancelled {
            try await Task.sleep(for: .seconds(1))
            print("Working...")
        }
    }
    
    Task {
        try await Task.sleep(for: .seconds(5))
        task.cancel()
    }
}

load()

//The Main Actor
@MainActor
func performMainActorTask() async {
    print("This is executed in the main actor context")
}

Task {
    await performMainActorTask()
}

@MainActor
protocol MainActorProtocol {}

struct MainActorStructure: MainActorProtocol {}  //Implicitly @MainActor

//Actors
actor Counter {
    var count: Int = 0
    let by: Int = 2
    
    func increment() {
        count += by
    }
    
    func getCount() -> Int {
        return count
    }
}

var counter = Counter()
counter.by
Task {
    await counter.increment()
    await counter.getCount()
}

//Global Actors
@globalActor
actor GlobalCounter: GlobalActor {
    static let shared = Counter()
}

Task { @GlobalCounter in
    await GlobalCounter.shared.increment()
    await GlobalCounter.shared.getCount()
}
