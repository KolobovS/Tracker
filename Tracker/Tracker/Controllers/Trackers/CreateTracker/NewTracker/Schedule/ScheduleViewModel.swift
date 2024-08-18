import Foundation

final class ScheduleViewModel: ScheduleViewModelProtocol {
    private let dataProvider = DataProvider.shared
    private let scheduleService = ScheduleService()
    private let analyticsService = AnalyticsService.shared
    
    @Observable
    private(set) var schedule: [Int] = []
    @Observable
    private(set) var checkScheduleForCreate = false
    
    init() {
        dataProvider.bindScheduleViewModel(controller: self)
    }
    
    func addDaysToSchedule(day: Int) {
        schedule.append(day)
        isScheduleEmpty()
    }
    
    func removeDayFromSchedule(index: Int) {
        schedule.remove(at: index)
        isScheduleEmpty()
    }
    
    func setSchedule() {
        let scheduleDay = schedule.count == 7 ? LocalizableConstants.ScheduleVC.everyDay : scheduleService.arrayToString(array: schedule)
        
        if scheduleDay == LocalizableConstants.ScheduleVC.everyDay {
            analyticsService.report(event: .click, screen: .scheduleVC, item: .everyDay)
        } else {
            analyticsService.report(event: .click, screen: .scheduleVC, item: .notEveryDay)
        }
        
        dataProvider.selectedSchedule = scheduleDay
        dataProvider.trackerSchedule = schedule
        
        schedule = []
    }
    
    func returnNumberOfDay(from index: IndexPath) -> Int {
        scheduleService.addDayToSchedule(day: Resourses.WeekDay.allCases[index.row].localizedString)
    }
    
    func isCurrentDayExistInSchedule(day: Int) -> Bool {
        dataProvider.isCurrentDayFromScheduleExist(day) ? true : false
    }
    
    func isScheduleEmpty() {
        checkScheduleForCreate = schedule.count == 0 ? false : true
    }
}
