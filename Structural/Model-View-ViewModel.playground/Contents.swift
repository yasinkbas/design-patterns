import UIKit
import PlaygroundSupport

// MARK: - Model
struct Contact {
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var fullName: String {
        return firstName + " " + lastName
    }
    
    func toString() -> String {
        return "Contact name: \(fullName), phone number: \(phoneNumber)"
    }
    
    // the names generated on https://www.name-generator.org.uk
    static var dummyArray: [Contact] = [
        Contact(firstName: "Kelise", lastName: "Mcguire", phoneNumber: "+9_0555_111_22_33"),
        Contact(firstName: "Kristin", lastName: "Cortez", phoneNumber: "+9_0555_111_22_34"),
        Contact(firstName: "Florrie", lastName: "Dillon", phoneNumber: "+9_0555_111_22_35"),
        Contact(firstName: "Lana", lastName: "Whiteley", phoneNumber: "+9_0555_111_22_36"),
        Contact(firstName: "Felicity", lastName: "Mack", phoneNumber: "+9_0555_111_22_37"),
        Contact(firstName: "Dawid", lastName: "Santana", phoneNumber: "+9_0555_111_22_38"),
        Contact(firstName: "Kirsten", lastName: "Wong", phoneNumber: "+9_0555_111_22_39"),
        Contact(firstName: "Ziggy", lastName: "Waller", phoneNumber: "+9_0555_111_22_40"),
        Contact(firstName: "Nicky", lastName: "Leon", phoneNumber: "+9_0555_111_22_41"),
        Contact(firstName: "Edmund", lastName: "Hampton", phoneNumber: "+9_0555_111_22_42")
    ]
}

// MARK: - ViewModel
class ContactViewModel {
    private var contacts = [Contact]()
    
    func get(at index: Int) -> Contact {
        return contacts[index]
    }
    
    func getAll() -> [Contact] {
        return contacts
    }
    
    func add(contact: Contact) {
        contacts.append(contact)
    }
    
    func remove(at index: Int) {
        contacts.remove(at: index)
    }
    
    func removeAll() {
        contacts.removeAll()
    }
}

// MARK: - View
protocol ContactViewDelegate: class {
    var contacts: [Contact] { get }
    func contactView(_ contactView: ContactView, didTapAddContactButton button: UIButton)
    func contactView(_ contactView: ContactView, didTapShowContactsButton button: UIButton)
    func contactView(_ contactView: ContactView, didTapRemoveAllContactsButton button: UIButton)
}

class ContactView: UIView {
    
    weak var delegate: ContactViewDelegate?
    
    private lazy var centerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var addContactButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Contact", for: .normal)
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(addContactButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var showContactsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show Contacts", for: .normal)
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(showContactsButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var removeAllContactsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Remove All Contacts", for: .normal)
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(removeAllContactsButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var logView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.green
        textView.font = UIFont(name: "Menlo-Regular", size: 9)
        textView.text = "model-view-viewmodel:~$ I am the logger 🤘🏻"
        textView.backgroundColor = .clear
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeAppearance()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not implemented")
    }
    
    private func customizeAppearance() {
        backgroundColor = .black
    }
    
    private func setupView() {
        centerStackView.addArrangedSubview(addContactButton)
        centerStackView.addArrangedSubview(showContactsButton)
        centerStackView.addArrangedSubview(removeAllContactsButton)
        
        addSubview(centerStackView)
        centerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            centerStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            centerStackView.heightAnchor.constraint(equalToConstant: 110)
        ])
        
        addSubview(logView)
        logView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logView.leftAnchor.constraint(equalTo: leftAnchor),
            logView.rightAnchor.constraint(equalTo: rightAnchor),
            logView.bottomAnchor.constraint(equalTo: bottomAnchor),
            logView.topAnchor.constraint(equalTo: centerStackView.bottomAnchor, constant: 32)
        ])
    }
    
    // MARK: Target selectors
    @objc
    private func addContactButtonClicked(_ sender: UIButton) {
        log("Your contact added")
        delegate?.contactView(self, didTapAddContactButton: sender)
        
    }
    
    @objc
    private func showContactsButtonClicked(_ sender: UIButton) {
        let hauledArray = delegate?.contacts.enumerated().map({ index, element in
            "\n\(index + 1). \(element.toString())"
        })
        let result = hauledArray!.joined()
        let count = hauledArray?.count
        log("Your contacts count: \(count!) \nYour contacts: \(result)")
        delegate?.contactView(self, didTapShowContactsButton: sender)
    }
    
    @objc
    private func removeAllContactsButtonClicked(_ sender: UIButton) {
        log("Removed your all contacts")
        delegate?.contactView(self, didTapRemoveAllContactsButton: sender)
    }
    
    private func log(_ text: String) {
        logView.text += "\nmodel-view-viewmodel:~$ \(text)"
        scrollDownBottom()
    }
    
    private func scrollDownBottom() {
        if logView.text.count > 0 {
            let location = logView.text.count - 1
            let bottom = NSMakeRange(location, 1)
            logView.scrollRangeToVisible(bottom)
        }
    }
}

// MARK: - Controller
class ContactController: UIViewController {
    var viewModel: ContactViewModel
    
    init(viewModel: ContactViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        let contactView = ContactView(frame: self.view.bounds)
        contactView.delegate = self
        self.view = contactView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContactController: ContactViewDelegate {
    var contacts: [Contact] {
        return viewModel.getAll()
    }
    
    func contactView(_ contactView: ContactView, didTapAddContactButton button: UIButton) {
        let contact = Contact.dummyArray.randomElement()!
        viewModel.add(contact: contact)
    }
    
    func contactView(_ contactView: ContactView, didTapShowContactsButton button: UIButton) {
        print(viewModel.getAll())
    }
    
    func contactView(_ contactView: ContactView, didTapRemoveAllContactsButton button: UIButton) {
        viewModel.removeAll()
    }
}

let viewModel = ContactViewModel()
let controller = ContactController(viewModel: viewModel)

PlaygroundPage.current.liveView = controller

