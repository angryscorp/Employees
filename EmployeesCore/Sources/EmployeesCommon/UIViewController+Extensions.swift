import ContactsUI
import UIKit

public extension UIViewController {
    func show(contact: CNContact) {
        let vc = ContactViewController(for: contact)
        let nv = UINavigationController(rootViewController: vc)
        present(nv, animated: true)
    }
}

private final class ContactViewController: CNContactViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonDidTap))
        navigationItem.leftBarButtonItem = doneButton
    }
    
    @objc private func doneButtonDidTap() {
        dismiss(animated: true)
    }
}
