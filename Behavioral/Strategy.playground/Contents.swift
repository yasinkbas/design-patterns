import Foundation
import XCTest

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
            print("The \(animalType) died ☠️") :
            print("The \(animalType) is eating its food")
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

// MARK:- Simple Test
class AnimalTests: XCTestCase {
    override class func setUp() {
        super.setUp()
    }
    
    func testInitialLifeOfAnimals() {
        // Given
        let livesOfCat = Cat().totalLive
        let livesOfDog = Dog().totalLive

        // Then
        XCTAssertEqual(livesOfCat, 9, "Cat's initial live is wrong")
        XCTAssertEqual(livesOfDog, 1, "Dog's initial live is wrong")
    }
    
    func testTotalLiveIsComputedWhenAnimalDied() {
        // Given
        let cat = Cat()
        let dog = Dog()
        
        let catInitialLives = cat.totalLive
        let dogInitialLives = dog.totalLive
        
        // When
        cat.die()
        dog.die()
        
        // Then
        XCTAssertEqual(cat.totalLive, catInitialLives - 1)
        XCTAssertEqual(dog.totalLive, dogInitialLives - 1)
    }
}
AnimalTests.defaultTestSuite.run()
