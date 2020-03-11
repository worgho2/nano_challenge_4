//
//  SpeedManager.swift
//  NC4
//
//  Created by Bruno Pastre on 09/03/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import SpriteKit

class GameSpeedManager: Updateable {
    
    private var currentSpeed: CGFloat!
    let acceleration: CGFloat = 5
    let maxVelocity: CGFloat = 600
    let minVelocity: CGFloat = 200
    
    init() {
        self.configure()
    }
    
    //MARK: - Class Methods
    
    private func configure() {
        self.currentSpeed = minVelocity
    }
    func getCurrentSpeed() -> CGFloat {
        return self.currentSpeed
    }
    func getProgress() -> CGFloat {
        return ( (maxVelocity + currentSpeed) / (maxVelocity - minVelocity) ) - 2
    }
    
    //MARK: - Updateable PROTOCOL
    
    func update(_ deltaTime: TimeInterval) {
        if self.currentSpeed >= self.maxVelocity { return }
        
        self.currentSpeed += self.acceleration * CGFloat(deltaTime)
        print("[progress] - \(self.getProgress()) - \(self.getCurrentSpeed())")

    }
}
