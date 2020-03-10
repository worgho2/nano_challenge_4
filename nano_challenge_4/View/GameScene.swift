//
//  GameScene.swift
//  nano_challenge_4
//
//  Created by otavio on 04/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var vc: GameViewController?
    var gameColorPalette: GameColorPalette?
    
    private var lastUpdate = TimeInterval(0)
    
    let impactFeedback = UIImpactFeedbackGenerator()
    
    var realPaused: Bool = false {
        didSet {
            self.isPaused = realPaused
        }
    }
    override var isPaused: Bool {
        didSet {
            if (!self.isPaused && self.realPaused) {
                self.isPaused = true
            }
        }
    }
    
    var score: Score!
    var wheel: Wheel!
    var drop: Drop!
    var obstacleSpawner: ObstacleSpawner!
    
    var gameSpeedManager: GameSpeedManager!
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        self.score = Score(scene: self, manager: GameScoreManager())
        self.wheel = Wheel(scene: self)
        self.drop = Drop(scene: self)
        self.obstacleSpawner = ObstacleSpawner(scene: self)
        self.gameSpeedManager = GameSpeedManager()
    }
    
    func getBounds() -> CGRect {
        return CGRect(x: -self.scene!.size.width / 2, y: -self.scene!.size.height / 2, width: self.scene!.size.width / 2, height: self.scene!.size.height / 2 )
    }
    
    private func getTriggeredsByGameState() -> [TriggeredByGameState] {
        return [
            self.score
        ]
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
        
        if deltaTime > 0.1 { return  nil }
        
        return deltaTime
    }
    
    private func getUpdatables() -> [Updateable] {
        return [
            self.score,
            self.wheel,
            self.obstacleSpawner,
            self.gameSpeedManager
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
        let obstacle = self.obstacleSpawner.getObstacleBy(node: obstacleNode)
        
        guard let painterNode = painterNode as? SKShapeNode else { fatalError() }
        guard let obstacleNode = obstacleNode as? SKSpriteNode else { fatalError() }
        
        if painterNode.fillColor == obstacleNode.color {
            self.vc?.onGameOver()
            return
        }
        
        print("[COLLISION] \(painterNode.name!) -> \(obstacleNode.name!)")
        
        obstacle.onCollision(paintWith: self.gameColorPalette!.backgroundColor)
        self.score.incrementObstacleHighScore()
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
