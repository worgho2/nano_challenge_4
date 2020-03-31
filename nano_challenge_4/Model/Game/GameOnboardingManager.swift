//
//  gameOnboardingManager.swift
//  nano_challenge_4
//
//  Created by otavio on 16/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class GameOnboardingManager {
    
    enum OnboardingStage {
        case first
        case second
        case third
    }
    
    private static var canShowFirst: Bool {
        get {
            return UserDefaults.standard.object(forKey: "onboarding.canShowFirst") as? Bool ?? true
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "onboarding.canShowFirst")
        }
    }
    
    private static var canShowSecond: Bool {
        get {
            return UserDefaults.standard.object(forKey: "onboarding.canShowSecond") as? Bool ?? false
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "onboarding.canShowSecond")
        }
    }
    
    private static var canShowThird: Bool {
        get {
            return UserDefaults.standard.object(forKey: "onboarding.canShowThird") as? Bool ?? false
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "onboarding.canShowThird")
        }
    }
    
    private static var hasAlreadyShowedFirst: Bool {
        get {
            return UserDefaults.standard.object(forKey: "onboarding.hasAlreadyShowedFirst") as? Bool ?? false
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "onboarding.hasAlreadyShowedFirst")
        }
    }
    
    private static var hasAlreadyShowedSecond: Bool {
        get {
            return UserDefaults.standard.object(forKey: "onboarding.hasAlreadyShowedSecond") as? Bool ?? false
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "onboarding.hasAlreadyShowedSecond")
        }
    }
    
    private static var hasAlreadyShowedThird: Bool {
        get {
            return UserDefaults.standard.object(forKey: "onboarding.hasAlreadyShowedThird") as? Bool ?? false
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "onboarding.hasAlreadyShowedThird")
        }
    }
    
    var wheelRotationRight: Bool = false {
        didSet {
            if self.wheelRotationRight == true && !self.hasAlreadyShowed(.first) {
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { t in
                    self.finish(.first)
                }
            }
        }
    }
    var wheelRotationLeft: Bool = false {
        didSet {
            if self.wheelRotationLeft == true && !self.hasAlreadyShowed(.second) {
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { t in
                    self.finish(.second)
                }
            }
        }
    }
    
    //MARK: - Class Mehtods
    
    func hasAlreadyShowed(_ stage: OnboardingStage) -> Bool {
        switch stage {
        case .first:
            return GameOnboardingManager.hasAlreadyShowedFirst
        case .second:
            return GameOnboardingManager.hasAlreadyShowedSecond
        case .third:
            return GameOnboardingManager.hasAlreadyShowedThird
        }
    }
    
    func canShow(_ stage: OnboardingStage) -> Bool {
        switch stage {
        case .first:
            return GameOnboardingManager.canShowFirst
        case .second:
            return GameOnboardingManager.canShowSecond
        case .third:
            return GameOnboardingManager.canShowThird
        }
    }
    
    func finish(_ stage: OnboardingStage) {
        switch stage {
        case .first:
            GameOnboardingManager.hasAlreadyShowedFirst = true
            GameOnboardingManager.canShowSecond = true
        case .second:
            GameOnboardingManager.hasAlreadyShowedSecond = true
            GameOnboardingManager.canShowThird = true
        case .third:
            GameOnboardingManager.hasAlreadyShowedThird = true
        }
    }
    
    func disable(_ stage: OnboardingStage) {
        switch stage {
        case .first:
            GameOnboardingManager.canShowFirst = false
        case .second:
            GameOnboardingManager.canShowSecond = false
        case .third:
            GameOnboardingManager.canShowThird = false
        }
    }
    
    func onboardingIsNeeded() -> Bool {
        return [
            GameOnboardingManager.hasAlreadyShowedFirst,
            GameOnboardingManager.hasAlreadyShowedSecond,
            GameOnboardingManager.hasAlreadyShowedThird
        ].contains(false)
    }
    
}
