import Foundation

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
        var result = 0
        for try await num in group {
            result += num
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
        var count = 0
        while !Task.isCancelled {
            try await Task.sleep(for: .seconds(1))
            count += 1
            print(count)
        }
    }
    
    Task {
        try await Task.sleep(for: .seconds(6))
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


//Legacy Swift Concurrency(GCD)
//Threads
let thread = Thread {
    print("Executed on custom thread")
}
thread.start()

//Dispatch Queues
DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
    print("Executed on main queue")
}

DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 10) {
    print("Executed on background queue")
}

let serialQueue = DispatchQueue(label: "com.example.serialQueue")
serialQueue.async {
    sleep(5)
    print("Executed on serial queue")
}
serialQueue.async {
    sleep(5)
    print("Executed on serial queue again")
}

let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)
concurrentQueue.async {
    sleep(5)
    print("Executed on concurrent queue")
}
concurrentQueue.async {
    sleep(5)
    print("Executed on concurrent queue again")
}

//Dispatch WorkItem
let workItem = DispatchWorkItem {
    print("Executed a work item")
}
workItem.perform()

//Dispatch Group
let group = DispatchGroup()
group.enter()
DispatchQueue.global().async {
    sleep(5)
    group.leave()
}

group.notify(queue: .main) {
    print("All work is done")
}

//Locks
final class LockedCounter {
    private var count: Int = 0
    private let lock = NSLock()
    
    func increment() {
        lock.lock(); defer { lock.unlock() }
        count += 1
    }
    
    func get() -> Int {
        lock.lock(); defer { lock.unlock() }
        return count
    }
}

let lockedCounter = LockedCounter()
lockedCounter.increment()
lockedCounter.get()

//Semaphore
let limit = DispatchSemaphore(value: 2)
let queue = DispatchQueue.global(qos: .userInitiated)

for i in 0..<10 {
    queue.async {
        limit.wait()
        sleep(1)
        print("Task \(i) started")
        print("Task \(i) finished")
        limit.signal()  
    }
}
