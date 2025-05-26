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
        var numToEmitRange: ClosedRange<Int> = 100...120

        for texture in textures {
            if let emitter = SKEmitterNode(fileNamed: "Confetti") {
                emitter.name = texture
                emitter.particleTexture = .init(imageNamed: texture)
                emitter.particleSize = CGSize(width: 40, height: 40)
                emitter.particleColorSequence = nil
                emitter.particleBirthRate = 100
                emitter.numParticlesToEmit = .random(in: numToEmitRange)
                emitter.particleLifetime = 5
                emitter.particlePosition = CGPoint(x: size.width / 2, y: -200)
                emitter.emissionAngle = CGFloat.pi / 2
                emitter.emissionAngleRange = CGFloat.pi / 2
                emitter.particleSpeed = 500
                emitter.particleSpeedRange = 300
                emitter.yAcceleration = -200
                emitter.particleAlpha = 2.5
                emitter.particleAlphaRange = 0.3
                emitter.particleScale = 0.3
                emitter.particleScaleRange = 0.2
                emitter.particleRotationSpeed = .pi / 6
                emitter.particleRotationRange = .pi * 2
                emitter.particleColorBlendFactor = 1
                emitter.particleBlendMode = .alpha
                addChild(emitter)
            }
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
