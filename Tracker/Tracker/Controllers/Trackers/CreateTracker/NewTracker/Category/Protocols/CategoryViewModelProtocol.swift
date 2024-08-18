import Foundation

protocol CategoryViewModelProtocol: AnyObject {
    var selectedCategory: String { get set }
    func getVisibleCategories()
}
