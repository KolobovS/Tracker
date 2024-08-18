import Foundation

protocol CategoryTableViewCellDelegate: AnyObject {
    func editCategory(_ cell: CategoryTableViewCell)
    func deleteCategory(_ cell: CategoryTableViewCell)
}
