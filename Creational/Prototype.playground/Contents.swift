import UIKit

enum Company {
    case apple
    case samsung
}

class Phone {
    var name: String
    var company: Company
    var price: Double
    
    init(name: String, company: Company, price: Double) {
        self.name = name
        self.company = company
        self.price = price
    }
}

extension Phone: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return Phone(name: name, company: company, price: price)
    }
}

let iphone = Phone(name: "iphone", company: .apple, price: 999)
let samsung = iphone.copy()
if let samsung = samsung as? Phone {
    samsung.name = "samsung"
    samsung.company = .samsung
    print(samsung.name) // samsung
    print(iphone.name) // iphone
}
