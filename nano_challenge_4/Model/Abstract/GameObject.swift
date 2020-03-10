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
    
    func shouldDespawn() -> Bool { return false }
    
    func update(_ deltaTime: TimeInterval) { return }
    
    func touchDown(atPoint pos: CGPoint) { return }
    func touchUp(atPoint pos: CGPoint) { return }
    
    func configurePhysics(on node: SKNode) { return }
    
    func onGameStart() { return }
    func onGamePause() { return }
    func onGameOver() { return }
}
