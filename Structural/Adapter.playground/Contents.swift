import UIKit

protocol PhonePolicy {
    func ring()
    func sendPrimitiveMessage()
    func toggleBluetooth()
    func toggleWifi()
}

class Phone: PhonePolicy {
    var isOpenBluetooth = false
    var isOpenWifi = false
    
    func ring()                     { print("Phone is ringing") }
    func sendPrimitiveMessage()     { print("Sending primitive message") }
    func toggleBluetooth()          { isOpenBluetooth.toggle() }
    func toggleWifi()               { isOpenWifi.toggle() }
    
}

// Adapter Policy
protocol IPhonePolicy: PhonePolicy {
    func sendHiddenMessage()
    func recognizeFace()
}

// Adapter
class IPhone: IPhonePolicy {
    var phone: Phone // or initial Phone()
    init(phone: Phone)              { self.phone = phone }
    
    func ring()                     { phone.ring() }
    func sendPrimitiveMessage()     { phone.sendPrimitiveMessage() }
    func toggleBluetooth()          { phone.toggleBluetooth() }
    func toggleWifi()               { phone.toggleWifi() }
    
    // new features
    func sendHiddenMessage() {
        print("Sending hidden message")
    }
    
    func recognizeFace() {
        print("Recognizing face")
    }
}

let phone = Phone()
phone.ring()

let iphone = IPhone(phone: Phone())
phone.ring()
iphone.recognizeFace()
