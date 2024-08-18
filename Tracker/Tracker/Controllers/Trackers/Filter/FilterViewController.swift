import UIKit

final class FilterViewController: UIViewController {
    
    private lazy var filterLabel: UILabel = {
        let element = UILabel()
        element.text = LocalizableConstants.FiltersVC.filtersTitle
        element.font = .systemFont(ofSize: 16, weight: .medium)
        element.textColor = .ypBlack
        return element
    }()
    
    private lazy var filterTableView: UITableView = {
        let element = UITableView()
        element.layer.cornerRadius = 16
        element.separatorStyle = .singleLine
        element.separatorColor = .ypGray
        element.isScrollEnabled = false
        return element
    }()
    
    private let analyticsService = AnalyticsService.shared
    private let filterViewModel = FilterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analyticsService.report(event: .open, screen: .filterVC, item: nil)
        addView()
        setupTableView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        analyticsService.report(event: .close, screen: .filterVC, item: nil)
    }
    
    private func setupTableView() {
        filterTableView.register(FilterTableViewCell.self, forCellReuseIdentifier: "FilterTableViewCell")
        filterTableView.dataSource = self
        filterTableView.delegate = self
    }
}

//MARK: UITableViewDataSource
extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as? FilterTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(text: Resourses.Filters.allCases[indexPath.row].localizedString)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        cell.accessoryType = cell.label.text == filterViewModel.getCurrentFilter() ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}

//MARK: UITableViewDelegate
extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FilterTableViewCell else { return }

        cell.accessoryType = cell.accessoryType == UITableViewCell.AccessoryType.none ? .checkmark : .none
        filterViewModel.setCurrentFilter(selected: cell.label.text ?? "")
        
        
        dismiss(animated: true)
    }
}

//MARK: SetupViews
extension FilterViewController {
    private func addView() {
        view.backgroundColor = .ypWhite
        view.addSubview(filterLabel)
        view.addSubview(filterTableView)
        addConstraints()
    }
    
    private func addConstraints() {
        filterLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.centerX.equalToSuperview()
        }
        
        filterTableView.snp.makeConstraints { make in
            make.top.equalTo(filterLabel.snp.bottom).offset(38)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(299)
        }
    }
}


