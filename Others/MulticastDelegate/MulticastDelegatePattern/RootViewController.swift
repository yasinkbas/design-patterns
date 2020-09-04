//
//  ViewController.swift
//  MulticastDelegatePattern
//
//  Created by yasinkbas on 2.09.2020.
//

import UIKit

// MARK: - RootViewController
class RootViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "South Park Operators"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let firstVC = FirstViewController(index: 1)
        addQuarterChildViewController(firstVC, for: 1)
        
        let secondVC = SecondViewController(index: 2)
        addQuarterChildViewController(secondVC, for: 2)
        
        let thirdVC = ThirdViewController(index: 3)
        addQuarterChildViewController(thirdVC, for: 3)
        
        let fourthVC = FourthViewController(index: 4)
        addQuarterChildViewController(fourthVC, for: 4)
        
        setupTitleLabel()
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 32).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        
    }
}
