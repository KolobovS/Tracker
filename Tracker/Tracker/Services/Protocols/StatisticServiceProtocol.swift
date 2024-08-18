import Foundation

protocol StatisticServiceProtocol: AnyObject {
    var statisticModel: TrackerStatistic? { get }
    func provideStatisticModel(record: [TrackerRecord]?)
    func removeAllStatistics()
}
