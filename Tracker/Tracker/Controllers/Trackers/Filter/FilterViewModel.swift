import Foundation

final class FilterViewModel {
    private let dataProvider = DataProvider.shared
    private let analyticsService = AnalyticsService.shared
    
    func getCurrentFilter() -> String {
        dataProvider.currentFilter ?? ""
    }
    
    func setCurrentFilter(selected: String) {
        dataProvider.currentFilter = selected
        var eventName: Item
        
        switch selected {
        case Resourses.Filters.allTrackers.localizedString:
            eventName = Item.allTrackers
        case Resourses.Filters.todayTrackers.localizedString:
            eventName = Item.todaysTrackers
        case Resourses.Filters.completed.localizedString:
            eventName = Item.completedTrackers
        case Resourses.Filters.uncompleted.localizedString:
            eventName = Item.uncompletedTrackers
        default:
            return
        }
        
        analyticsService.report(event: .click, screen: .filterVC, item: eventName)
    }
}
