import Foundation

protocol CreateTrackerViewControllerProtocol: AnyObject {
    var viewController: TrackerViewControllerProtocol? { get }
    func switchToTrackerVC()
}
