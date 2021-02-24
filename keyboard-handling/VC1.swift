import UIKit

class VC1: UIViewController {
    
    let tableView = UITableView(frame: .zero)
    
    lazy var keyboardHandler = KeyboardHandler1(controller: self, anchor: .input)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "TableView+KeyboardHandler1"
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TextFieldCell.self, forCellReuseIdentifier: "text-field-cell")
        tableView.register(TextViewCell.self, forCellReuseIdentifier: "text-view-cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .none
        keyboardHandler.register(tableView)
    }
    
}

extension VC1: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row.isMultiple(of: 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "text-field-cell") as! TextFieldCell
            cell.textField.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "text-view-cell") as! TextViewCell
            cell.textView.delegate = self
            return cell
        }
    }
    
}

extension VC1: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}
