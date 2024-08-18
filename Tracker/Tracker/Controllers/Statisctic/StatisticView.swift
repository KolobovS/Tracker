import UIKit

final class StatisticView {
    lazy var emptyLabel: UILabel = {
        let element = UILabel()
        element.text = LocalizableConstants.StatisticVC.emptyStateLabel
        element.textColor = .ypBlack
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 12, weight: .medium)
        return element
    }()
    
    lazy var emptyImage: UIImageView = {
        let element = UIImageView()
        element.image = Resourses.Images.statisticEmptyImage
        return element
    }()
    
    lazy var bestPeriod: StatisticCellView = {
        let element = StatisticCellView()
        element.setdescriptionLabel(text: LocalizableConstants.StatisticVC.bestPeriod)
        return element
    }()
    
    lazy var perfectDays: StatisticCellView = {
        let element = StatisticCellView()
        element.setdescriptionLabel(text: LocalizableConstants.StatisticVC.perfectDays)
        return element
    }()
    
    lazy var totalCompletedTrackers: StatisticCellView = {
        let element = StatisticCellView()
        element.setdescriptionLabel(text: LocalizableConstants.StatisticVC.totalCompletedTrackers)
        return element
    }()
    
    lazy var averageValue: StatisticCellView = {
        let element = StatisticCellView()
        element.setdescriptionLabel(text: LocalizableConstants.StatisticVC.averageValue)
        return element
    }()
}
