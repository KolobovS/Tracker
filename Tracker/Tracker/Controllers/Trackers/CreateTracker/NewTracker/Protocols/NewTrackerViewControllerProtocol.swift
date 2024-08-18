import UIKit

protocol NewTrackerViewControllerProtocol: AnyObject {
    var typeOfTracker: TypeOfTracker? { get }
    func enableCreateButton()
    func disableCreateButton()
    func reloadTableView()
}
