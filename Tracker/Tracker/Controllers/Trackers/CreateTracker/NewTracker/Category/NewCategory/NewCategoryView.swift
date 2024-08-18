import UIKit

final class NewCategoryView {
    
    lazy var categoryLabel: UILabel = {
        let element = UILabel()
        element.text = LocalizableConstants.NewCategoryVC.newCategoryTitle
        element.font = .systemFont(ofSize: 16, weight: .medium)
        element.textColor = .ypBlack
        return element
    }()
    
    lazy var newCategoryTextField: UITextField = {
        let element = UITextField()
        element.placeholder = LocalizableConstants.NewCategoryVC.textFieldPlaceholder
        element.backgroundColor = .ypBackground
        element.layer.cornerRadius = 16
        element.clearButtonMode = .whileEditing
        element.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        element.leftViewMode = .always
        element.textAlignment = .natural
        element.returnKeyType = .done
        element.font = .systemFont(ofSize: 17, weight: .regular)
        element.textColor = .ypBlack
        return element
    }()
    
    lazy var addCategoryButton: UIButton = {
        let element = UIButton(type: .system)
        element.layer.cornerRadius = 16
        element.setTitle(LocalizableConstants.NewCategoryVC.doneButton, for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        element.titleLabel?.textAlignment = .center
        element.setTitleColor(.white, for: .normal)
        element.backgroundColor = .ypGray
        element.isEnabled = false
        return element
    }()
}
