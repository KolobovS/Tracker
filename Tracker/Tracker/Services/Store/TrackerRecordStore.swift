import UIKit
import CoreData

final class TrackerRecordStore: NSObject, TrackerRecordStoreProtocol {
    
    private let context: NSManagedObjectContext
    private var insertedIndexes: IndexSet?
    private var deletedIndexes: IndexSet?
    
    private let dataProvider = DataProvider.shared
    
    private lazy var appDelegate = {
        (UIApplication.shared.delegate as! AppDelegate)
    }()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<TrackerRecordCoreData> = {
        let fetchRequest = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: context,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        return fetchedResultsController
    }()
    
    convenience override init() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistantContainer.viewContext
        self.init(context: context)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addTrackerRecord(tracker: TrackerRecord) {
        if !isRecordExist(tracker: tracker) {
            let record = TrackerRecordCoreData(context: context)
            record.id = tracker.id
            record.date = tracker.date
            
            appDelegate.saveContext()
        }
    }
    
    func deleteTrackerRecord(tracker: TrackerRecord) {
        guard let objects = fetchedResultsController.fetchedObjects else { return }
        
        var deletingRecord: TrackerRecordCoreData?
        
        if isRecordExist(tracker: tracker) {
            objects.forEach { record in
                let isSameDay = Calendar.current.isDate(tracker.date, inSameDayAs: record.date ?? Date())
                if record.id == tracker.id && isSameDay {
                    deletingRecord = record
                }
            }
            
            guard let object = try? context.existingObject(with: deletingRecord?.objectID ?? NSManagedObjectID()) else { return }
            
            context.delete(object)
            appDelegate.saveContext()
        }
    }
    
    func fetchTrackerRecords() -> [TrackerRecord] {
        guard let records = fetchedResultsController.fetchedObjects else { return [] }
        
        var currentRecord: [TrackerRecord] = []
        
        for record in records {
            currentRecord.append(TrackerRecord(id: record.id ?? UUID(),
                                               date: record.date ?? Date()))
        }
        return currentRecord
    }
    
    func isRecordExist(tracker: TrackerRecord) -> Bool {
        guard let objects = fetchedResultsController.fetchedObjects else { return false }
        
        var result = false
        
        objects.forEach { object in
            let isSameDay = Calendar.current.isDate(tracker.date, inSameDayAs: object.date ?? Date())
            if object.id == tracker.id && isSameDay {
                result = true
            }
        }
        return result
    }
}

extension TrackerRecordStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        dataProvider.fetchRecordFromStore()
    }
}
