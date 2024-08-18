import Foundation

protocol ScheduleViewModelProtocol: AnyObject {
    func addDaysToSchedule(day: Int)
    func removeDayFromSchedule(index: Int)
    func isScheduleEmpty()
    func setSchedule()
}
