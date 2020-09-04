//
//  Service.swift
//  MulticastDelegatePattern
//
//  Created by yasinkbas on 2.09.2020.
//

import UIKit

typealias Operator = (name: String, picture: UIImage)

protocol ServiceDelegate: AnyObject {
    func service(_ service: Service, didStartChat index: Int)
    func didStopServiceChat()
}

protocol ServiceLogic {
    var multicastDelegate: MulticastDelegate<ServiceDelegate> { get set }
    
    func start(for index: Int)
    func connectRandomOperator() -> Operator?
}

class Service: ServiceLogic {
    
    var dataSource: OperatorDataSourceLogic = OperatorDataSource()
    
    var multicastDelegate = MulticastDelegate<ServiceDelegate>()
    
    func start(for index: Int) {
        multicastDelegate.invoke { $0.service(self, didStartChat: index) }
    }
    
    func stop() {
        multicastDelegate.invoke { $0.didStopServiceChat() }
    }
    
    func connectRandomOperator() -> Operator? {
        let randomOperator = dataSource.operators.randomElement()!
        var operators = [(name: String, picture: UIImage)]()
        dataSource.operators.forEach { `operator` in
            if `operator`.name != randomOperator.name {
                operators.append(`operator`)
            }
        }
        dataSource.operators = operators
        return randomOperator
    }
}

// MARK: - Dummy Data Source
protocol OperatorDataSourceLogic {
    var operators: [(name: String, picture: UIImage)] { get set }
}

class OperatorDataSource: OperatorDataSourceLogic {
    
    var operators: [Operator] = [
        ("Eric Cartman", #imageLiteral(resourceName: "eric")),
        ("Kenny McCormick", #imageLiteral(resourceName: "kenny")),
        ("Kyle Broflovski", #imageLiteral(resourceName: "kyle")),
        ("Stan Marsh", #imageLiteral(resourceName: "stan")),
        ("Wendy Testaburger", #imageLiteral(resourceName: "wendy")),
        ("Tweak Tweak", #imageLiteral(resourceName: "tweak")),
        ("Jimmy Valmer", #imageLiteral(resourceName: "jimmy"))
    ]
}
