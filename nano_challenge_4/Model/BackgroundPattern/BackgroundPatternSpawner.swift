//
//  BackgroundPatternSpawner.swift
//  nano_challenge_4
//
//  Created by otavio on 12/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

class BackgroundPatternSpawner: SceneSupplicant, Updateable {
    
    var scene: GameScene!
    var backgroundPatternFactory: BackgroundPatternFactory!
    var backgroundPatterns: [BackgroundPattern]!
    
    
    init(scene: GameScene?) {
        self.scene = scene
        self.backgroundPatternFactory = BackgroundPatternFactory(scene: self.scene)
        self.backgroundPatterns = [BackgroundPattern]()
        self.spawn()
    }
    
    //MARK: - Class Methods
    
    func spawn() {
        let newBackgroundPattern = self.backgroundPatternFactory.getNewBackgroundPattern()
        
        self.backgroundPatterns.append(newBackgroundPattern)
        self.scene.addChild(newBackgroundPattern.node)
    }
    
    
    //MARK: - Updateable PROTOCOL
    
    func update(_ deltaTime: TimeInterval) {
        
//        self.backgroundPatterns.forEach { $0.update(deltaTime) }
//
//        for (i, backgroundPattern) in self.backgroundPatterns.enumerated() {
//            if backgroundPattern.shouldDespawn() {
//                self.backgroundPatterns.remove(at: i)
//                backgroundPattern.node.removeFromParent()
//            }
//        }
    }
    
}
