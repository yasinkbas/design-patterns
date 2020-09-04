//
//  FirstChildViewController.swift
//  MulticastDelegatePattern
//
//  Created by yasinkbas on 4.09.2020.
//

import UIKit

class FirstViewController: BaseChatViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        MulticastDelegatePattern.service.multicastDelegate.listenOn(self)
        `operator` = MulticastDelegatePattern.service.connectRandomOperator()
    }
}

extension FirstViewController: ServiceDelegate {
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
