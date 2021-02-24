import UIKit

class VC4: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var tabBarHeight: CGFloat {
        return (tabBarController?.tabBar.frame.height ?? 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "ScrollView"
        setupScrollView()
        setupTextFields()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        if let maxY = contentView.subviews.last?.frame.maxY {
            contentView.heightAnchor.constraint(equalToConstant: maxY).isActive = true
            scrollView.contentSize.height = maxY
        }
    }
    
    func setupScrollView() {
        
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
          
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    
    }
    
    func setupTextFields(){
        for i in (0...20) {
            let textField = UITextField()
            textField.placeholder = "Lorem Ipsum \(i)"
            textField.borderStyle = .roundedRect
            textField.delegate = self
            contentView.addSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CGFloat(i*75)).isActive = true
        }
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        guard
            let responder = UIResponder.first as? UIView,
            let responderGlobalFrame = responder.superview?.convert(responder.frame, to: nil),
            let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
        
        guard keyboardFrame.intersects(responderGlobalFrame) else { return }
        
        let keyboardOffset = CGPoint(x: scrollView.contentOffset.x, y: keyboardFrame.height - (contentView.frame.height - responder.frame.maxY))

        scrollView.contentInset.bottom = keyboardFrame.height - tabBarHeight
        
        self.scrollView.setContentOffset(keyboardOffset, animated: true)
        
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0
    }
    
}

extension VC4: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}
