import UIKit

class TextViewCell: UITableViewCell {

    let textView = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            textView.heightAnchor.constraint(equalToConstant: 100)
        ])
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


}
