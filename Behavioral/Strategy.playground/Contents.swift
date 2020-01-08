import Foundation

protocol AnimalStrategy {
    var totalLive: Int { get }
    var animalType:String { get }
    
    func eat()
    func die()
}

class Cat: AnimalStrategy {
    var animalType: String = "cat"
    var totalLive: Int = 9
    func eat() {
        print("The \(animalType) is eating its food")
    }
    func die() {
        totalLive -= 1
        totalLive == 0 ?
            print("The \(animalType) died ☠️") :
            print("The \(animalType) has \(totalLive) lives")
    }
}

class Dog: AnimalStrategy {
    var animalType: String = "dog"
    var totalLive: Int = 1
    func eat() {
        totalLive == 0 ?
            print("You can't feed the animal because of died") :
            print("The \(animalType) is eating its food")
    }
    func die() {
        totalLive -= 1
        totalLive == 0 ?
            print("The \(animalType) died ☠️") : nil
    }
}

class Game {
    var animal: AnimalStrategy!
    
    init(animal: AnimalStrategy) {
        self.animal = animal
    }
    
    func feedAnimal() {
        animal.eat()
    }
    
    func wasAtackedAnimal() {
        animal.die()
    }
}

var game = Game(animal: Cat())
game.wasAtackedAnimal()
game.feedAnimal()

var game2 = Game(animal: Dog())
game2.wasAtackedAnimal()
game2.feedAnimal()
