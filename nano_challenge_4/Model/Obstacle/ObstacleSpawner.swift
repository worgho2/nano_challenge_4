//
//  ObstacleSpawner.swift
//  nano_challenge_4
//
//  Created by otavio on 05/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class ObstacleSpawner: SceneSupplicant, Updateable {
    
    var scene: GameScene!
    var obstacleFactory: ObstacleFactory!
    var obstacles: [Obstacle]!
    
    private let spawnThreshold = TimeInterval(1)
    private var currentSpawnTimer = TimeInterval(0)
    
    init(scene: GameScene?) {
        self.scene = scene
        self.obstacleFactory = ObstacleFactory(scene: self.scene)
        self.obstacles = [Obstacle]()
    }
    
    func update(_ deltaTime: TimeInterval) {
        self.currentSpawnTimer += deltaTime
        
        self.obstacles.forEach { $0.update(deltaTime) }
        
        if currentSpawnTimer > self.spawnThreshold {
            self.spawn()
            self.currentSpawnTimer -= spawnThreshold
        }
        
        for (i, obstacle) in self.obstacles.enumerated() {
            
            if obstacle.shouldDespawn(){
                self.obstacles.remove(at: i)
                obstacle.node.removeFromParent()
            }
        }
    }

    func spawn() {
        let newObstacle = self.obstacleFactory.getNewObstacle(type: ObstacleType.random(), color: ObstacleColor.random(), orientation: ObstacleOrientation.random(), position: ObstaclePosition.random())
        
        self.obstacles.append(newObstacle)
        self.scene.addChild(newObstacle.node)
    }
    
    func getObstacleBy(node: SKNode) -> Obstacle {
        return obstacles.first(where: {$0.node == node})!
    }
}
