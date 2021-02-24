import UIKit

class KeyboardHandler2 {
    
    weak var controller: UIViewController!
    
    var tableView: UITableView!
    
    var tabBarHeight: CGFloat {
        return controller.tabBarController?.tabBar.frame.height ?? 0
    }
    
    init(controller: UIViewController) {
        self.controller = controller
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    func register(_ tableView: UITableView) {
        self.tableView = tableView
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        guard
            let input = UIResponder.first as? UIView,
            let inputFrame = input.superview?.convert(input.frame, to: tableView),
            let inputGlobalFrame = input.superview?.convert(input.frame, to: nil),
            let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
        
        guard keyboardFrame.intersects(inputGlobalFrame) else { return }
        
        guard let indexPath = tableView.indexPathsForRows(in: inputFrame)?.first else { return }
        
        tableView.contentInset.bottom = keyboardFrame.height - tabBarHeight
        
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
        
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        tableView.contentInset.bottom = 0
    }
    
}
