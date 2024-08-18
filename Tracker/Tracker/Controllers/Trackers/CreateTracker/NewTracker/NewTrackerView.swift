import UIKit

final class NewTrackerView {
    
    lazy var newHabitLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 16, weight: .medium)
        element.textColor = .ypBlack
        return element
    }()
    
    lazy var countOfCompletedDaysLabel: UILabel = {
        let element = UILabel()
        element.font = .boldSystemFont(ofSize: 32)
        element.textColor = .ypBlack
        element.textAlignment = .center
        return element
    }()
    
    lazy var habitNameTextField: UITextField = {
        let element = UITextField()
        element.placeholder = LocalizableConstants.NewTrackerVC.textFieldPlaceholder
        element.backgroundColor = .ypBackground
        element.layer.cornerRadius = 16
        element.clearButtonMode = .whileEditing
        element.textAlignment = .natural
        element.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        element.leftViewMode = .always
        element.returnKeyType = .done
        element.font = .systemFont(ofSize: 17, weight: .regular)
        element.textColor = .ypBlack
        return element
    }()
    
    lazy var warningLabel: UILabel = {
        let element = UILabel()
        element.text = LocalizableConstants.NewTrackerVC.textFieldWarning
        element.font = .systemFont(ofSize: 17, weight: .regular)
        element.textColor = .ypRed
        element.textAlignment = .center
        element.sizeToFit()
        return element
    }()
    
    lazy var categoryAndScheduleTableView: UITableView = {
        let element = UITableView()
        element.separatorStyle = .singleLine
        element.separatorColor = .ypGray
        element.layer.cornerRadius = 16
        element.isScrollEnabled = false
        return element
    }()
    
    lazy var scrollView: UIScrollView = {
        let element = UIScrollView()
        return element
    }()
    
    lazy var collectionView: UICollectionView = {
        let element = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        element.backgroundColor = .ypWhite
        element.isScrollEnabled = false
        element.allowsMultipleSelection = true
        return element
    }()
    
    lazy var cancelButton: UIButton = {
        let element = UIButton(type: .system)
        element.layer.cornerRadius = 16
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor.ypRed.cgColor
        element.setTitle(LocalizableConstants.NewTrackerVC.cancelButton, for: .normal)
        element.titleLabel?.textAlignment = .center
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        element.backgroundColor = .ypWhite
        element.tintColor = .ypRed
        return element
    }()
    
    lazy var createButton: UIButton = {
        let element = UIButton(type: .system)
        element.layer.cornerRadius = 16
        element.setTitle(LocalizableConstants.NewTrackerVC.createButton, for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        element.titleLabel?.textAlignment = .center
        element.setTitleColor(.white, for: .normal)
        element.backgroundColor = .ypGray
        element.isEnabled = false
        return element
    }()
}
