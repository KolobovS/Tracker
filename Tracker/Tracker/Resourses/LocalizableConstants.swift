import Foundation

enum LocalizableConstants {
    enum Onboarding {
        static let firstOnboardingTitle = NSLocalizedString("onboarding.firstPageTitle", comment: "")
        static let secondOnboardingTitle = NSLocalizedString("onboarding.secondPageTitle", comment: "")
        static let onboardingContinueButton = NSLocalizedString("onboarding.continueButton", comment: "")
    }
    
    enum TabBar {
        static let trackersTabBarTitle = NSLocalizedString("tabBar.trackersTabBarTitle", comment: "")
        static let statisticTabBarTitle = NSLocalizedString("tabBar.statisticTabBarTitle", comment: "")
    }
    
    enum StatisticVC {
        static let statisticsNavigationTitle = NSLocalizedString("statisticsVC.navigationTitle", comment: "")
        static let emptyStateLabel = NSLocalizedString("statisticsVC.emptyStateLabel", comment: "")
        static let bestPeriod = NSLocalizedString("statisticVC.bestPeriod", comment: "")
        static let perfectDays = NSLocalizedString("statisticVC.perfectDays", comment: "")
        static let totalCompletedTrackers = NSLocalizedString("statisticVC.totalCompletedTrackers", comment: "")
        static let averageValue = NSLocalizedString("statisticVC.averageValue", comment: "")
    }
    
    enum TrackersVC {
        static let trackersNavigationTitle = NSLocalizedString("trackersVC.navigationTitle", comment: "")
        static let pinnedTrackers = NSLocalizedString("trackersVC.pinnedTrackers", comment: "")
        static let textFieldPlaceholder = NSLocalizedString("trackersVC.textFieldPlaceholder", comment: "")
        static let cancelButton = NSLocalizedString("trackersVC.cancelButton", comment: "")
        static let filterButton = NSLocalizedString("trackersVC.filterButton", comment: "")
        static let nothingFoundLabel = NSLocalizedString("trackersVC.nothingFoundLabel", comment: "")
        static let emptyStateLabel = NSLocalizedString("trackersVC.emptyStateLabel", comment: "")
        static func formatDaysString(_ days: Int) -> String {
            String.localizedStringWithFormat(NSLocalizedString("numberOfDays", comment: ""), days)
        }
    }
    
    enum FiltersVC {
        static let filtersTitle = NSLocalizedString("filtersVC.filtersTitle", comment: "")
    }
    
    enum CreateTrackerVC {
        static let createTrackerLabel = NSLocalizedString("createTrackerVC.createTrackerLabel", comment: "")
        static let habitLabel = NSLocalizedString("createTrackerVC.habitLabel", comment: "")
        static let unregularEventLabel = NSLocalizedString("createTrackerVC.unregularEventLabel", comment: "")
    }
    
    enum NewTrackerVC {
        static let newHabitLabel = NSLocalizedString("newTrackerVC.newHabitLabel", comment: "")
        static let newUnregularEventLabel = NSLocalizedString("newTrackerVC.newUnregularEventLabel", comment: "")
        static let textFieldPlaceholder = NSLocalizedString("newTrackerVC.textFieldPlaceholder", comment: "")
        static let textFieldWarning = NSLocalizedString("newTrackerVC.textFieldWarning", comment: "")
        static let tableViewCategoryLabel = NSLocalizedString("newTrackerVC.tableViewCategoryLabel", comment: "")
        static let tableViewScheduleLabel = NSLocalizedString("newTrackerVC.tableViewScheduleLabel", comment: "")
        static let cancelButton = NSLocalizedString("newTrackerVC.cancelButton", comment: "")
        static let createButton = NSLocalizedString("newTrackerVC.createButton", comment: "")
        static let emojiLabel = NSLocalizedString("newTrackerVC.emojiLabel", comment: "")
        static let colorLabel = NSLocalizedString("newTrackerVC.colorLabel", comment: "")
    }
    
    enum EditingTrackerVC {
        static let editTitle = NSLocalizedString("editingTrackerVC.editTitle", comment: "")
        static let saveButton = NSLocalizedString("editingTrackerVC.saveButton", comment: "")
    }
    
    enum CategoryVC {
        static let categoryTitle = NSLocalizedString("categoryVC.categoryTitle", comment: "")
        static let emptyStateLabel = NSLocalizedString("categoryVC.emptyStateLabel", comment: "")
        static let addCategoryButton = NSLocalizedString("categoryVC.addCategoryButton", comment: "")
    }
    
    enum EditingCategoryVC {
        static let titleLabel = NSLocalizedString("editingCategoryVC.editingCategoryTitle", comment: "")
        static let doneButton = NSLocalizedString("editingCategoryVC.doneButton", comment: "")
    }
    
    enum NewCategoryVC {
        static let newCategoryTitle = NSLocalizedString("newCategoryVC.newCategoryTitle", comment: "")
        static let textFieldPlaceholder = NSLocalizedString("newCategoryVC.textFieldPlaceholder", comment: "")
        static let doneButton = NSLocalizedString("newCategoryVC.doneButton", comment: "")
    }
    
    enum ScheduleVC {
        static let scheduleTitle = NSLocalizedString("scheduleVC.scheduleTitle", comment: "")
        static let doneButton = NSLocalizedString("scheduleVC.doneButton", comment: "")
        
        static let monday = NSLocalizedString("scheduleVC.monday", comment: "")
        static let tuesday = NSLocalizedString("scheduleVC.tuesday", comment: "")
        static let wednesday = NSLocalizedString("scheduleVC.wednesday", comment: "")
        static let thursday = NSLocalizedString("scheduleVC.thursday", comment: "")
        static let friday = NSLocalizedString("scheduleVC.friday", comment: "")
        static let saturday = NSLocalizedString("scheduleVC.saturday", comment: "")
        static let sunday = NSLocalizedString("scheduleVC.sunday", comment: "")
        static let everyDay = NSLocalizedString("scheduleVC.everyDay", comment: "")
        
        static let mondayShort = NSLocalizedString("scheduleVC.mondayShort", comment: "")
        static let tuesdayShort = NSLocalizedString("scheduleVC.tuesdayShort", comment: "")
        static let wednesdayShort = NSLocalizedString("scheduleVC.wednesdayShort", comment: "")
        static let thursdayShort = NSLocalizedString("scheduleVC.thursdayShort", comment: "")
        static let fridayShort = NSLocalizedString("scheduleVC.fridayShort", comment: "")
        static let saturdayShort = NSLocalizedString("scheduleVC.saturdayShort", comment: "")
        static let sundayShort = NSLocalizedString("scheduleVC.sundayShort", comment: "")
    }
    
    enum ContextMenu {
        static let pinButton = NSLocalizedString("contextMenu.pinButton", comment: "")
        static let unpinButton = NSLocalizedString("contextMenu.unpinButton", comment: "")
        static let editButton = NSLocalizedString("contextMenu.editButton", comment: "")
        static let deleteButton = NSLocalizedString("contextMenu.deleteButton", comment: "")
    }
    
    enum Alert {
        static let removeTrackerTitle = NSLocalizedString("alert.removeTracker.title", comment: "")
        static let removeCategoryTitle = NSLocalizedString("alert.removeCategory.title", comment: "")
        static let removeCategoryMessage = NSLocalizedString("alert.removeCategory.message", comment: "")
        static let cancel = NSLocalizedString("alert.cancel", comment: "")
        static let delete = NSLocalizedString("alert.delete", comment: "")
    }
}
