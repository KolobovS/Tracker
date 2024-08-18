import UIKit

final class OnboardingViewController: UIViewController {
    
    var backgrounView = UIImageView()
    
    lazy var firstLabel: UILabel = {
        let element = UILabel()
        element.textColor = .black
        element.font = .boldSystemFont(ofSize: 32)
        element.textAlignment = .center
        element.numberOfLines = 0
        return element
    }()
    
    private lazy var switchButton: UIButton = {
        let element = UIButton(type: .system)
        element.backgroundColor = .black
        element.layer.cornerRadius = 16
        element.setTitle(LocalizableConstants.Onboarding.onboardingContinueButton, for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        element.titleLabel?.textAlignment = .center
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setTarget()
    }
    
    private func setTarget() {
        switchButton.addTarget(self, action: #selector(switchToTabBarVC), for: .touchUpInside)
    }
    
    @objc private func switchToTabBarVC() {
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate = scene?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            let vc = TabBarController()
            sceneDelegate.window?.rootViewController = vc
            OnboardingManager.hasCompletedOnboarding = true

            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
    }
}

extension OnboardingViewController {
    private func setupView() {
        view.addSubview(backgrounView)
        view.addSubview(firstLabel)
        view.addSubview(switchButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        backgrounView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        switchButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(switchButton.snp.top).offset(-160)
        }
    }
}
