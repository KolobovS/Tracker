import Foundation

protocol TrackerCollectionViewCellDelegate: AnyObject {
    func completeTracker(id: UUID, at indexPath: IndexPath)
    func uncompleteTracker(id: UUID, at indexPath: IndexPath)
    func pinTracker(_ cell: TrackersCollectionViewCell)
    func unpinTracker(_ cell: TrackersCollectionViewCell)
    func editTracker(_ cell: TrackersCollectionViewCell)
    func deleteTracker(_ cell: TrackersCollectionViewCell)
}
