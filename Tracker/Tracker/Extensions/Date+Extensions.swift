import Foundation

extension Date {
    public var withZeroTime: Date {
        Calendar.current.startOfDay(for: self)
    }
}
