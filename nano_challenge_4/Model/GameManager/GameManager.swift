//
//  GameManager.swift
//  nano_challenge_4
//
//  Created by otavio on 01/04/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class GameManager {

    let score: GameScoreManager!
    let color: GameColorManager!
    let speed: GameSpeedManager!
    let audio: GameAudioManager!
    let haptic: GameHapticManager!
    let onboarding: GameOnboardingManager!
    
    init(score: GameScoreManager?, color: GameColorManager?, speed: GameSpeedManager?, audio: GameAudioManager?, haptic: GameHapticManager?, onboarding: GameOnboardingManager?) {
        self.score = score
        self.color = color
        self.speed = speed
        self.audio = audio
        self.haptic = haptic
        self.onboarding = onboarding
    }
}
