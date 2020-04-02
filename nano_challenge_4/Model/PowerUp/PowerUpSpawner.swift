//
//  PowerUpSpawner.swift
//  nano_challenge_4
//
//  Created by otavio on 01/04/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class PowerUpSpawner: SceneSupplicant, Updateable, TriggeredByGameState {
    
    internal var scene: GameScene!
    
    private var powerUps: [PowerUp]
    private var powerUpFactory: PowerUpFactory!
    
    private var spawnThreshold = TimeInterval(5)
    private var currentSpawnTimer = TimeInterval(0)
    
    init(scene: GameScene?) {
        self.scene = scene
        self.powerUps = [PowerUp]()
        self.powerUpFactory = PowerUpFactory(scene: scene)
    }
    
    //MARK: - Class Methods
    
    func spawn() {
        let newPowerUp = self.powerUpFactory.getNewPowerUp()
        
        self.powerUps.append(newPowerUp)
        self.scene.addChild(newPowerUp.node)
    }
    
    func getPowerUpBy(node: SKNode) -> PowerUp? {
        return powerUps.first(where: {$0.node == node})
    }
    
    //MARK: - Updateable PROTOCOL
    
    func update(_ deltaTime: TimeInterval) {
//        return
        self.currentSpawnTimer += deltaTime
        self.spawnThreshold = TimeInterval(5) - TimeInterval(scene.gameManager.speed.getProgress())
        
        self.powerUps.forEach { $0.update(deltaTime) }
        
        if currentSpawnTimer > self.spawnThreshold {
            if !scene.gameManager.onboarding.onboardingIsNeeded() {
                self.spawn()
            }
            self.currentSpawnTimer -= spawnThreshold
        }
        
        for (i, obstacle) in self.powerUps.enumerated() {
            
            if obstacle.shouldDespawn() {
                self.powerUps.remove(at: i)
                obstacle.node.removeFromParent()
            }
        }
    }
    
    //MARK: - TriggeredByGameState PROTOCOL
    
    func onGameStart() {
        self.powerUps.forEach{ $0.node.removeFromParent() }
        self.powerUps = []
        
        self.currentSpawnTimer = TimeInterval(0)
    }
    
    func onGameOver() {
        self.powerUps.forEach{ $0.onGameOver() }
    }
    
    func onGamePause() {
        return
    }
    
    func onGameContinue() {
        return
    }
}
