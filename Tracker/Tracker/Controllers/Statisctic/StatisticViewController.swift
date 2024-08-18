import UIKit

final class StatisticViewController: UIViewController {
    
    private let statisticView = StatisticView()
    private let statisticViewModel = StatisticViewModel()
    private let analyticsService = AnalyticsService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhite
        setupEmptyViews()
        bindViewModel()
        statisticViewModel.isStatisticExists()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        analyticsService.report(event: .open, screen: .statisticVC, item: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        analyticsService.report(event: .close, screen: .statisticVC, item: nil)
    }
    
    private func bindViewModel() {
        statisticViewModel.$isStatisticsExist.bind { [weak self] value in
            guard let self = self else { return }
            self.isStatisticExist(value: value)
        }
        
        statisticViewModel.$recordModel.bind { [weak self] model in
            guard let self = self else { return }
            self.statisticView.bestPeriod.setCountLabel(value: String(model?.bestPeriod ?? 0))
            self.statisticView.perfectDays.setCountLabel(value: String(model?.perfectDays ?? 0))
            self.statisticView.totalCompletedTrackers.setCountLabel(value: String(model?.totalCompletedTrackers ?? 0))
            self.statisticView.averageValue.setCountLabel(value: String(model?.averageValue ?? 0))
        }
    }
    
    private func isStatisticExist(value: Bool?) {
        guard let value = value else { return }
        if value == true {
            setupStatisticViews()
        } else {
            setupEmptyViews()
        }
    }
    
    override func viewDidLayoutSubviews() {
        statisticView.bestPeriod.layer.addGradientColor()
        statisticView.perfectDays.layer.addGradientColor()
        statisticView.totalCompletedTrackers.layer.addGradientColor()
        statisticView.averageValue.layer.addGradientColor()
    }
}

extension StatisticViewController {
    private func setupEmptyViews() {
        statisticView.bestPeriod.removeFromSuperview()
        statisticView.perfectDays.removeFromSuperview()
        statisticView.totalCompletedTrackers.removeFromSuperview()
        statisticView.averageValue.removeFromSuperview()
        
        view.addSubview(statisticView.emptyImage)
        view.addSubview(statisticView.emptyLabel)
        setupEmptyViewsConstraints()
    }
    
    private func setupEmptyViewsConstraints() {
        statisticView.emptyImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        statisticView.emptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(statisticView.emptyImage.snp.bottom).offset(8)
        }
    }
    
    private func setupStatisticViews() {
        statisticView.emptyImage.removeFromSuperview()
        statisticView.emptyLabel.removeFromSuperview()
        
        view.addSubview(statisticView.bestPeriod)
        view.addSubview(statisticView.perfectDays)
        view.addSubview(statisticView.totalCompletedTrackers)
        view.addSubview(statisticView.averageValue)
        setupStatisticViewsConstraints()
    }
    
    private func setupStatisticViewsConstraints() {
        statisticView.bestPeriod.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(77)
        }
        
        statisticView.perfectDays.snp.makeConstraints { make in
            make.top.equalTo(statisticView.bestPeriod.snp.bottom).offset(12)
        }
        
        statisticView.totalCompletedTrackers.snp.makeConstraints { make in
            make.top.equalTo(statisticView.perfectDays.snp.bottom).offset(12)
        }
        
        statisticView.averageValue.snp.makeConstraints { make in
            make.top.equalTo(statisticView.totalCompletedTrackers.snp.bottom).offset(12)
        }
        
        [statisticView.bestPeriod,
         statisticView.perfectDays,
         statisticView.totalCompletedTrackers,
         statisticView.averageValue].forEach { view in
            view.snp.makeConstraints { make in
                make.height.equalTo(90)
                make.leading.trailing.equalToSuperview().inset(16)
            }
        }
    }
}
