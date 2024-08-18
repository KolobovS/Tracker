import UIKit

final class TrackersViewController: UIViewController, TrackerViewControllerProtocol {
    
    private(set) var trackersView = TrackersView()
    private let trackersViewModel = TrackersViewModel()
    private let alertService = AlertService()
    private let analyticsService = AnalyticsService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analyticsService.report(event: .open, screen: .main, item: nil)
        addViews()
        setupViews()
        setupNavigationController()
        addTarget()
        setupTrackersFromDatePicker()
        bindViewModel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        analyticsService.report(event: .close, screen: .main, item: nil)
    }
    
    func bindViewModel() {
        trackersViewModel.$visibleCategories.bind { [weak self] _ in
            guard let self = self else { return }
            self.reloadViews()
        }
        
        trackersViewModel.$needChangeDate.bind { [weak self] value in
            guard let self = self else { return }
            
            if value == true {
                self.trackersView.datePicker.date = Date()
                self.trackersViewModel.currentDate = self.trackersView.datePicker.date
                self.trackersViewModel.filterTrackers(text: "")
            }
        }
    }

    private func setupViews() {
        trackersView.trackersCollectionView.register(TrackersCollectionViewCell.self, forCellWithReuseIdentifier: "TrackerCollectionViewCell")
        trackersView.trackersCollectionView.register(TrackersSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        trackersView.trackersCollectionView.dataSource = self
        trackersView.trackersCollectionView.delegate = self
        
        trackersView.searchTextField.delegate = self
    }
    
    private func setupNavigationController() {
        guard let navBar = navigationController?.navigationBar else { return }
        let leftButton = UIBarButtonItem(barButtonSystemItem: .add,
                                         target: self,
                                         action: #selector(addNewTracker))
        leftButton.tintColor = .ypBlack
        navBar.topItem?.setLeftBarButton(leftButton, animated: false)
    }
    
    func reloadViews() {
        trackersViewModel.areVisibleCategoriesEmpty() ? addEmptyViews() : reloadCollectionView()
    }
    
    private func addEmptyViews() {
        trackersView.trackersCollectionView.removeFromSuperview()
        trackersView.filterButton.removeFromSuperview()
        view.addSubview(trackersView.emptyImage)
        view.addSubview(trackersView.emptyLabel)
        trackersView.emptyImage.image = trackersViewModel.emptyImage
        trackersView.emptyLabel.text = trackersViewModel.emptyLabel
        
        trackersView.emptyImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        trackersView.emptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(trackersView.emptyImage.snp.bottom).offset(8)
        }
    }
    
    private func reloadCollectionView() {
        trackersView.emptyImage.removeFromSuperview()
        trackersView.emptyLabel.removeFromSuperview()
        view.addSubview(trackersView.trackersCollectionView)
        view.addSubview(trackersView.filterButton)
        
        trackersView.trackersCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(trackersView.searchTextField.snp.bottom).offset(10)
        }
        
        trackersView.filterButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-17)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(114)
        }
        trackersView.trackersCollectionView.reloadData()
    }

    @objc private func addNewTracker() {
        let newtrackerVC = CreateTrackerViewController()
        newtrackerVC.viewController = self
        trackersView.searchTextField.text = .none
        trackersView.searchTextField.endEditing(true)
        analyticsService.report(event: .click, screen: .main, item: .add_track)
        present(newtrackerVC, animated: true)
    }
    
    private func addTarget() {
        trackersView.filterButton.addTarget(self, action: #selector(switchToFilterViewController), for: .touchUpInside)
        trackersView.searchTextField.addTarget(self, action: #selector(addCancelButton), for: .editingDidBegin)
        trackersView.searchTextField.addTarget(self, action: #selector(setupTrackersFromTextField), for: [.editingChanged, .editingDidEnd])
        trackersView.cancelButton.addTarget(self, action: #selector(removeCancelButton), for: .touchUpInside)
        trackersView.datePicker.addTarget(self, action: #selector(setupTrackersFromDatePicker), for: .valueChanged)
    }
    
    @objc private func switchToFilterViewController() {
        let filterVC = FilterViewController()
        analyticsService.report(event: .click, screen: .main, item: .filter)
        present(filterVC, animated: true)
    }
    
    @objc private func addCancelButton() {
        view.addSubview(trackersView.cancelButton)
        trackersView.searchTextField.snp.removeConstraints()
        
        trackersView.cancelButton.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(trackersView.searchTextField)
        }
        
        trackersView.searchTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(36)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(trackersView.cancelButton.snp.leading).offset(-5)
        }
    }

    @objc private func removeCancelButton() {
        trackersView.searchTextField.text = .none
        trackersView.searchTextField.endEditing(true)
        trackersView.cancelButton.removeFromSuperview()
        trackersView.searchTextField.snp.removeConstraints()
        
        trackersView.searchTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(36)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        setupTrackersFromDatePicker()
    }
    
    @objc func setupTrackersFromDatePicker() {
        trackersViewModel.currentDate = trackersView.datePicker.date
        reloadViews()
    }
    
    @objc private func setupTrackersFromTextField() {
        trackersViewModel.searchText = trackersView.searchTextField.text
        reloadViews()
    }
    
    private func isPerfectDayToday() {
        var counter = 0
        for trackerCell in trackersView.trackersCollectionView.visibleCells {
            guard let trackerCell = trackerCell as? TrackersCollectionViewCell else { return }
            if trackerCell.isCompleted == true {
                counter += 1
            } else {
                counter -= 1
            }
        }

        if counter == trackersView.trackersCollectionView.visibleCells.count {
            trackersViewModel.changeCountOfPerfectDays(isAdd: true)
        } else {
            trackersViewModel.changeCountOfPerfectDays(isAdd: false)
        }
    }
}

//MARK: UICollectionViewDataSource
extension TrackersViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return trackersViewModel.numberOfVisibleCategories
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let visibleCategories = trackersViewModel.visibleCategories
        
        return visibleCategories[section].trackerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        trackersViewModel.fetchCompletedCategoriesFromStore()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackerCollectionViewCell", for: indexPath) as? TrackersCollectionViewCell else { return UICollectionViewCell() }
        let records = trackersViewModel.getCompletedCategories()
        let visibleCategories = trackersViewModel.visibleCategories
        let sectionName = visibleCategories[indexPath.section].name
        let tracker = visibleCategories[indexPath.section].trackerArray[indexPath.row]
        
        cell.delegate = self
        
        let isCompletedToday = isTrackerCompletedToday(id: tracker.id)
        
        let completedDays = records.filter { $0.id == tracker.id }.count

        cell.configureCell(tracker: tracker,
                           isCompleted: isCompletedToday,
                           completedDays: completedDays,
                           indexPath: indexPath)
        cell.isTrackerPined = sectionName == LocalizableConstants.TrackersVC.pinnedTrackers ? true : false
        cell.pinnedImage.isHidden = sectionName == LocalizableConstants.TrackersVC.pinnedTrackers ? false : true
        
        if trackersViewModel.checkDate() {
            cell.unlockDoneButton()
        } else {
            cell.lockDoneButton()
        }
        
        return cell
    }
    
    private func isTrackerCompletedToday(id: UUID) -> Bool {
        let completedTrackers = trackersViewModel.getCompletedCategories()
        
        return completedTrackers.contains { trackerRecord in
            let isSameDay = Calendar.current.isDate(trackerRecord.date, inSameDayAs: trackersView.datePicker.date)
            return trackerRecord.id == id && isSameDay
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let visibleCategories = trackersViewModel.visibleCategories
        
        var id: String
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            id = "header"
        default:
            id = ""
        }
        
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: id,
                                                                         for: indexPath) as? TrackersSupplementaryView else { return UICollectionReusableView() }
        view.headerLabel.text = visibleCategories[indexPath.section].name
    
        return view
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 41) / 2, height: 148)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: collectionView.frame.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
}

