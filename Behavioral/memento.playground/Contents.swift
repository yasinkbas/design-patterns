import Foundation

// MARK: Memento
public struct Memento {
    var state: String
}

// MARK: Originator
public class Originator {
    public var state: String = ""
    
    public func saveStateToMemento() -> Memento {
        return Memento(state: state)
    }
    
    public func getState(from memento: Memento) {
        state = memento.state
    }
}

// MARK: Caretaker
public class CareTaker {
    private var list = [Memento]()
    
    public func add(state: Memento) {
        list.append(state)
    }
    
    subscript(index: Int) -> Memento {
        return list[index]
    }
}


var originator = Originator()
var careTaker = CareTaker()

originator.state = "State 1"
originator.state = "State 2"

careTaker.add(state: originator.saveStateToMemento())

originator.state = "State 3"
careTaker.add(state: originator.saveStateToMemento())

originator.state = "State 4"
print("Current State: ", originator.state)

originator.getState(from: careTaker[0])
print("First saved State: ", originator.state)

originator.getState(from: careTaker[1])
print("Second saved State: ", originator.state)

// java version: https://www.tutorialspoint.com/design_pattern/memento_pattern.htm
