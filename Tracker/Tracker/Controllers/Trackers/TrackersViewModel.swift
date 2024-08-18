import UIKit

final class TrackersViewModel: TrackersViewModelProtocol {
  
    private let dataProvider = DataProvider.shared
    private let dateService = DateService()
    
    var currentDate: Date? {
        didSet {
            filterTrackers(text: "")
            emptyImage = Resourses.Images.trackerEmptyImage
            emptyLabel = LocalizableConstants.TrackersVC.emptyStateLabel
        }
    }
    
    var numberOfVisibleCategories: Int {
        visibleCategories.count
    }
    
    var hideFilterButton: Bool? = false
    var emptyImage: UIImage?
    var emptyLabel: String?
    var searchText: String? {
        didSet {
            filterTrackers(text: searchText)
            emptyImage = Resourses.Images.searchEmptyImage
            emptyLabel = LocalizableConstants.TrackersVC.nothingFoundLabel
        }
    }
    
    @Observable
    private(set) var visibleCategories: [TrackerCategory] = []
    @Observable
    private(set) var needChangeDate: Bool?
    
    init() {
        dataProvider.trackerStore = TrackerStore()
        dataProvider.trackerCategoryStore = TrackerCategoryStore()
        dataProvider.trackerRecordStore = TrackerRecordStore()
        dataProvider.statisticsService = StatisticService()
        
        dataProvider.fetchVisibleCategoriesFromStore()
        dataProvider.getCategoryName()
        dataProvider.fetchRecordFromStore()
        dataProvider.bindTrackersViewModel(controller: self)
    }
    
    func areVisibleCategoriesEmpty() -> Bool {
        if visibleCategories.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func todaysFilterDidEnable() {
        needChangeDate = true
    }
    
    func fetchCompletedCategoriesFromStore() {
        dataProvider.fetchRecordFromStore()
    }
    
    func getCompletedCategories() -> [TrackerRecord] {
        dataProvider.getCompletedTrackers()
    }
    
    func pinTracker(id: UUID) {
        let pinnedCategory = LocalizableConstants.TrackersVC.pinnedTrackers
        if visibleCategories[0].name != pinnedCategory {
            dataProvider.addCategory(category: pinnedCategory)
            dataProvider.pinTracker(id: id)
        } else {
            dataProvider.pinTracker(id: id)
        }
    }
    
    func unpinTracker(id: UUID) {
        dataProvider.unpinTracker(id: id)
    }
    
    func deleteTracker(id: UUID) {
        dataProvider.deleteTrackerFromStore(id: id)
    }
    
    func setupVisibleTrackers() {
        if isPinnedTrackersExist() {
            filterTrackersWithPinned(text: "")
        } else {
            filterTrackers(text: "")
        }
    }
    
    func addRecord(tracker: TrackerRecord) {
        dataProvider.addRecord(record: tracker)
    }
    
    func deleteRecord(tracker: TrackerRecord) {
        dataProvider.deleteRecord(tracker: tracker)
    }
    
    func checkDate() -> Bool {
        guard let currentDate = currentDate else { return false }
        let date = Date()
        
        return date > currentDate
    }
    
    func filterTrackers(text: String?) {
        guard let date = currentDate,
              let text = text?.lowercased() else { return }
        
        visibleCategories = dataProvider.getVisibleCategories()
        visibleCategories = visibleCategories.compactMap { category in
            let filterTrackers = category.trackerArray.filter { tracker in
                guard let schedule = tracker.schedule else { return false }
                let filterText = text.isEmpty || tracker.name.lowercased().contains(text)
                let trackerDate = dateService.getNumberOfSelectedDay(date: date)
                
                return schedule.contains(trackerDate) && filterText
            }
            
            if filterTrackers.isEmpty {
                return nil
            }
            
            return TrackerCategory(name: category.name,
                                   trackerArray: filterTrackers)
        }
    }
    
    func filterTrackersWithPinned(text: String?) {
        guard let date = currentDate,
              let text = text?.lowercased() else { return }
        
        getVisibleTrackersWithPinned()
        visibleCategories = visibleCategories.compactMap { category in
            let filterTrackers = category.trackerArray.filter { tracker in
                guard let schedule = tracker.schedule else { return false }
                let filterText = text.isEmpty || tracker.name.lowercased().contains(text)
                let trackerDate = dateService.getNumberOfSelectedDay(date: date)
                
                return schedule.contains(trackerDate) && filterText
            }
            
            if filterTrackers.isEmpty {
                return nil
            }
            
            return TrackerCategory(name: category.name,
                                   trackerArray: filterTrackers)
        }
    }
    
    func searchDifferentTrackers(visibleCategories: [TrackerCategory]?,
                                 completedCategories: [TrackerRecord]?) -> [TrackerCategory] {
        guard let visibleCategories = visibleCategories,
              let completedCategories = completedCategories else { return [] }
        
        return visibleCategories.compactMap { visibleCategory in
            let differentTrackers = visibleCategory.trackerArray.compactMap { visibleTracker in
                completedCategories.contains { $0.id == visibleTracker.id } ? nil : visibleTracker
            }
            
            return differentTrackers.isEmpty ? nil : TrackerCategory(name: visibleCategory.name, trackerArray: differentTrackers)
        }
    }
    
    private func searchSameTrackers(visible: [TrackerCategory]?,
                                    completed: [TrackerRecord]?) -> [TrackerCategory] {
        guard let visible = visible, let completed = completed else {
            return []
        }
        
        var result: [TrackerCategory] = []
        
        for visibleCategory in visible {
            var sameTrackers: [Tracker] = []
            
            for visibleTracker in visibleCategory.trackerArray {
                for completedTracker in completed {
                    if visibleTracker.id == completedTracker.id {
                        sameTrackers.append(visibleTracker)
                    }
                }
            }
            
            if !sameTrackers.isEmpty {
                var updatedCategory = visibleCategory
                updatedCategory.trackerArray = sameTrackers
                result.append(updatedCategory)
            }
        }
        
        return result
    }
    
    func updateVisibleTrackersWithFilterCompleted(visible: [TrackerCategory]?, completed: [TrackerRecord]?) {
        visibleCategories = searchSameTrackers(visible: visible, completed: completed)
    }
    
    func updateVisibleTrackersWithFilterUncompleted(visible: [TrackerCategory]?, completed: [TrackerRecord]?) {
        visibleCategories = searchDifferentTrackers(visibleCategories: visible, completedCategories: completed)
    }
    
    func changeCountOfPerfectDays(isAdd: Bool) {
        guard let date = currentDate else { return }
        let statisticService = StatisticService()

        isAdd ? statisticService.setNewPerfectDaysValue(date: date) : statisticService.removePerfectDays(date: date)
    }
    
    private func isPinnedTrackersExist() -> Bool {
        dataProvider.getVisibleCategories().contains(where: { $0.name == LocalizableConstants.TrackersVC.pinnedTrackers })
    }
    
    private func getVisibleTrackersWithPinned() {
        var trackerCategories = dataProvider.getVisibleCategories()
        
        if let index = trackerCategories.firstIndex(where: { $0.name == LocalizableConstants.TrackersVC.pinnedTrackers }) {
            let pinnedTrackers = trackerCategories[index]
            trackerCategories.remove(at: index)
            trackerCategories.insert(pinnedTrackers, at: 0)
            visibleCategories = trackerCategories
        } else {
            return
        }
    }
}