//MARK: TrackerCollectionViewCellDelegate
extension TrackersViewController: TrackerCollectionViewCellDelegate {
    func completeTracker(id: UUID, at indexPath: IndexPath) {
        let trackerRecord = TrackerRecord(id: id, date: trackersView.datePicker.date)
        trackersViewModel.addRecord(tracker: trackerRecord)
        
        analyticsService.report(event: .click, screen: .main, item: .track)
        trackersView.trackersCollectionView.reloadItems(at: [indexPath])
        isPerfectDayToday()
    }
    
    func uncompleteTracker(id: UUID, at indexPath: IndexPath) {
        let trackerRecord = TrackerRecord(id: id, date: trackersView.datePicker.date)
        trackersViewModel.deleteRecord(tracker: trackerRecord)
        
        trackersView.trackersCollectionView.reloadItems(at: [indexPath])
        isPerfectDayToday()
    }
    
    func pinTracker(_ cell: TrackersCollectionViewCell) {
        guard let indexPath = trackersView.trackersCollectionView.indexPath(for: cell) else { return }
        
        let trackerID = trackersViewModel.visibleCategories[indexPath.section].trackerArray[indexPath.row].id
        
        trackersViewModel.pinTracker(id: trackerID)
    }
    
    func unpinTracker(_ cell: TrackersCollectionViewCell) {
        guard let indexPath = trackersView.trackersCollectionView.indexPath(for: cell) else { return }
        
        let trackerID = trackersViewModel.visibleCategories[indexPath.section].trackerArray[indexPath.row].id
        
        trackersViewModel.unpinTracker(id: trackerID)
    }
    
