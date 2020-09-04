//
//  ThirdViewController.swift
//  MulticastDelegatePattern
//
//  Created by yasinkbas on 4.09.2020.
//

import UIKit

class ThirdViewController: BaseChatViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        MulticastDelegatePattern.service.multicastDelegate.listenOn(self)
        `operator` = MulticastDelegatePattern.service.connectRandomOperator()
    }
}

extension ThirdViewController: ServiceDelegate {
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
