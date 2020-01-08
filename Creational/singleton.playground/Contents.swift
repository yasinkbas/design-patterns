import Foundation

class Thermometer {
    public static var shared: Thermometer = Thermometer() // singleton
    
    func calculate(fahrenheit f: Double) -> Double {
        return (f - 32) * 5.0/9.0
    }
    
    func calculate(celsius c: Double) -> Double {
        return 9.0/5.0 * c + 32
    }
}

var t = Thermometer.shared
var f = t.calculate(celsius: 32)
print(f)
var c = t.calculate(fahrenheit: 76)
print(c)