    func editTracker(_ cell: TrackersCollectionViewCell) {
        guard let trackerInfo = cell.trackerInfo,
              let completedDays = cell.completedDays,
              let indexPath = cell.indexPath else { return }
        
        let editTrackerVC = NewTrackerViewController(typeOfTracker: .habit)
        let category = trackersViewModel.visibleCategories[indexPath.section].name
        
        editTrackerVC.setupTargets()
        editTrackerVC.setupEditingVC()
        editTrackerVC.editingTrackerInfo(tracker: trackerInfo, completedDays: completedDays, category: category)
        
        analyticsService.report(event: .click, screen: .main, item: .edit)
        present(editTrackerVC, animated: true)
    }
    
    func deleteTracker(_ cell: TrackersCollectionViewCell) {
        alertService.showAlert(event: .removeTracker, controller: self) { [weak self] in
            guard let self = self,
                  let indexPath = self.trackersView.trackersCollectionView.indexPath(for: cell) else { return }
            
            let visibleCategories = self.trackersViewModel.visibleCategories
            let tracker = visibleCategories[indexPath.section].trackerArray[indexPath.row]
            
            self.trackersViewModel.deleteTracker(id: tracker.id)
            self.analyticsService.report(event: .click, screen: .main, item: .delete)
            self.setupTrackersFromDatePicker()
        }
    }
}

//MARK: UITextFieldDelegate
extension TrackersViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

//MARK: SetupViews
extension TrackersViewController {
    private func addViews() {
        guard let navBar = navigationController?.navigationBar else { return }
        view.backgroundColor = .ypWhite
        view.addSubview(trackersView.searchTextField)
        navBar.addSubview(trackersView.datePicker)
        addConstraints()
    }
    
    private func addConstraints() {
        guard let navBar = navigationController?.navigationBar else { return }
        
        trackersView.datePicker.snp.makeConstraints { make in
            make.height.equalTo(34)
            make.width.equalTo(100)
            make.trailing.equalTo(navBar.snp.trailing).offset(-16)
            make.top.equalTo(navBar.snp.top).offset(5)
        }
        
        trackersView.searchTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(36)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}
