import UIKit

enum Resourses {
    enum Images {
        static let statisticEmptyImage = UIImage(named: "statisticEmptyImage")
        static let trackerEmptyImage = UIImage(named: "trackerEmptyImage")
        static let searchEmptyImage = UIImage(named: "searchEmptyImage")
        static let firstPageOfOnboarding = UIImage(named: "firstPageOfOnboarding")
        static let secondPageOfOnboarding = UIImage(named: "secondPageOfOnboarding")
    }
    
    enum WeekDay: String, CaseIterable {
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        case sunday
        
        var localizedString: String {
            return NSLocalizedString("scheduleVC." + self.rawValue, comment: "")
        }
    }
    
    enum Filters: String, CaseIterable {
        case allTrackers
        case todayTrackers
        case completed
        case uncompleted
        
        var localizedString: String {
            return NSLocalizedString("filtersVC." + self.rawValue, comment: "")
        }
    }
}
