import UIKit

final class CategoryTableViewCell: UITableViewCell {
    
    lazy var label: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 17, weight: .regular)
        element.textColor = .ypBlack
        return element
    }()
    
    var viewModel: String? {
        didSet {
            label.text = viewModel
        }
    }
    
    weak var delegate: CategoryTableViewCellDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .ypBackground
        setupView()
        addConstraints()
        addContextMenuInteraction()
    }
    
    private func editCategory(cell: CategoryTableViewCell) {
        delegate?.editCategory(cell)
    }
    
    private func deleteCategory(cell: CategoryTableViewCell) {
        delegate?.deleteCategory(cell)
    }
    
    private func setupView() {
        addSubview(label)
    }
    
    private func addConstraints() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(286)
        }
    }
}

extension CategoryTableViewCell: UIContextMenuInteractionDelegate {
    func addContextMenuInteraction() {
        let interaction = UIContextMenuInteraction(delegate: self)
        self.addInteraction(interaction)
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {

        let editImage = UIImage(systemName: "square.and.pencil")
        let deleteImage = UIImage(systemName: "trash")
        
        return UIContextMenuConfiguration(actionProvider: { actions in
            return UIMenu(children: [
                UIAction(title: LocalizableConstants.ContextMenu.editButton,
                         image: editImage) { [weak self] _ in
                    guard let self = self else { return }
                    self.editCategory(cell: self)
                },
                UIAction(title: LocalizableConstants.ContextMenu.deleteButton,
                         image: deleteImage,
                         attributes: .destructive) { [weak self] _ in
                    guard let self = self else { return }
                    self.deleteCategory(cell: self)
                }
            ])
        })
    }
}
