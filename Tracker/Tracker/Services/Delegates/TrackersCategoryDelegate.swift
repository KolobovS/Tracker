import Foundation

protocol TrackersCategoryDelegate: AnyObject {
    func didUpdate(update: CollectionStoreUpdate)
}
