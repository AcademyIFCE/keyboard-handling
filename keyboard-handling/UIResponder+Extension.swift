import UIKit

extension UIResponder {
    
    static var first: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.storeFirstResponder), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }
    
    private static weak var _currentFirstResponder: UIResponder?
    
    @objc private func storeFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }
    
}
