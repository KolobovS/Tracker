import UIKit

final class CategoryViewController: UIViewController, CategoryViewControllerProtocol {
    
    var viewController: NewTrackerViewControllerProtocol?
    private(set) var categoryView = CategoryView()
    private let dataProvider = DataProvider.shared
    private let analyticsService = AnalyticsService.shared
    private let categoryViewModel = CategoryViewModel()
    private let alertService = AlertService()
    private var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        addTarget()
        setupTableView()
        reloadViews()
        bindViewModel()
    }
    
    private func bindViewModel() {
        categoryViewModel.$visibleCategories.bind { [weak self] _ in
            guard let self = self else { return }
            self.reloadViews()
        }
    }
    
    private func addTarget() {
        categoryView.addCategoryButton.addTarget(self, action: #selector(switchToNewCategoryViewController), for: .touchUpInside)
    }
    
    @objc private func switchToNewCategoryViewController() {
        let newCategoryVC = NewCategoryViewController()
        newCategoryVC.viewController = self
        present(newCategoryVC, animated: true)
    }
    
    private func setupTableView() {
        categoryView.categoryTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        categoryView.categoryTableView.dataSource = self
        categoryView.categoryTableView.delegate = self
    }
    
    func reloadViews() {
        categoryViewModel.areVisibleCategoriesEmpty() ? reloadEmptyViews() : reloadTableView()
    }
    
    private func reloadEmptyViews() {
        view.addSubview(categoryView.emptyImage)
        view.addSubview(categoryView.emptyLabel)
        categoryView.categoryTableView.removeFromSuperview()

        categoryView.emptyImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        categoryView.emptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(categoryView.emptyImage.snp.bottom).offset(8)
        }
    }
    
    private func reloadTableView() {
        categoryView.emptyImage.removeFromSuperview()
        categoryView.emptyLabel.removeFromSuperview()
        view.addSubview(categoryView.categoryTableView)

        categoryView.categoryTableView.snp.makeConstraints { make in
            make.top.equalTo(categoryView.categoryLabel.snp.bottom).offset(38)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(categoryView.addCategoryButton.snp.top).offset(-16)
        }
        categoryView.categoryTableView.reloadData()
    }
    
    private func switchToEditingVC(_ category: String) {
        let editingVC = EditingCategoryViewController(category: category)
        present(editingVC, animated: true)
    }
}

//MARK: UITableViewDataSource
extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryViewModel.numberOfCategories
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        
        cell.viewModel = categoryViewModel.visibleCategories[indexPath.row]
        cell.delegate = self
        
        cell.accessoryType = cell.label.text == categoryViewModel.selectedCategory ? .checkmark : .none
        
        if categoryViewModel.isLastCategory(at: indexPath) {
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.separatorInset = UIEdgeInsets(top: 0, left: 400, bottom: 0, right: 0)
        } else {
            cell.layer.cornerRadius = 0
            cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}

//MARK: UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let selectedIndexPath = selectedIndexPath {
            if let selectedCell = tableView.cellForRow(at: selectedIndexPath) as? CategoryTableViewCell {
                selectedCell.accessoryType = .none

                if selectedIndexPath == indexPath {
                    self.selectedIndexPath = nil
                    return
                }
            }
        }

        if let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell {
            cell.accessoryType = .checkmark
            selectedIndexPath = indexPath

            categoryViewModel.selectedCategory = cell.label.text ?? ""
            viewController?.reloadTableView()
            dismiss(animated: true)
        }
    }
}

extension CategoryViewController: CategoryTableViewCellDelegate {
    func editCategory(_ cell: CategoryTableViewCell) {
        guard let category = cell.label.text else { return }
        analyticsService.report(event: .click, screen: .categoryVC, item: .edit)
        switchToEditingVC(category)
    }
    
    func deleteCategory(_ cell: CategoryTableViewCell) {
        alertService.showAlert(event: .removeCategory, controller: self) { [weak self] in
            guard let self = self,
                  let category = cell.label.text else { return }
            self.analyticsService.report(event: .click, screen: .categoryVC, item: .delete)
            self.categoryViewModel.deleteCategory(category: category)
        }
    }
}

//MARK: SetupViews
extension CategoryViewController {
    private func addView() {
        view.backgroundColor = .ypWhite
        view.addSubview(categoryView.categoryLabel)
        view.addSubview(categoryView.addCategoryButton)
        addConstraints()
    }
    
    private func addConstraints() {
        categoryView.categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.centerX.equalToSuperview()
        }
        
        categoryView.addCategoryButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
}
