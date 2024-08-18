import Foundation

protocol TrackersViewModelProtocol: AnyObject {
    var visibleCategories: [TrackerCategory] { get }
    func deleteTracker(id: UUID)
    func pinTracker(id: UUID)
    func unpinTracker(id: UUID)
    func fetchCompletedCategoriesFromStore()
    func getCompletedCategories() -> [TrackerRecord]
    func addRecord(tracker: TrackerRecord)
    func deleteRecord(tracker: TrackerRecord)
    func setupVisibleTrackers()
    func checkDate() -> Bool
    func filterTrackers(text: String?)
    func todaysFilterDidEnable()
    func updateVisibleTrackersWithFilterCompleted(visible: [TrackerCategory]?, completed: [TrackerRecord]?)
    func updateVisibleTrackersWithFilterUncompleted(visible: [TrackerCategory]?, completed: [TrackerRecord]?)
}
