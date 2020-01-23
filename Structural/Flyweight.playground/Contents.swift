import UIKit

// UIFont uses flyweight | points same object
let font1 = UIFont.init(name: "AmericanTypewriter", size: 18)
let font2 = UIFont.init(name: "AmericanTypewriter", size: 18)
font1 === font2 // true

// UIFont don't uses flyweight | points different objects
let color1 = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
let color2 = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
color1 === color2 // false


extension UIColor {
    public static var colors: [String: UIColor] = [:]
    
    public class func make(
        _ red: CGFloat,
        _ green: CGFloat,
        _ blue: CGFloat,
        alpha: CGFloat
    ) -> UIColor {
        
        let key = "\(red)\(green)\(blue)\(alpha)"
        if let color = colors[key] { return color }
        
        let color = UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
        colors[key] = color
        return color
    }
}

let color3 = UIColor.make(1, 1, 1, alpha: 1)
let color4 = UIColor.make(1, 1, 1, alpha: 1)
color3 === color4 // true
