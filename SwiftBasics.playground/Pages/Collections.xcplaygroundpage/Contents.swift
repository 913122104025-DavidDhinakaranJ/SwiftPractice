//Array
var fruits: [String] = ["banana", "cherry", "apple"] //Ordered
fruits.insert("orange", at: 1)
print(fruits[2])
print(fruits.count)

for fruit in fruits {
    print(fruit)
}

for (index, fruit) in fruits.enumerated() {
    print("\(index): \(fruit)")
}

var zeros: [Int] = Array(repeating: 0, count: 10)

//Tuples
let person = (name: "Alice", age: 30)  //Fixed size, cannot add or remove elements

person.0
person.name

person.1
person.age

let (name, age) = person  //Destructuring
print(name)

//Set
var colors: Set<String> = ["red", "blue", "green"]  //Unordered
colors.insert("yellow")
print(colors.contains("blue"))

for color in colors {
    print(color)
}

colors.forEach { print($0) }

var evenNumbers: Set<Int> = [2, 4, 6, 8, 10]
var primeNumbers: Set<Int> = [2, 3, 5, 7, 11]

evenNumbers.union(primeNumbers)
evenNumbers.intersection(primeNumbers)
evenNumbers.subtracting(primeNumbers)
evenNumbers.symmetricDifference(primeNumbers)
evenNumbers.isSubset(of: primeNumbers)
evenNumbers.isSuperset(of: primeNumbers)

//Dictionary
var ages: [String: Int] = ["Alice": 30, "Bob": 25, "Charlie": 35]  //Unordered
print(ages["Alice", default: 0])
print(ages.count)

var ages2: [String: Int] = ["Dave": 20, "Einstein": 50]
ages.merge(ages2) { (current, new) in new}

ages["Alice"] = nil  //Remove by setting nil
ages.removeValue(forKey: "Bob")
print(ages)

for (name, age) in ages {
    print("\(name) is \(age) years old.")
}

//map, filter, and reduce
let numbers: [Int] = [1, 2, 3, 4, 5]

let result = numbers
    .filter { $0.isMultiple(of: 2) }
    .map { $0 * 2 }
    .reduce(1, *)

//compact map and flat map
let strings: [String?] = ["a", nil, "c", nil, "e"]
let nonNilStrings = strings.compactMap { $0 }

let nestedArrays: [[String]] = [["a", "b"], ["c"], ["g", "h"]]
let flatNestedArrays = nestedArrays.flatMap { $0 }

//Lazy Collection
let lazyResult = numbers.lazy
    .map {
        print("Mapping \($0)")
        return $0 * 2
    }
    .first {
        $0 > 5
    }

print(lazyResult!)
