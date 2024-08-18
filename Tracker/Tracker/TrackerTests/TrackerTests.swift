import XCTest
import SnapshotTesting
@testable import Tracker

final class TrackerTests: XCTestCase {
    let trackersViewController = TrackersViewController()
    let statisticsViewController = StatisticViewController()
    let createTrackersViewController = CreateTrackerViewController()
    let newTrackerViewController = NewTrackerViewController(typeOfTracker: nil)
    let categoryViewController = CategoryViewController()
    let newCategoryViewController = NewCategoryViewController()
    let scheduleViewController = ScheduleViewController()
    
//MARK: LightMode
    //MARK: TrackersVC
    func testTrackersViewController() {
        assertSnapshots(matching: trackersViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testTrackersViewControllerRecursive() {
        assertSnapshots(matching: trackersViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testSearchTextFieldTrackersViewController() {
        assertSnapshots(matching: trackersViewController.trackersView.searchTextField,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testSearchTextFieldTrackersViewControllerRecursive() {
        assertSnapshots(matching: trackersViewController.trackersView.searchTextField,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testFilterButtonTrackersViewController() {
        assertSnapshots(matching: trackersViewController.trackersView.filterButton,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testFilterButtonTrackersViewControllerRecursive() {
        assertSnapshots(matching: trackersViewController.trackersView.filterButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    //MARK: CreateTrackerVC
    func testCreateTrackersViewController() {
        assertSnapshots(matching: createTrackersViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testCreateTrackersViewControllerRecursive() {
        assertSnapshots(matching: createTrackersViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testHabitButtonCreateTrackersViewController() {
        assertSnapshots(matching: createTrackersViewController.createTrackerView.habitButton,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testHabitButtonCreateTrackersViewControllerRecursive() {
        assertSnapshots(matching: createTrackersViewController.createTrackerView.habitButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testUnregularEventButtonCreateTrackersViewController() {
        assertSnapshots(matching: createTrackersViewController.createTrackerView.unregularEventButtton,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testUnregularEventButtonCreateTrackersViewControllerRecursive() {
        assertSnapshots(matching: createTrackersViewController.createTrackerView.unregularEventButtton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    //MARK: NewTrackerVC
    func testNewTrackerViewController() {
        assertSnapshots(matching: newTrackerViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testNewTrackerViewControllerRecursive() {
        assertSnapshots(matching: newTrackerViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testTextFieldNewTrackerViewController() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.habitNameTextField,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testTextFieldNewTrackerViewControllerRecursive() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.habitNameTextField,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testTableViewNewTrackerViewController() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.categoryAndScheduleTableView,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testCollectionViewNewTrackerViewController() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.collectionView,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testCreateButtonNewTrackerViewController() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.createButton,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testCreateButtonNewTrackerViewControllerRecursive() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.createButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testCancelButtonNewTrackerViewController() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.cancelButton,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testCancelButtonNewTrackerViewControllerRecursive() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.cancelButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    //MARK: CategoryVC
    func testCategoryViewController() {
        assertSnapshots(matching: categoryViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testCategoryViewControllerRecursive() {
        assertSnapshots(matching: categoryViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testTableViewCategoryViewController() {
        assertSnapshots(matching: categoryViewController.categoryView.categoryTableView,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testCreateButtonCategoryViewController() {
        assertSnapshots(matching: categoryViewController.categoryView.addCategoryButton,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testCreateButtonCategoryViewControllerRecursive() {
        assertSnapshots(matching: categoryViewController.categoryView.addCategoryButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    //MARK: NewCategoryVC
    func testNewCategoryViewController() {
        assertSnapshots(matching: newCategoryViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testNewCategoryViewControllerRecursive() {
        assertSnapshots(matching: newCategoryViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testTextFieldNewCategoryViewController() {
        assertSnapshots(matching: newCategoryViewController.newCategoryView.newCategoryTextField,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testTextFieldNewCategoryViewControllerRecursive() {
        assertSnapshots(matching: newCategoryViewController.newCategoryView.newCategoryTextField,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testAddCategoryButtonNewCategoryViewController() {
        assertSnapshots(matching: newCategoryViewController.newCategoryView.addCategoryButton,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testAddCategoryButtonNewCategoryViewControllerRecursive() {
        assertSnapshots(matching: newCategoryViewController.newCategoryView.addCategoryButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    //MARK: ScheduleVC
    func testScheduleViewController() {
        assertSnapshots(matching: scheduleViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testScheduleViewControllerRecursive() {
        assertSnapshots(matching: scheduleViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testTableViewScheduleViewController() {
        assertSnapshots(matching: scheduleViewController.scheduleView.scheduleTableView,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testDoneButtonScheduleViewController() {
        assertSnapshots(matching: scheduleViewController.scheduleView.doneButton,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testDoneButtonScheduleViewControllerRecursive() {
        assertSnapshots(matching: scheduleViewController.scheduleView.doneButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
//MARK: DarkMode
    //MARK: TrackersVC
    func testTrackersViewControllerDark() {
        assertSnapshots(matching: trackersViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testTrackersViewControllerRecursiveDark() {
        assertSnapshots(matching: trackersViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testSearchTextFieldTrackersViewControllerDark() {
        assertSnapshots(matching: trackersViewController.trackersView.searchTextField,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testSearchTextFieldTrackersViewControllerRecursiveDark() {
        assertSnapshots(matching: trackersViewController.trackersView.searchTextField,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testFilterButtonTrackersViewControllerDark() {
        assertSnapshots(matching: trackersViewController.trackersView.filterButton,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testFilterButtonTrackersViewControllerRecursiveDark() {
        assertSnapshots(matching: trackersViewController.trackersView.filterButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    //MARK: CreateTrackerVC
    func testCreateTrackersViewControllerDark() {
        assertSnapshots(matching: createTrackersViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testCreateTrackersViewControllerRecursiveDark() {
        assertSnapshots(matching: createTrackersViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testHabitButtonCreateTrackersViewControllerDark() {
        assertSnapshots(matching: createTrackersViewController.createTrackerView.habitButton,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testHabitButtonCreateTrackersViewControllerRecursiveDark() {
        assertSnapshots(matching: createTrackersViewController.createTrackerView.habitButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testUnregularEventButtonCreateTrackersViewControllerDark() {
        assertSnapshots(matching: createTrackersViewController.createTrackerView.unregularEventButtton,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testUnregularEventButtonCreateTrackersViewControllerRecursiveDark() {
        assertSnapshots(matching: createTrackersViewController.createTrackerView.unregularEventButtton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    //MARK: NewTrackerVC
    func testNewTrackerViewControllerDark() {
        assertSnapshots(matching: newTrackerViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testNewTrackerViewControllerRecursiveDark() {
        assertSnapshots(matching: newTrackerViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testTextFieldNewTrackerViewControllerDark() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.habitNameTextField,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testTextFieldNewTrackerViewControllerRecursiveDark() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.habitNameTextField,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testTableViewNewTrackerViewControllerDark() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.categoryAndScheduleTableView,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testCollectionViewNewTrackerViewControllerDark() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.collectionView,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testCreateButtonNewTrackerViewControllerDark() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.createButton,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testCreateButtonNewTrackerViewControllerRecursiveDark() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.createButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testCancelButtonNewTrackerViewControllerDark() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.cancelButton,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testCancelButtonNewTrackerViewControllerRecursiveDark() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.cancelButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    //MARK: CategoryVC
    func testCategoryViewControllerDark() {
        assertSnapshots(matching: categoryViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testCategoryViewControllerRecursiveDark() {
        assertSnapshots(matching: categoryViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testTableViewCategoryViewControllerDark() {
        assertSnapshots(matching: categoryViewController.categoryView.categoryTableView,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testCreateButtonCategoryViewControllerDark() {
        assertSnapshots(matching: categoryViewController.categoryView.addCategoryButton,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testCreateButtonCategoryViewControllerRecursiveDark() {
        assertSnapshots(matching: categoryViewController.categoryView.addCategoryButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    //MARK: NewCategoryVC
    func testNewCategoryViewControllerDark() {
        assertSnapshots(matching: newCategoryViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testNewCategoryViewControllerRecursiveDark() {
        assertSnapshots(matching: newCategoryViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testTextFieldNewCategoryViewControllerDark() {
        assertSnapshots(matching: newCategoryViewController.newCategoryView.newCategoryTextField,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testTextFieldNewCategoryViewControllerRecursiveDark() {
        assertSnapshots(matching: newCategoryViewController.newCategoryView.newCategoryTextField,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testAddCategoryButtonNewCategoryViewControllerDark() {
        assertSnapshots(matching: newCategoryViewController.newCategoryView.addCategoryButton,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testAddCategoryButtonNewCategoryViewControllerRecursiveDark() {
        assertSnapshots(matching: newCategoryViewController.newCategoryView.addCategoryButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    //MARK: ScheduleVC
    func testScheduleViewControllerDark() {
        assertSnapshots(matching: scheduleViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testScheduleViewControllerRecursiveDark() {
        assertSnapshots(matching: scheduleViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testTableViewScheduleViewControllerDark() {
        assertSnapshots(matching: scheduleViewController.scheduleView.scheduleTableView,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testDoneButtonScheduleViewControllerDark() {
        assertSnapshots(matching: scheduleViewController.scheduleView.doneButton,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testDoneButtonScheduleViewControllerRecursiveDark() {
        assertSnapshots(matching: scheduleViewController.scheduleView.doneButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
}
