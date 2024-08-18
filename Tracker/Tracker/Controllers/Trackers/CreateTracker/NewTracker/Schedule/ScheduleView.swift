import UIKit

final class ScheduleView {
    lazy var scheduleLabel: UILabel = {
        let element = UILabel()
        element.text = LocalizableConstants.ScheduleVC.scheduleTitle
        element.font = .systemFont(ofSize: 16, weight: .medium)
        element.textColor = .ypBlack
        return element
    }()
    
    lazy var scheduleTableView: UITableView = {
        let element = UITableView()
        element.layer.cornerRadius = 16
        element.separatorStyle = .singleLine
        element.separatorColor = .ypGray
        element.allowsSelection = false
        element.isScrollEnabled = false
        return element
    }()
    
    lazy var doneButton: UIButton = {
        let element = UIButton(type: .system)
        element.layer.cornerRadius = 16
        element.setTitle(LocalizableConstants.ScheduleVC.doneButton, for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        element.titleLabel?.textAlignment = .center
        element.setTitleColor(.white, for: .normal)
        element.backgroundColor = .ypGray
        element.isEnabled = false
        return element
    }()
}
