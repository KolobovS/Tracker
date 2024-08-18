import UIKit

final class CreateTrackerViewController: UIViewController, CreateTrackerViewControllerProtocol {
    
    private(set) var createTrackerView = CreateTrackerView()
    var viewController: TrackerViewControllerProtocol?
    private let analyticsService = AnalyticsService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analyticsService.report(event: .open, screen: .createTrackerVC, item: nil)
        addViews()
        addTargets()
    }
    
    private func addTargets() {
        createTrackerView.habitButton.addTarget(self, action: #selector(switchToNewHabitViewController), for: .touchUpInside)
        createTrackerView.unregularEventButtton.addTarget(self, action: #selector(switchToNewUnregularEventViewController), for: .touchUpInside)
    }
    
    @objc private func switchToNewHabitViewController() {
        let newHabitVC = NewTrackerViewController(typeOfTracker: .habit)
        newHabitVC.createViewController = self
        newHabitVC.setupNewTrackerVC()
        newHabitVC.setupTargets()
        
        analyticsService.report(event: .close, screen: .createTrackerVC, item: nil)
        analyticsService.report(event: .close, screen: .createTrackerVC, item: .habit)
        present(newHabitVC, animated: true)
    }
    
    @objc private func switchToNewUnregularEventViewController() {
        let newHabitVC = NewTrackerViewController(typeOfTracker: .unregularEvent)
        newHabitVC.createViewController = self
        newHabitVC.setupNewTrackerVC()
        newHabitVC.setupTargets()
        
        analyticsService.report(event: .close, screen: .createTrackerVC, item: nil)
        analyticsService.report(event: .close, screen: .createTrackerVC, item: .unregularEvent)
        present(newHabitVC, animated: true)
    }
    
    func switchToTrackerVC() {
        dismiss(animated: true)
        viewController?.setupTrackersFromDatePicker()
    }
}

//MARK: SetupViews
extension CreateTrackerViewController {
    private func addViews() {
        view.backgroundColor = .ypWhite
        view.addSubview(createTrackerView.createTrackerLabel)
        view.addSubview(createTrackerView.habitButton)
        view.addSubview(createTrackerView.unregularEventButtton)
        addConstraints()
    }
    
    private func addConstraints() {
        createTrackerView.createTrackerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.centerX.equalToSuperview()
        }
        
        createTrackerView.habitButton.snp.makeConstraints { make in
            make.top.equalTo(createTrackerView.createTrackerLabel.snp.bottom).offset(295)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        createTrackerView.unregularEventButtton.snp.makeConstraints { make in
            make.top.equalTo(createTrackerView.habitButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
}
