import UIKit

class Home {
    var doorCount: Int
    var doorColor: UIColor
    var windowCount: Int
    var windowColor: UIColor
    
    init(doorCount: Int, doorColor: UIColor, windowCount: Int, windowColor: UIColor) {
        self.doorCount = doorCount
        self.doorColor = doorColor
        self.windowCount = windowCount
        self.windowColor = windowColor
    }
}

class HomeBuilder {
    enum HomeType {
        case small
        case medium
        case large
        // ... continues with colors or something like this
    }
    
    func build(type: HomeType) -> Home {
        switch type {
        case .small:
            return Home(doorCount: 2, doorColor: .white, windowCount: 4, windowColor: .white)
        case .medium:
            return Home(doorCount: 4, doorColor: .black, windowCount: 6, windowColor: .white)
        case .large:
            return Home(doorCount: 6, doorColor: .black, windowCount: 8, windowColor: .black)
        }
    }
}

var myHome = HomeBuilder().build(type: .medium) // -> builds home
print("doorCount: \(myHome.doorCount), windowCount: \(myHome.windowCount)")
