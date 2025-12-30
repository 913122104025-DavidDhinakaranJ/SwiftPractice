//if else statements
let n = 7
if n % 2 == 0 {
    print("Even")
} else {
    print("Odd")
}

//switch case statements
let grade = 82
switch grade {
case 90...100:
  print("A")
case 80..<90:
  print("B")
case 70..<80:
  print("C")
default:
  print("Below C")
}

//for loop
for i in 1..<5 {
    print("Number: \(i)")
}

//while loop
var count = 1
while count < 5 {
    print("Number: \(count)")
    count += 1
}

//repeat-while loop
var count2 = 1
repeat {
    print("Number: \(count2)")
    count2 += 1
} while count2 < 5

//Exiting multiple loops
outer: for i in 1...3 {
    inner: for j in 1...3 {
        if i == 2 { break outer }
        if j == 2 { break inner }
        print("i: \(i), j: \(j)")
    }
}
