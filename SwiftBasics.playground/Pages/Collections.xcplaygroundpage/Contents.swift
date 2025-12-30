//Array
var fruits: [String] = ["banana", "cherry", "apple"] //Ordered
fruits.insert("orange", at: 1)
print(fruits[2])
print(fruits.count)

for fruit in fruits {
    print(fruit)
}

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
ages.removeValue(forKey: "Bob")

for (name, age) in ages {
    print("\(name) is \(age) years old.")
}

//map, filter, and reduce
let numbers: [Int] = [1, 2, 3, 4, 5]

let result = numbers
    .filter { $0.isMultiple(of: 2) }
    .map { $0 * 2 }
    .reduce(0, +)
