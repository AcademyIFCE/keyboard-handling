import UIKit

class VC3: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "TableViewController"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TextFieldCell.self, forCellReuseIdentifier: "text-field-cell")
        tableView.register(TextViewCell.self, forCellReuseIdentifier: "text-view-cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .none
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

extension VC3: UITextFieldDelegate, UITextViewDelegate {
    
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
