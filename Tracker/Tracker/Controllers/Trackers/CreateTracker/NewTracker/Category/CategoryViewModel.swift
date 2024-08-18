import Foundation

final class CategoryViewModel: CategoryViewModelProtocol {
    
    private let dataProvider = DataProvider.shared
    
    @Observable
    private(set) var visibleCategories: [String] = []
    
    init() {
        dataProvider.bindCategoryViewModel(controller: self)
        getVisibleCategories()
    }
    
    var numberOfCategories: Int {
        visibleCategories.count
    }
    
    var selectedCategory: String {
        get {
            dataProvider.selectedCategory ?? ""
        }
        set {
            dataProvider.selectedCategory = newValue
        }
    }
    
    func areVisibleCategoriesEmpty() -> Bool {
        if numberOfCategories == 0 {
            return true
        } else {
            return false
        }
    }
    
    func isLastCategory(at indexPath: IndexPath) -> Bool {
        if numberOfCategories == indexPath.row + 1 {
            return true
        } else {
            return false
        }
    }
    
    func getVisibleCategories() {
        var categories = dataProvider.updateCategoryViewModel()
        if let index = categories.firstIndex(where: { $0 == LocalizableConstants.TrackersVC.pinnedTrackers }) {
            categories.remove(at: index)
        }
        
        visibleCategories = categories
    }
    
    func deleteCategory(category: String) {
        dataProvider.deleteCategory(category: category)
    }
}
