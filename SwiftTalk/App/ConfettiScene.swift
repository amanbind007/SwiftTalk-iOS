//
//  ConfettiScene.swift
//  SwiftTalk
//
//  Created by Aman Bind on 17/07/24.
//

import SpriteKit

class ConfettiScene: SKScene {
    var emitters: [SKEmitterNode] = []

    let textures = [
        "circle1",
        "circle2",
        "jaggedy",
        "loopie",
        "moon1",
        "moon2",
        "rectangle1",
        "rectangle2",
        "squiggly",
        "star1",
        "star2",
        "triangle1",
        "triangle2"
    ]

    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = .clear

        for texture in textures {
            if let emitter = SKEmitterNode(fileNamed: "Confetti") {
                emitter.name = texture
                emitter.particleTexture = .init(imageNamed: texture)
                emitter.particleSize = CGSize(width: 400, height: 400)

                emitter.position.y = size.height/2
                emitter.position.x = size.width/2
                emitter.particleColorSequence = nil
                addChild(emitter)
            }
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
