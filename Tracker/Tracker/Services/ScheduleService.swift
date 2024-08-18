import Foundation

final class ScheduleService {
    
    func arrayToString(array: [Int]) -> String {
        var result = array
        
        if result.contains(1) {
            let sorted = result.filter { $0 != 1 }.sorted()
            result = sorted + [1]
        } else {
            result = array.sorted()
        }
        
        let shortNames = result.map { changeDayToShortName(day: $0) }
        let finalString = shortNames.joined(separator: ", ")

        return finalString
    }
    
    func addDayToSchedule(day: String) -> Int {
        switch day {
        case LocalizableConstants.ScheduleVC.monday:
            return 2
        case LocalizableConstants.ScheduleVC.tuesday:
            return 3
        case LocalizableConstants.ScheduleVC.wednesday:
            return 4
        case LocalizableConstants.ScheduleVC.thursday:
            return 5
        case LocalizableConstants.ScheduleVC.friday:
            return 6
        case LocalizableConstants.ScheduleVC.saturday:
            return 7
        case LocalizableConstants.ScheduleVC.sunday:
            return 1
        default:
            return 0
        }
    }
    
    func changeDayToShortName(day: Int) -> String {
        switch day {
        case 1:
            return LocalizableConstants.ScheduleVC.sundayShort
        case 2:
            return LocalizableConstants.ScheduleVC.mondayShort
        case 3:
            return LocalizableConstants.ScheduleVC.tuesdayShort
        case 4:
            return LocalizableConstants.ScheduleVC.wednesdayShort
        case 5:
            return LocalizableConstants.ScheduleVC.thursdayShort
        case 6:
            return LocalizableConstants.ScheduleVC.fridayShort
        case 7:
            return LocalizableConstants.ScheduleVC.saturdayShort
        default:
            return ""
        }
    }
}
