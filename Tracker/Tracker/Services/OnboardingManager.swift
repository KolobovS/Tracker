import Foundation

final class OnboardingManager {
    static let hasCompletedOnboardingKey = "HasCompletedOnboarding"
    
    static var hasCompletedOnboarding: Bool {
        get {
            return UserDefaults.standard.bool(forKey: hasCompletedOnboardingKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: hasCompletedOnboardingKey)
        }
    }
}
