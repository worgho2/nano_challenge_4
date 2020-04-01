//
//  GameObject.swift
//  nano_challenge_4
//
//  Created by Bruno Pastre on 04/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class GameObject: Updateable, SceneSupplicant, TouchSensitive, PhysicsObject, TriggeredByGameState {
    
    static var next_id = 0
    
    var id: Int
    var node: SKNode!
    var scene: GameScene!
    
    init(node: SKNode?, scene: GameScene?) {
        self.id = GameObject.next_id
        GameObject.next_id += 1
        
        self.node = node
        self.scene = scene
    }
    
    //MARK: - Class Methods
    
    func shouldDespawn() -> Bool { return false }
    
    //MARK: - Updateable PROTOCOL
    
    func update(_ deltaTime: TimeInterval) { return }
    
    //MARK: - TouchSensitive PROTOCOL
    
    func touchDown(atPoint pos: CGPoint) { return }
    func touchUp(atPoint pos: CGPoint) { return }
    
    //MARK: - PhysicsObject PROTOCOL
    
    func configurePhysics(on node: SKNode) { return }
    
    //MARK: - TriggeredByGameState PROTOCOL
    
    func onGameStart() { return }
    func onGamePause() { return }
    func onGameContinue() { return }
    func onGameOver() { return }
    
}
