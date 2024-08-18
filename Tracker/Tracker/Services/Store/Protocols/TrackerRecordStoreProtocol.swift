import Foundation

protocol TrackerRecordStoreProtocol: AnyObject {
    func addTrackerRecord(tracker: TrackerRecord)
    func deleteTrackerRecord(tracker: TrackerRecord)
    func fetchTrackerRecords() -> [TrackerRecord]
}
