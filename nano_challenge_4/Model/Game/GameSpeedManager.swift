//
//  SpeedManager.swift
//  NC4
//
//  Created by Bruno Pastre on 09/03/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import SpriteKit

class GameSpeedManager: Updateable, TriggeredByGameState {
    
    private var currentSpeed: CGFloat!
    
    let acceleration: CGFloat = 6
    let maxVelocity: CGFloat = 600
    let minVelocity: CGFloat = 200
    
    init() {
        self.currentSpeed = self.minVelocity
    }
    
    //MARK: - Class Methods
    
    func getCurrentSpeed() -> CGFloat {
        return self.currentSpeed
    }
    func getProgress() -> CGFloat {
        return ( (maxVelocity + currentSpeed) / (maxVelocity - minVelocity) ) - 2
    }
    
    //MARK: - Updateable PROTOCOL
    
    func update(_ deltaTime: TimeInterval) {
        if self.currentSpeed >= self.maxVelocity { return }
        self.currentSpeed += sqrt(self.acceleration) * CGFloat(deltaTime)
    }
    
    //MARK: - TriggeredByGameState PROTOCOL
    
    func onGameOver() {
        self.currentSpeed = self.minVelocity
    }
    
    func onGameStart() { return }
    
    func onGamePause() { return }
    
    func onGameContinue() { return }
}
