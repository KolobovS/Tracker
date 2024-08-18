import Foundation
import YandexMobileMetrica

enum Events: String {
    case open
    case close
    case click
}

enum Screen: String {
    case main
    case createTrackerVC
    case newTrackerVC
    case categoryVC
    case newCategoryVC
    case scheduleVC
    case statisticVC
    case editingCategoryVC
    case editingTrackerVC
    case filterVC
}

enum Item: String {
    // TrackerVC:
    case add_track
    case track
    case filter
    case edit
    case delete
    
    // CreateTrackerVC:
    case habit
    case unregularEvent
    
    // NewTrackerVC:
    case category
    case schedule
    case emoji
    case color
    case create
    case cancel
    
    // Category:
    case newCategory
    
    // Schedule:
    case everyDay
    case notEveryDay
    
    // FilterVC:
    case allTrackers
    case todaysTrackers
    case completedTrackers
    case uncompletedTrackers
}

final class AnalyticsService {
    
    static let shared = AnalyticsService()
    
    func activate() {
        guard let configuration = YMMYandexMetricaConfiguration(apiKey: "24060cb4-dd1c-4549-b83d-37719151b5b7") else { return }
        
        YMMYandexMetrica.activate(with: configuration)
    }
    
    func report(event: Events, screen: Screen, item: Item?) {
        var params: [AnyHashable: Any] = [:]
        
        if item == nil {
            params = ["event": event.rawValue, "screen": screen.rawValue]
        } else {
            guard let item = item else { return }
            params = ["event": event.rawValue, "screen": screen.rawValue, "item": item.rawValue]
        }
        YMMYandexMetrica.reportEvent("EVENT", parameters: params, onFailure: { error in
            print("REPORT ERROR: %@", error.localizedDescription)
        })
    }
}
