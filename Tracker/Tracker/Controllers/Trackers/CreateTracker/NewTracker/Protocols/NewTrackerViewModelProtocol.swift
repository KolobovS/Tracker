import UIKit

protocol NewTrackerViewModelProtocol: AnyObject {
    var view: NewTrackerViewControllerProtocol? { get set }
    var emojies: [String] { get }
    var colors: [UIColor] { get }
    func createNewTracker()
    func editTracker(id: UUID)
    func setTrackerEmoji(emoji: String)
    func setTrackerColor(color: UIColor)
    func resetNewTrackerInfo()
    func getSelectedCategory() -> String?
    func getSelectedSchedule() -> String?
    func isNewTrackerReady()
}
