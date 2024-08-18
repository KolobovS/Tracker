import UIKit

final class OnboardingPageViewController: UIPageViewController {
    
    private lazy var controllers: [OnboardingViewController] = {
        let firstOnboardingVC = OnboardingViewController()
        firstOnboardingVC.firstLabel.text = LocalizableConstants.Onboarding.firstOnboardingTitle
        firstOnboardingVC.backgrounView.image = Resourses.Images.firstPageOfOnboarding
        
        let secondOnboardingVC = OnboardingViewController()
        secondOnboardingVC.firstLabel.text = LocalizableConstants.Onboarding.secondOnboardingTitle
        secondOnboardingVC.backgrounView.image = Resourses.Images.secondPageOfOnboarding
        return [firstOnboardingVC, secondOnboardingVC]
    }()
             
    lazy var pageControl: UIPageControl = {
        let element = UIPageControl()
        element.numberOfPages = 2
        element.currentPage = 0
        element.currentPageIndicatorTintColor = .black
        element.pageIndicatorTintColor = .black.withAlphaComponent(0.3)
        return element
    }()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll,
                   navigationOrientation: .horizontal)
        setupView()
        dataSource = self
        delegate = self
        if let first = controllers.first {setViewControllers([first],
                                                             direction: .forward,
                                                             animated: true,
                                                             completion: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = controllers.firstIndex(of: viewController as! OnboardingViewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        
        return controllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = controllers.firstIndex(of: viewController as! OnboardingViewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < controllers.count else { return nil }
        
        return controllers[nextIndex]
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = controllers.firstIndex(of: currentViewController as! OnboardingViewController) {
            pageControl.currentPage = currentIndex
        }
    }
}

extension OnboardingPageViewController {
    private func setupView() {
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-134)
        }
    }
}


