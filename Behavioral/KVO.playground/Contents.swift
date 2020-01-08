import UIKit

@objcMembers class Person: NSObject {
    dynamic var name: String
    dynamic var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

var yasin = Person(name: "Yasin", age: 23) //-> initial
var observer: NSKeyValueObservation? = yasin.observe(\.name, options: [.initial,.new,.old]) { (person, change) in
    print("changed or initialized name \"\(change.oldValue ?? "nil")\" with \"\(change.newValue!)\"")
}
yasin.name = "Akbas" //-> new
observer = nil
yasin.name = "something" //-> observer doesn't work anymore

//changed or initialized name "nil" with "Yasin"
//changed or initialized name "Yasin" with "Akbas"
