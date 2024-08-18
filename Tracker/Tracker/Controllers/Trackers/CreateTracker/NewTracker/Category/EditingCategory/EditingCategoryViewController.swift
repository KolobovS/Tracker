import UIKit

final class EditingCategoryViewController: UIViewController {
    private let editingCategoryView = EditingCategoryView()
    private let editingCategoryViewModel = EditingCategoryViewModel()
    private let analyticsService = AnalyticsService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analyticsService.report(event: .open, screen: .editingCategoryVC, item: nil)
        addView()
        setupTarget()
        editingCategoryView.textField.delegate = self
    }
    
    init(category: String) {
        super.init(nibName: nil, bundle: nil)
        self.setTextFieldPlaceholder(category)
        self.editingCategoryViewModel.oldCategory = category
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTextFieldPlaceholder(_ placeholder: String) {
        editingCategoryView.textField.placeholder = placeholder
    }
    
    private func setupTarget() {
        editingCategoryView.doneButton.addTarget(self, action: #selector(editCategory), for: .touchUpInside)
    }
    
    @objc private func editCategory() {
        guard let newCategory = editingCategoryView.textField.text else { return }
        
        editingCategoryViewModel.editCategory(newCategory: newCategory)
        
        analyticsService.report(event: .close, screen: .editingCategoryVC, item: nil)
        
        dismiss(animated: true)
    }
}

extension EditingCategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            editingCategoryView.doneButton.isEnabled = true
            editingCategoryView.doneButton.backgroundColor = .ypBlack
            editingCategoryView.doneButton.setTitleColor(.ypWhite, for: .normal)
            return true
        } else {
            editingCategoryView.doneButton.isEnabled = false
            editingCategoryView.doneButton.backgroundColor = .ypGray
            return true
        }
    }
}

//MARK: SetupViews
extension EditingCategoryViewController {
    private func addView() {
        view.backgroundColor = .ypWhite
        view.addSubview(editingCategoryView.titleLabel)
        view.addSubview(editingCategoryView.textField)
        view.addSubview(editingCategoryView.doneButton)
        addConstraints()
    }
    
    private func addConstraints() {
        editingCategoryView.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.centerX.equalToSuperview()
        }
        
        editingCategoryView.textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(editingCategoryView.titleLabel.snp.bottom).offset(38)
            make.height.equalTo(75)
        }
        
        editingCategoryView.doneButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
}
