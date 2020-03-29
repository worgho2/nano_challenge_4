//
//  BackgroundPatternSpawner.swift
//  nano_challenge_4
//
//  Created by otavio on 12/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class BackgroundPatternBlockSpawner: SceneSupplicant, Updateable {

    var scene: SKScene!
    var backgroundPatternFactory: BackgroundPatternBlockFactory!
    var backgroundPatternBlocks: [BackgroundPatternBlock]!
    
    init(scene: SKScene?, gameSpeedManager: GameSpeedManager, gameColorManager: GameColorManager) {
        self.scene = scene
        self.backgroundPatternFactory = BackgroundPatternBlockFactory(scene: self.scene, gameSpeedManager: gameSpeedManager, gameColorManager: gameColorManager)
        self.backgroundPatternBlocks = [BackgroundPatternBlock]()
        self.initialSpawn()
    }

    //MARK: - Class Methods
    
    func initialSpawn() {
        let nodes = self.backgroundPatternFactory.getInitialBackgroundPatternBlockPack()
        
        nodes.forEach {
            self.backgroundPatternBlocks.append($0)
            self.scene.addChild($0.node)
        }
    }

    func spawn() {
        let newBackgroundPatternBlock = self.backgroundPatternFactory.getNewBackgroundPatternBlock()

        self.backgroundPatternBlocks.append(newBackgroundPatternBlock)
        self.scene.addChild(newBackgroundPatternBlock.node)
    }


    //MARK: - Updateable PROTOCOL

    func update(_ deltaTime: TimeInterval) {
        self.backgroundPatternBlocks.forEach { $0.update(deltaTime) }
        
        if let lastBlock = self.backgroundPatternBlocks.last {
            if lastBlock.node.position.y >= self.scene.getBounds().minY + lastBlock.node.children.first!.frame.height/2 {
                self.spawn()
            }
        }

        for (i, backgroundPatternBlock) in self.backgroundPatternBlocks.enumerated() {
            if backgroundPatternBlock.shouldDespawn() {
                self.backgroundPatternBlocks.remove(at: i)
                backgroundPatternBlock.node.removeFromParent()
            }
        }
    }

}
