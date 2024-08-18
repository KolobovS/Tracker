import Foundation

final class StatisticService: StatisticServiceProtocol {
    
    private let userDefaults = UserDefaults.standard
    private let dataProvider = DataProvider.shared
    
    var statisticModel: TrackerStatistic? {
        didSet {
            dataProvider.didUpdateStatistic()
        }
    }
    
    private var perfectDays: [Date] {
        get {
            return userDefaults.object(forKey: "perfectDays") as? [Date] ?? []
        }
        set {
            userDefaults.set(newValue, forKey: "perfectDays")
            countBestPeriod()
        }
    }
    
    private var bestPeriod: Int {
        get {
            return userDefaults.integer(forKey: "bestSeries")
        }
        set {
            userDefaults.set(newValue, forKey: "bestSeries")
            dataProvider.setRecordToStatisticsService()
        }
    }
    
    func provideStatisticModel(record: [TrackerRecord]?) {
        guard let record = record else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let perfectDays = getCountOfPerfectDays()
        let bestPeriod = getBestPeriod()
        let averageValue = countAverageValue(record: record, dateFormatter)

        statisticModel = TrackerStatistic(bestPeriod: bestPeriod,
                                          perfectDays: perfectDays,
                                          totalCompletedTrackers: record.count,
                                          averageValue: averageValue)
    }
    
    private func countAverageValue(record: [TrackerRecord], _ dateFormatter: DateFormatter) -> Int {
        let days = Array(Set(record.map({ dateFormatter.string(from: $0.date) }))).count
        
        return record.count != 0 ? record.count / days : 0
    }
    
    func setNewPerfectDaysValue(date: Date) {
        var oldValues = perfectDays
        
        oldValues.append(date)
        perfectDays = oldValues
    }
    
    func removePerfectDays(date: Date) {
        var oldValue = perfectDays
        guard let index = oldValue.firstIndex(where: { Calendar.current.isDate($0, inSameDayAs: date) }) else { return }
        
        oldValue.remove(at: index)
        perfectDays = oldValue
    }
    
    func removeAllStatistics() {
        if perfectDays != [] && bestPeriod != 0 {
            perfectDays = []
            bestPeriod = 0
        }
    }
    
    func getCountOfPerfectDays() -> Int {
        perfectDays.count
    }
    
    func getBestPeriod() -> Int {
        bestPeriod
    }
    
    private func countBestPeriod() {
        let calendar = Calendar.current
        
        let sortedDates = perfectDays.sorted()
        
        if sortedDates.count != 0 {
            var longestSequence: [Date] = []
            var currentSequence: [Date] = [sortedDates[0]]
            
            for i in 1..<sortedDates.count {
                guard let previousDate = calendar.date(byAdding: .day, value: 1, to: sortedDates[i - 1]) else { return }
                
                if calendar.isDate(sortedDates[i], inSameDayAs: previousDate) {
                    currentSequence.append(sortedDates[i])
                } else {
                    if currentSequence.count > longestSequence.count {
                        longestSequence = currentSequence
                    }
                    currentSequence = [sortedDates[i]]
                }
            }
            
            if currentSequence.count > longestSequence.count {
                longestSequence = currentSequence
            }
            
            bestPeriod = longestSequence.count
        } else {
            bestPeriod = 0
        }
    }
}
