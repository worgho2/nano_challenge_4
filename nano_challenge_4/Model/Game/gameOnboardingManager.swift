//
//  gameOnboardingManager.swift
//  nano_challenge_4
//
//  Created by otavio on 16/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

enum OnboardingStage {
    case first
    case second
    case third
}


class GameOnboardingManager {
    
    //debug
    static var first: Bool = false
    static var second: Bool = false
    static var third: Bool = false
    
    var canShowFirst: Bool = true
    var canShowSecond: Bool = false
    var canShowThird: Bool = false

//    @Storage(key: "OnboardingFirst", defaultValue: false) private static var first: Bool
//    @Storage(key: "OnboardingSecond", defaultValue: false) private static var second: Bool
//    @Storage(key: "OnboardingThird", defaultValue: false) private static var third: Bool
    
    var wheelRotationRight: Bool = false {
        didSet {
            if self.wheelRotationRight == true && !self.isStageDone(.first){
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { t in
                    self.setStageDone(.first)
                    print("[ONBOARDING] - RIGHT TRUE")
                }
            }
        }
    }
    
    var wheelRotationLeft: Bool = false {
        didSet {
            if self.wheelRotationLeft == true && !self.isStageDone(.second) {
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { t in
                    self.setStageDone(.second)
                    print("[ONBOARDING] - LEFT TRUE")
                }
            }
        }
    }
    
    //MARK: - Class Mehtods
    
    func setStageDone(_ stage: OnboardingStage) {
        switch stage {
        case .first:
            GameOnboardingManager.first = true
            self.canShowSecond = true
        case .second:
            GameOnboardingManager.second = true
            self.canShowThird = true
        case .third:
            GameOnboardingManager.third = true
        }
        print("[Onboarding] showed: - 1:\(GameOnboardingManager.first) - 2:\(GameOnboardingManager.second) - 3:\(GameOnboardingManager.third)")
        print("[Onboarding] cansShow: - 1:\(self.canShowFirst) - 2:\(self.canShowSecond) - 3:\(self.canShowThird)")
    }
    
    func isStageDone(_ stage: OnboardingStage) -> Bool {
        switch stage {
        case .first:
            return GameOnboardingManager.first
        case .second:
            return GameOnboardingManager.second
        case .third:
            return GameOnboardingManager.third
        }
    }
    
    func onboardingIsNeeded() -> Bool {
        return [
            GameOnboardingManager.first,
            GameOnboardingManager.second,
            GameOnboardingManager.third
        ].contains(false)
    }
    
}
