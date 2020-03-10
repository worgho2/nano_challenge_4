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
    var currentAngle: CGFloat! = -.pi/2
    let acceleration: CGFloat = 0.1 //0.01
    let maxVelocity: CGFloat = 600
    let minVelocity: CGFloat = 200
    var radius: CGFloat!
    
    init() {
        self.configure()
    }
    
    private func configure() {
        self.currentSpeed = 300// minVelocity
        self.currentAngle = -1
        self.radius = (maxVelocity - minVelocity) / 2
    }
    
    func getCurrentSpeed() -> CGFloat {
        return self.currentSpeed
    }

    func update(_ deltaTime: TimeInterval) {
        if self.currentSpeed >= self.maxVelocity { return }
        self.currentAngle += self.acceleration * CGFloat(deltaTime)
        self.currentSpeed = ((sin(self.currentAngle) + 1 ) * self.radius) + self.minVelocity
    }
    
    func getProgress() -> CGFloat {
         return (self.maxVelocity - self.getCurrentSpeed()) / self.maxVelocity
    }
    
    func onGameOver() {
        self.configure()
    }
}
