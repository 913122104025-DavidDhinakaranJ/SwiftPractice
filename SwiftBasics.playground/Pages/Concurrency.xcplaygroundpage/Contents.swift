import Foundation

DispatchQueue.global().async {
    print("Task Executed Asynchronously")
}

//Queues
let serialQueue = DispatchQueue(label: "com.example.serialQueue")
let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)

serialQueue.async {
    print("Task Executed on Serial Queue")
}

concurrentQueue.async {
    print("Task Executed on Concurrent Queue")
}

//Race Condition - can be avoided using synchronous queue
var counter = 0
let queue = DispatchQueue.global()


for _ in 0..<1000 {
    queue.async {
        counter += 1
    }
}

print("Counter Value: \(counter)")

//async and await
func performTask() async -> String {
    return "Task Completed"
}

Task {
    let result = await performTask()
    try await Task.sleep(for: .seconds(2))
    print(result)
}

print("Another Task Started")

//Structured Concurrency
//async let
func parentTask() async {
    print("Parent Task Started")
    
    async let child1: Void = childTask(id: 1)
    async let child2: Void = childTask(id: 2)
    
    await child1
    await child2
    print("Parent Task Completed")
}

func childTask(id: Int) async {
    print("Child Task with id \(id) Started")
    try? await Task.sleep(for: .seconds(2))
    print("Child Task with id \(id) Completed")
}

Task {
    await parentTask()
}

//Task Group
func parentTask2() async {
    print("Parent Task started")

    await withTaskGroup(of: Void.self) { group in
        for id in 3...5 {
            group.addTask {
                await childTask(id: id)
            }
        }
    }

    print("Parent Task finished")
}

Task {
    await parentTask2()
}

//Actors
actor Counter {
    var count: Int = 0
    var sum: Int = 0
    
    func increment() async {
        count += 1
        let c = count
        try? await Task.sleep(for: .nanoseconds(c))
        sum += c
    }
    
    func getCount() -> Int {
        return count
    }
    
    func getSum() -> Int {
        return sum
    }
}

Task {
    let counter = Counter()
    
    await withTaskGroup(of: Void.self) { group in
        for _ in 0..<1000 {
            group.addTask {
                await counter.increment()
            }
        }
    }
    
    print(await counter.getCount())
    print(await counter.getSum())
}

//Main Actor - Processed by Main Thread
@MainActor
func performMainActorTask() async {
    print("This is executed in the main actor context")
}

Task {
    await performMainActorTask()
}
