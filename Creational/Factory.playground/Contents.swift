import UIKit
import PlaygroundSupport

enum SideAction {
    case dark
    case light
    
    private var buttonStyle: (title: String, titleColor: UIColor, backgroundColor: UIColor) {
        switch self {
            case .dark:         return ("dark side", UIColor.white, UIColor.black)
            case .light:        return ("light side", UIColor.black, UIColor.white)
        }
    }
    
    var buttonTitle: String                 { return buttonStyle.title }
    var buttonTitleColor: UIColor           { return buttonStyle.titleColor }
    var buttonBackgroundColor: UIColor      { return buttonStyle.backgroundColor }
}

struct SideButtonFactory {
    static func make(_ button: UIButton, style action: SideAction) -> UIButton {
        button.setTitle(action.buttonTitle, for: .normal)
        button.setTitleColor(action.buttonTitleColor, for: .normal)
        button.backgroundColor = action.buttonBackgroundColor
        return button
    }
}

extension UIButton {
    func style(for style: SideAction) -> UIButton {
        return SideButtonFactory.make(self, style: style)
    }
}

// Screen
let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
view.backgroundColor = .lightGray
let title = UILabel(frame: CGRect(x: 125, y: 150, width: 250, height: 20))
title.text = "Choose your side!"
title.textColor = .red
title.textAlignment = .center
view.addSubview(title)

view.addSubview(UIButton(frame: CGRect(x: 50, y: 220, width: 200, height: 60)).style(for: .light))
view.addSubview(UIButton(frame: CGRect(x: 250, y: 220, width: 200, height: 60)).style(for: .dark))

PlaygroundPage.current.liveView = view
