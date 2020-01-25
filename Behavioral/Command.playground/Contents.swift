import UIKit

struct Product {
    var name: String
    var numberOfPiece: Int
}

// MARK: Command
protocol Command {
    var product: Product { get set }
    
    func execute()
}

class MarketCommand: Command {
    var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    func execute() {
        print("Going to supermarket to buy \(product.numberOfPiece) pieces of \(product.name)")
    }
}

class PharmacyCommand: Command {
    var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    func execute() {
        print("Going to pharmacy to buy \(product.numberOfPiece) pieces of \(product.name)")
    }
}

class BakeCommand: Command {
    // MARK: Bake receiver
    struct Baker {
        var product: Product?
        
        init() { }
        
        mutating func waitFor(bread: Product) {
            self.product = bread
            print("-Waiting for bread for 15 mins")
        }
        
        func finishWaiting() {
            print("-Waiting is completed")
            print("-You got \(product!.numberOfPiece) \(product!.name)")
        }
    }
    
    var baker: Baker
    var product: Product
    
    init(receiver baker: Baker, product: Product) {
        self.baker = baker
        self.product = product
    }
    
    func execute() {
        print("Going to baker to buy \(product.numberOfPiece) pieces of \(product.name)")
        baker.waitFor(bread: product)
        baker.finishWaiting()
    }
}

// MARK: Invoker
class Doorman {
    var commands: [Command] = []
    
    init() { }
    
    func addCommand(_ command: Command) {
        commands.append(command)
    }
    
    func execute() {
        print("Leaving the building")
        commands.forEach { $0.execute() }
        print("Going back to the building")
    }
}

let doorman = Doorman()
doorman.addCommand(MarketCommand(product: Product(name: "chocolate", numberOfPiece: 5)))
doorman.addCommand(PharmacyCommand(product: Product(name: "aspirin", numberOfPiece: 1)))
// command with receiver
doorman.addCommand(BakeCommand(receiver: BakeCommand.Baker(), product: Product(name: "white bread", numberOfPiece: 3)))
doorman.execute()
