//
//  ObstacleFactory.swift
//  nano_challenge_4
//
//  Created by otavio on 05/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

enum ObstaclePosition: CaseIterable {
    case leading
    case trailing
    case center
    
    static func random() -> ObstaclePosition {
        ObstaclePosition.allCases.randomElement()!
    }
}

enum ObstacleOrientation: CaseIterable {
    case horizontal
    case vertical
    
    static func random() -> ObstacleOrientation {
        ObstacleOrientation.allCases.randomElement()!
    }
}

enum ObstacleType: CaseIterable {
    case rectangle
    case square
    
    static func random() -> ObstacleType {
        ObstacleType.allCases.randomElement()!
    }
}

class ObstacleFactory: SceneSupplicant {
    
    var scene: GameScene!
    
    private var rectangleBaseNode: SKNode!
    private var squareBaseNode: SKNode!
    
    init(scene: GameScene?) {
        self.scene = scene
        self.rectangleBaseNode = RectangleObstacle(scene: self.scene).node
        self.squareBaseNode = SquareObstacle(scene: self.scene).node
    }

    private func getNode(type: ObstacleType, orientation: ObstacleOrientation, position: ObstaclePosition) -> SKNode {
        let node = (type == .rectangle ? self.rectangleBaseNode : self.squareBaseNode).copy() as! SKNode
        let nodeRotation: CGFloat = (orientation == .horizontal ? 0 : CGFloat.pi/2)
        var nodePosition: CGPoint = CGPoint(x: 0, y: 0)
        let bounds = self.scene.getBounds()
        
        nodePosition.y = (orientation == .horizontal ? bounds.minY - node.frame.size.height/2 : bounds.minY - node.frame.size.width/2)
        
        switch position {
        case .center:
            nodePosition.x = 0
        case .leading:
            if (type == .rectangle && orientation == .horizontal) {
                nodePosition.x = bounds.minX + node.frame.size.width/2
            } else {
                nodePosition.x = (orientation == .horizontal ? -node.frame.size.width * 2/3 : -node.frame.size.height * 2/3)
            }
        case .trailing:
            if type == .rectangle && orientation == .horizontal {
                nodePosition.x = -bounds.minX - node.frame.size.width/2
            } else {
                nodePosition.x = (orientation == .horizontal ? node.frame.size.width * 2/3 : node.frame.size.height * 2/3)
            }
        }
        
        node.position = nodePosition
        node.zRotation = nodeRotation
        node.zPosition = 100
        
        return node
    }
    
    func getNewObstacle(type: ObstacleType, orientation: ObstacleOrientation, position: ObstaclePosition) -> Obstacle {
        print(type, orientation, position)
        let node = self.getNode(type: type, orientation: orientation, position: position)
        
        return type == .rectangle ? RectangleObstacle(node: node, scene: self.scene) : SquareObstacle(node: node, scene: self.scene)
    }

}
