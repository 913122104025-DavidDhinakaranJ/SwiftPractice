//async and await
func performTask(id: Int) async -> String {
    try! await Task.sleep(for: .seconds(1))
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
            try! await Task.sleep(for: .seconds(2))
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
    async let result1 = await performTask(id: 1)
    async let result2 = await performTask(id: 2)
    await print(result1)
    await print(result2)
}

////Structured Concurrency
////async let
//func parentTask() async {
//    print("Parent Task Started")
//    
//    async let child1: Void = childTask(id: 1)
//    async let child2: Void = childTask(id: 2)
//    
//    await child1
//    await child2
//    print("Parent Task Completed")
//}
//
//func childTask(id: Int) async {
//    print("Child Task with id \(id) Started")
//    try? await Task.sleep(for: .seconds(2))
//    print("Child Task with id \(id) Completed")
//}
//
//Task {
//    await parentTask()
//}
//
////Task Group
//func parentTask2() async {
//    print("Parent Task started")
//
//    await withTaskGroup(of: Void.self) { group in
//        for id in 3...5 {
//            group.addTask {
//                await childTask(id: id)
//            }
//        }
//    }
//
//    print("Parent Task finished")
//}
//
//Task {
//    await parentTask2()
//}
//
////Actors
//actor Counter {
//    var count: Int = 0
//    var sum: Int = 0
//    
//    func increment() async {
//        count += 1
//        let c = count
//        try? await Task.sleep(for: .nanoseconds(c))
//        sum += c
//    }
//    
//    func getCount() -> Int {
//        return count
//    }
//    
//    func getSum() -> Int {
//        return sum
//    }
//}
//
//Task {
//    let counter = Counter()
//    
//    await withTaskGroup(of: Void.self) { group in
//        for _ in 0..<1000 {
//            group.addTask {
//                await counter.increment()
//            }
//        }
//    }
//    
//    print(await counter.getCount())
//    print(await counter.getSum())
//}
//
////Main Actor - Processed by Main Thread
//@MainActor
//func performMainActorTask() async {
//    print("This is executed in the main actor context")
//}
//
//Task {
//    await performMainActorTask()
//}
