import Foundation

protocol TrackerCategoryStoreProtocol: AnyObject {
    var numberOfCategories: Int { get }
    func numberOfRowsInSection(section: Int) -> Int
    func addCategory(category: String)
    func editCategory(oldCategory: String, newCategory: String)
    func deleteCategory(category: String)
    func isCategoryExist(category: String) -> Bool
    func fetchCategoryName(index: Int) -> String
    func fetchNewCategoryName(name: String) -> TrackerCategoryCoreData?
    func getCategoriesNames() -> [String]
}
