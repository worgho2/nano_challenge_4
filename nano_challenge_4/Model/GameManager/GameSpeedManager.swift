//
//  SpeedManager.swift
//  NC4
//
//  Created by Bruno Pastre on 09/03/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import SpriteKit

class GameSpeedManager {
    
    private(set) var currentSpeed: CGFloat!
    
    private var currentAngle: CGFloat = 0
    private let acceleration: CGFloat = 0.1
    private let maxVelocity: CGFloat = 600
    private let minVelocity: CGFloat = 250
    
    init() {
        self.currentSpeed = self.minVelocity
    }
    
    func getProgress() -> CGFloat {
        return ( (maxVelocity + currentSpeed) / (maxVelocity - minVelocity) ) - 2
    }
    
    func updateCurrentSpeed(_ deltaTime: TimeInterval) {
        if self.currentSpeed >= self.maxVelocity { return }
        
        self.currentAngle += acceleration * CGFloat(deltaTime)
        self.currentSpeed += (sin(currentAngle * 3) + currentAngle / 5) / 10
    }
    
}

extension GameSpeedManager: Updateable {
    
    func update(_ deltaTime: TimeInterval) {
        self.updateCurrentSpeed(deltaTime)
    }
    
}

extension GameSpeedManager: TriggeredByGameState {
    
    func onGameOver() {
        self.currentSpeed = self.minVelocity
    }
    
    func onGameStart() {
        self.currentSpeed = self.minVelocity
    }
    
    func onGamePause() { return }
    
    func onGameContinue() { return }
    
}
