import UIKit

final class NewTrackerViewModel: NewTrackerViewModelProtocol {
    var view: NewTrackerViewControllerProtocol?
    
    private let dataProvider = DataProvider.shared
    private let scheduleService = ScheduleService()
    
    let tableViewTitle = [LocalizableConstants.NewTrackerVC.tableViewCategoryLabel, LocalizableConstants.NewTrackerVC.tableViewScheduleLabel]
    
    var emojies: [String] = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
    
    var colors: [UIColor] = [
        .colorSelection1, .colorSelection2, .colorSelection3, .colorSelection4, .colorSelection5, .colorSelection6,
        .colorSelection7, .colorSelection8, .colorSelection9, .colorSelection10, .colorSelection11, .colorSelection12,
        .colorSelection13, .colorSelection14, .colorSelection15, .colorSelection16, .colorSelection17, .colorSelection18,
    ]
    
    @Observable
    private(set) var checkTrackerForCreate = false
    
    init() {
        dataProvider.bindNewTrackerViewModel(controller: self)
    }
    
    func createNewTracker() {
        guard let trackerColor = dataProvider.trackerColor,
              let trackerName = dataProvider.trackerName,
              let trackerEmoji = dataProvider.trackerEmoji else { return }
        
        let newTracker = Tracker(id: UUID(),
                                 name: trackerName,
                                 color: trackerColor,
                                 emoji: trackerEmoji,
                                 schedule: dataProvider.trackerSchedule ?? Array(1...7))
        dataProvider.addTrackerToStore(newTracker)
    }
    
    //MARK: Setting New Tracker Info
    func setTrackerName(name: String) {
        dataProvider.trackerName = name
    }
    
    func setTrackerEmoji(emoji: String) {
        dataProvider.trackerEmoji = emoji
    }
    
    func setTrackerColor(color: UIColor) {
        dataProvider.trackerColor = color
    }
    
    func resetNewTrackerInfo() {
        dataProvider.resetNewTrackerInfo()
    }
    
    //MARK: Getting Tracker Info
    func getSelectedCategory() -> String? {
        dataProvider.selectedCategory
    }
    
    func getSelectedSchedule() -> String? {
        dataProvider.selectedSchedule
    }
    
    func isNewTrackerReady() {
        if dataProvider.didAllFieldsFill() {
            switch view?.typeOfTracker {
            case .habit:
                checkTrackerForCreate = dataProvider.selectedSchedule != nil ? true : false
            case .unregularEvent:
                checkTrackerForCreate = true
            default:
                checkTrackerForCreate = false
            }
        } else {
            checkTrackerForCreate = false
        }
    }
    
    //MARK: Editing Tracker Info
    func editTracker(id: UUID) {
        dataProvider.editTracker(id)
    }
    
    func presetTrackerInfo(tracker: Tracker, category: String) {
        dataProvider.trackerName = tracker.name
        dataProvider.trackerEmoji = tracker.emoji
        dataProvider.trackerColor = tracker.color
        dataProvider.trackerSchedule = tracker.schedule
        dataProvider.selectedCategory = category
        
        guard let schedule = dataProvider.trackerSchedule else { return }
        
        let string = schedule.count == 7 ? LocalizableConstants.ScheduleVC.everyDay : scheduleService.arrayToString(array: schedule)
        
        dataProvider.selectedSchedule = string
    }
}
