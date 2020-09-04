//
//  BaseViewController.swift
//  MulticastDelegatePattern
//
//  Created by yasinkbas on 4.09.2020.
//

import UIKit

class BaseChatViewController: UIViewController {
    enum ChatState {
        case notStarted
        case stopped
        case started
    }
    
    var `operator`: Operator? = nil {
        didSet {
            operatorLabel.text = `operator`?.name
            operatorImageView.image = `operator`?.picture
        }
    }
    
    lazy var operatorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()
    
    lazy var operatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var operatorConView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start Chat", for: .normal)
        button.backgroundColor = .systemYellow
        return button
    }()
    
    let index: Int
    var state: ChatState = .notStarted
    
    init(index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStartButton()
        setupOperatorConView()
    }
    
    private func setupOperatorConView() {
        operatorConView.addArrangedSubview(operatorImageView)
        operatorConView.addArrangedSubview(operatorLabel)
        operatorConView.backgroundColor = .systemBlue
        view.addSubview(operatorConView)
        
        operatorConView.translatesAutoresizingMaskIntoConstraints = false
        operatorConView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        operatorConView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        operatorConView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6).isActive = true
        operatorConView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupStartButton() {
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        view.addSubview(startButton)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        startButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16).isActive = true
    }
    
    func activateChatIfPossible(for index: Int) {
        let isEnabled = index == self.index
        startButton.isEnabled = isEnabled
        startButton.backgroundColor = isEnabled ? .red : .systemGray
        startButton.setTitle(isEnabled ? "X" : "Start Chat", for: .normal)
        
        UIView.animate(withDuration: 0.7) {
            self.startButton.layer.cornerRadius = isEnabled ? 25 : 0
        }
    }
    
    func resetStartButton() {
        startButton.isEnabled = true
        startButton.backgroundColor = .systemYellow
        startButton.setTitle("Start Chat", for: .normal)
        
        UIView.animate(withDuration: 0.7) {
            self.startButton.layer.cornerRadius = 0
        }
    }
    
    func shakeOperatorCon() {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        shakeAnimation.duration = 0.6
        shakeAnimation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        operatorConView.layer.add(shakeAnimation, forKey: "shake")
    }
    
    @objc
    func didTapStartButton(_ sender: UIButton) {
        if state == .notStarted || state == .stopped {
            service.start(for: index)
            state = .started
        } else if state == .started {
            service.stop()
            state = .stopped
        }
        
        print("didTap")
    }
}
