//
//  UIViewController+ChildView.swift
//  MulticastDelegatePattern
//
//  Created by yasinkbas on 4.09.2020.
//

import UIKit

extension UIViewController {
    func addQuarterChildViewController(_ childViewController: UIViewController, for quarter: Int) {
        addChild(childViewController)
        childViewController.view.frame = CGRect(
            x: quarter.isMultiple(of: 2) ? view.frame.width / 2 : 0,
            y: quarter <= 2 ? 0 : view.frame.height / 2,
            width: view.frame.width / 2,
            height: view.frame.height / 2
        )
        view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }
}
