import UIKit

class KeyboardHandler1 {
    
    enum Anchor {
        case input
        case cell
    }
    
    let anchor: Anchor
    
    weak var controller: UIViewController!
    
    var tableView: UITableView!
    
    var originalOffset: CGPoint = .zero
    var keyboardOffset: CGPoint = .zero
    
    var tabBarHeight: CGFloat {
        return controller.tabBarController?.tabBar.frame.height ?? 0
    }
    
    init(controller: UIViewController, anchor: Anchor) {
        self.controller = controller
        self.anchor = anchor
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
            let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
        
        var targetFrame: CGRect = .zero
        
        switch anchor {
            case .input:
                targetFrame = tableView.convert(inputFrame, to: nil)
            case .cell:
                guard
                    let indexPath = tableView.indexPathsForRows(in: inputFrame)?.first,
                    let cellFrame = tableView.cellForRow(at: indexPath)?.frame
                else { return }
                targetFrame = tableView.convert(cellFrame, to: nil)
        }
        
        guard keyboardFrame.intersects(targetFrame) else { return }
        
        originalOffset = tableView.contentOffset
        keyboardOffset = tableView.contentOffset.applying(.init(translationX: 0, y: keyboardFrame.height + (targetFrame.maxY - controller.view.frame.height)))
        
        tableView.contentInset.bottom = keyboardFrame.height - tabBarHeight
        
        DispatchQueue.main.async {
            self.tableView.setContentOffset(self.keyboardOffset, animated: true)
        }
        
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        tableView.contentInset.bottom = 0
        if tableView.contentOffset == keyboardOffset {
            tableView.setContentOffset(originalOffset, animated: true)
        }
    }
    
}
