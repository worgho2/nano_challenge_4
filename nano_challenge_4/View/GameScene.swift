//
//  GameScene.swift
//  nano_challenge_4
//
//  Created by otavio on 04/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var vc: GameViewController?
    
    private var lastUpdate: TimeInterval = TimeInterval(0)
    
    var wheel: Wheel!
    var drop: Drop!
    var enemySpawner: ObstacleSpawner!
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        self.wheel = Wheel(scene: self)
        self.drop = Drop(scene: self)
        self.enemySpawner = ObstacleSpawner(scene: self)
    }
    
    func getBounds() -> CGRect {
        return CGRect(x: -self.scene!.size.width / 2, y: -self.scene!.size.height / 2, width: self.scene!.size.width / 2, height: self.scene!.size.height / 2 )
    }
    
    //MARK: - Updateable Protocol
    
    override func update(_ currentTime: TimeInterval) {
        guard let deltaTime = self.updateDeltaTime(currentTime) else { return }
        
        self.getUpdatables().forEach { $0.update(deltaTime) }
    }
    
    private func updateDeltaTime(_ currentTime: TimeInterval) -> TimeInterval? {
           
           if lastUpdate == 0 {
               lastUpdate = currentTime
               return nil
           }

           let deltaTime = currentTime - lastUpdate
           self.lastUpdate = currentTime
           
           if deltaTime > 0.1 { return  nil}
           
           return deltaTime
       }
    
    private func getUpdatables() -> [Updateable] {
       return [
           self.wheel,
           self.enemySpawner
       ]
    }
    
    // MARK: - Physics methods
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if [nodeA.name, nodeB.name].contains("drop") {
            self.vc?.onGameOver()
            return
        }
        
        if nodeA.name!.contains("Painter") {
            self.onCollision(nodeA, nodeB)
        } else {
            self.onCollision(nodeB, nodeA)
        }
    }
    
    func onCollision(_ painterNode: SKNode, _ obstacleNode: SKNode) {
        print("[COLISION: \(painterNode.name!) -> \(obstacleNode.name!)]")
        
        guard let painter = painterNode as? SKShapeNode else {
            fatalError()
//            return
        }
        
        enemySpawner.obstacles.first?.onCollision(withPanterColor: painter.fillColor)
    }
    
    // MARK: - Touch callbacks
    
    private func getTouchSensitives() -> [TouchSensitive] {
        return [
            self.wheel
        ]
    }
    
    func touchDown(atPoint pos : CGPoint) {
        self.getTouchSensitives().forEach { $0.touchDown(atPoint: pos) }
    }
    
    func touchUp(atPoint pos : CGPoint) {
       self.getTouchSensitives().forEach { $0.touchUp(atPoint: pos) }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
}
