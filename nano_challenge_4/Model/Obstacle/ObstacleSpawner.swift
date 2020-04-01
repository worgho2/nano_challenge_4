//
//  ObstacleSpawner.swift
//  nano_challenge_4
//
//  Created by otavio on 05/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class ObstacleSpawner: SceneSupplicant, Updateable, TriggeredByGameState {
    
    internal var scene: GameScene!
    
    public var obstacles: [Obstacle]
    private var obstacleFactory: ObstacleFactory!
    
    private var spawnThreshold = TimeInterval(2)
    private var currentSpawnTimer = TimeInterval(0)
    
    init(scene: GameScene?) {
        self.scene = scene
        self.obstacles = [Obstacle]()
        self.obstacleFactory = ObstacleFactory(scene: scene)
    }
    
    func spawn() {
        let newObstacle = self.obstacleFactory.getNewObstacle(type: ObstacleType.random(), color: ObstacleColor.random(), orientation: ObstacleOrientation.random(), position: ObstaclePosition.random())
        
        self.obstacles.append(newObstacle)
        self.scene.addChild(newObstacle.node)
    }
    
    func spawnByParameters(type: ObstacleType, color: ObstacleColor, orientation: ObstacleOrientation, position: ObstaclePosition) {
        let newObstacle = self.obstacleFactory.getNewObstacle(type: type, color: color, orientation: orientation, position: position)
        
        self.obstacles.append(newObstacle)
        self.scene.addChild(newObstacle.node)
    }
    
    func getObstacleBy(node: SKNode) -> Obstacle? {
        return obstacles.first(where: {$0.node == node})
    }
    
    //MARK: - Updateable PROTOCOL
    
    func update(_ deltaTime: TimeInterval) {

        self.currentSpawnTimer += deltaTime
        self.spawnThreshold = TimeInterval(2) - TimeInterval(scene.gameManager.speed.getProgress())
        
        self.obstacles.forEach { $0.update(deltaTime) }
        
        if currentSpawnTimer > self.spawnThreshold {
            if !scene.gameManager.onboarding.onboardingIsNeeded() {
                self.spawn()
            }
            self.currentSpawnTimer -= spawnThreshold
        }
        
        for (i, obstacle) in self.obstacles.enumerated() {
            
            if obstacle.shouldDespawn() {
                self.obstacles.remove(at: i)
                obstacle.node.removeFromParent()
            }
        }
    }
    
    //MARK: - TriggeredByGameState PROTOCOL
    
    func onGameStart() {
        obstacles.forEach{ $0.node.removeFromParent() }
        obstacles = []
        
        self.currentSpawnTimer = TimeInterval(0)
    }
    
    func onGameOver() {
        obstacles.forEach{ $0.onGameOver() }
    }
    
    func onGamePause() {
        return
    }
    
    func onGameContinue() {
        return
    }
    
    
}

