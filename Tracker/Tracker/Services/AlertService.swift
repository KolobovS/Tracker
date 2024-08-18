import UIKit

enum ContextEvent {
    case removeCategory
    case removeTracker
}

final class AlertService {
    func showAlert(event: ContextEvent,
                   controller: UIViewController,
                   completion: @escaping (() -> Void)) {
        
        var title: String?
        var message: String?
        
        switch event {
        case .removeTracker:
            title = LocalizableConstants.Alert.removeTrackerTitle
        case .removeCategory:
            title = LocalizableConstants.Alert.removeCategoryTitle
            message = LocalizableConstants.Alert.removeCategoryMessage
        }
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: LocalizableConstants.Alert.cancel, style: .cancel)
        let deleteAction = UIAlertAction(title: LocalizableConstants.Alert.delete, style: .destructive) { _ in
            completion()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        controller.present(alert, animated: true)
    }
}
