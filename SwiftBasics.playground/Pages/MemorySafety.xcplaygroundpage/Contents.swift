//Conflicting Access to In-Out Parameters
var stepSize = 1
@MainActor
func increment(_ number: inout Int) {
    number += stepSize  //Here when passing stepSize as inout param both the number and the stepSize points to the same memory location
}

//increment(&stepSize)

func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}
var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)  // OK
//balance(&playerOneScore, &playerOneScore)  //Both the inout params cannot be same


//Conflicting Access to self in Methods
class Player {
    var name: String
    var health: Int
    var energy: Int
    init(name: String, health: Int, energy: Int) {
        self.name = name
        self.health = health
        self.energy = energy
    }
    func shareHealth(with player: inout Player) {
        balance(&health, &player.health)
    }
}

var alice = Player(name: "Alice", health: 10, energy: 20)
var bob = Player(name: "Bob", health: 5, energy: 10)
alice.shareHealth(with: &bob)  // OK
//alice.shareHealth(with: &alice)


//Conflicting Access to Properties
var playerInfo = (health: 10, energy: 20)
//balance(&playerInfo.health, &playerInfo.energy)  //Write access to tuple element needed write access to tuple needed

func someFunction() {
    var oscar = (health: 10, energy: 20)
    balance(&oscar.health, &oscar.energy)  // OK Because it is a local variable
    print(oscar.energy)
}
