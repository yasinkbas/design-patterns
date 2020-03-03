import UIKit

protocol Liquid {
    func getSugar() -> Int
    func getColor() -> String?
}

class Water: Liquid {
    let sugar: Int
    let color: String?
    
    init(sugar: Int = 0, color: String? = nil) {
        self.sugar = sugar
        self.color = color
    }
    
    func getSugar() -> Int {
        return self.sugar
    }
    
    func getColor() -> String? {
        return self.color
    }
}

protocol Juice: Liquid {
    var liquid: Liquid { get set }
}

class CherryJuice: Juice {
    var liquid: Liquid
    
    init(liquid: Liquid) {
        self.liquid = liquid
    }
    
    func getColor() -> String? {
        let essenceColor = liquid.getColor() == nil ?  "" : liquid.getColor()! + "and"
        return essenceColor + "red"
    }
    
    func getSugar() -> Int {
        return liquid.getSugar() + 20
    }
}

class OrangeJuice: Juice {
    var liquid: Liquid
    
    init(liquid: Liquid) {
        self.liquid = liquid
    }
    
    func getColor() -> String? {
        let essenceColor = liquid.getColor() == nil ?  "" : liquid.getColor()! + "and"
        return essenceColor + "orange"
    }
    
    func getSugar() -> Int {
        return liquid.getSugar() + 12
    }
}

protocol Coke: Juice { }

class CocaCola: Coke {
    var liquid: Liquid
    
    init(liquid: Liquid) {
        self.liquid = liquid
    }
    
    func getColor() -> String? {
        let essenceColor = liquid.getColor() == nil ?  "" : liquid.getColor()! + " and "
        return essenceColor + "black"
    }
    
    func getSugar() -> Int {
        return liquid.getSugar() + 150
    }
}

let orange = OrangeJuice(liquid: Water())
orange.getSugar() // 12
orange.getColor() // orange

let cherry = CherryJuice(liquid: Water())
cherry.getSugar() // 20
cherry.getColor() // red

let customWater = Water(sugar: 50, color: "light")
let coke = CocaCola(liquid: customWater)
coke.getColor() // light and black
coke.getSugar() // 200
