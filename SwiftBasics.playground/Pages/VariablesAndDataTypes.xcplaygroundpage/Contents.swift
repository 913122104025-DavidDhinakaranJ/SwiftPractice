print("Hello, playground")

var variable = 10
variable = 20  //Here var allows to change value

let constant = 10
//constant = 20  //Here let doesn't allow to change value

var number = 800_000  //Numbers allows underscores as seperators

var str1 = """
This is 
a multiline 
string.
"""

var inferred = 10               //Type inference (implicit)
print(type(of: inferred))

var annotated: Double = 10     //Type annotation (explicit)
print(type(of: annotated))

var integer = 10
//var sum = integer + 5.5  //Value of one type cannot be converted into another type implicitly

var isReady: Bool = true

let label = "The width is "
let width = 94
let widthLabel = label + String(width)  //Int to String conversion.

let apples = 3
let oranges = 5
let fruitSummary = "I have \(apples + oranges) pieces of fruit."  //String interpolation

//Type Casting
let intValue: Int = 10
let doubleValue: Double = Double(intValue)

//Type Checking
let value: Any = "A string"
if value is String {
    print("Value is a String")
}

//Upcasting
let stringValue: String = "A string"
let anyValue: Any = stringValue

//Downcasting
let anyValue2: Any = 5.0
let intValue2: Int? = anyValue2 as? Int  //Optional Downcasting
let doubleValue2: Double = anyValue2 as! Double  //Forced Downcasting

//Overflow operation
let maxValue: Int8 = Int8.max
let nextValue: Int8 = maxValue &+ 1  //&+, &-, &* are overflow operators
print(nextValue)

//TypeAlias
typealias Hour = Int
var quarterHour: Hour = 15
