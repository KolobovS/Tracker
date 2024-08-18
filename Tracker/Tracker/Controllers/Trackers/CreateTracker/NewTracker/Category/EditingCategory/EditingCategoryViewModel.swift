import Foundation

final class EditingCategoryViewModel {
    private let dataProvider = DataProvider.shared
    
    var oldCategory: String?
    
    func editCategory(newCategory: String) {
        guard let oldCategory = oldCategory else { return }
        dataProvider.editCategory(oldCategory: oldCategory, newCategory: newCategory)
    }
}
