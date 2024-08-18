import UIKit

final class CategoryView {
    
    lazy var categoryLabel: UILabel = {
        let element = UILabel()
        element.text = LocalizableConstants.CategoryVC.categoryTitle
        element.font = .systemFont(ofSize: 16, weight: .medium)
        element.textColor = .ypBlack
        return element
    }()
    
    lazy var emptyLabel: UILabel = {
        let element = UILabel()
        element.text = LocalizableConstants.CategoryVC.emptyStateLabel
        element.textColor = .ypBlack
        element.numberOfLines = 0
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 12, weight: .medium)
        return element
    }()
    
    lazy var emptyImage: UIImageView = {
        let element = UIImageView()
        element.image = Resourses.Images.trackerEmptyImage
        return element
    }()
    
    lazy var categoryTableView: UITableView = {
        let element = UITableView()
        element.layer.cornerRadius = 16
        element.separatorStyle = .singleLine
        element.separatorColor = .ypGray
        return element
    }()
    
    lazy var addCategoryButton: UIButton = {
        let element = UIButton(type: .system)
        element.layer.cornerRadius = 16
        element.setTitle(LocalizableConstants.CategoryVC.addCategoryButton, for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        element.titleLabel?.textAlignment = .center
        element.backgroundColor = .ypBlack
        element.tintColor = .ypWhite
        return element
    }()
}
