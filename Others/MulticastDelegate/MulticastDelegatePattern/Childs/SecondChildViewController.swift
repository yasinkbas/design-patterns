//
//  SecondChildViewController.swift
//  MulticastDelegatePattern
//
//  Created by yasinkbas on 4.09.2020.
//

import UIKit

class SecondViewController: BaseChatViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        MulticastDelegatePattern.service.multicastDelegate.listenOn(self)
        `operator` = MulticastDelegatePattern.service.connectRandomOperator()
    }
}

extension SecondViewController: ServiceDelegate {
    func didStopServiceChat() {
        resetStartButton()
    }
    
    func service(_ service: Service, didStartChat index: Int) {
        activateChatIfPossible(for: index)
        if self.index != index {
            shakeOperatorCon()
        }
    }
}
