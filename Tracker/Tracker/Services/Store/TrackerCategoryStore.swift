import UIKit
import CoreData

final class TrackerCategoryStore: NSObject, TrackerCategoryStoreProtocol {
    
    private let context: NSManagedObjectContext
    private var insertedIndexes: IndexSet?
    private var deletedIndexes: IndexSet?
    
    private let dataProvider = DataProvider.shared
    
    weak var delegate: TrackersCategoryDelegate?
    
    private lazy var appDelegate = {
        (UIApplication.shared.delegate as! AppDelegate)
    }()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<TrackerCategoryCoreData> = {
        let fetchRequest = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
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
    
    var numberOfCategories: Int {
        fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func getCategoriesNames() -> [String] {
        guard let allCategoriesNames = fetchedResultsController.fetchedObjects else { return [] }
        
        return allCategoriesNames.map { $0.name ?? "" }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard let trackers = fetchedResultsController.fetchedObjects?[section].trackers else { return 0 }
        return trackers.count
    }
    
    func addCategory(category: String) {
        if !isCategoryExist(category: category) {
            let cat = TrackerCategoryCoreData(context: context)
            cat.name = category
            
            appDelegate.saveContext()
        }
    }
    
    func editCategory(oldCategory: String, newCategory: String) {
        guard let object = fetchedResultsController.fetchedObjects?.first(where: { $0.name == oldCategory }) else { return }
        object.name = newCategory
        
        appDelegate.saveContext()
    }
    
    func deleteCategory(category: String) {
        guard let object = fetchedResultsController.fetchedObjects?.first(where: { $0.name == category }) else { return }
        context.delete(object)
        appDelegate.saveContext()
    }
    
    func isCategoryExist(category: String) -> Bool {
        guard let categories = fetchedResultsController.fetchedObjects else { return false }
        
        var categoryString = ""
        
        for cat in categories {
            if cat.name == category {
                categoryString = category
            }
        }
        
        return categoryString.isEmpty ? false : true
    }
    
    func fetchCategoryName(index: Int) -> String {
        guard let category = fetchedResultsController.fetchedObjects?[index] else { return "" }
        
        return category.name ?? ""
    }
    
    func fetchNewCategoryName(name: String) -> TrackerCategoryCoreData? {
        var cat: TrackerCategoryCoreData?
        
        if let categories = fetchedResultsController.fetchedObjects {
            categories.forEach { category in
                if category.name == name {
                    cat = category
                }
            }
        }
        
        return cat
    }
}

extension TrackerCategoryStore: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        insertedIndexes = IndexSet()
        deletedIndexes = IndexSet()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        dataProvider.getCategoryName()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                insertedIndexes?.insert(indexPath.item)
            }
        case .delete:
            if let indexPath = indexPath {
                deletedIndexes?.insert(indexPath.item)
            }
        default:
            break
        }
    }
}
