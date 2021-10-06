import Foundation
import UIKit

var barriers: [Shape] = []
var targets: [Shape] = []

let ball = OvalShape(width: 40, height: 40)             // p. 234

let funnelPoints = [                                    // p. 227
    Point(x: 0, y: 50),                                 // p. 227
    Point(x: 80, y: 50),                                // p. 227
    Point(x: 60, y: 0),                                 // p. 227
    Point(x: 20, y: 0)                                  // p. 227
]                                                       // p. 227
                                                        // p. 227
let funnel = PolygonShape(points: funnelPoints)         // p. 227


/*
The setup() function is called once when the app launches. Without it, your app won't compile.
Use it to set up and start your app.

You can create as many other functions as you want, and declare variables and constants,
at the top level of the file (outside any function). You can't write any other kind of code,
for example if statements and for loops, at the top level; they have to be written inside
of a function.
*/

fileprivate func setupBall() {
    ball.position = Point(x: 250, y: 400)               // p. 223
    ball.hasPhysics = true                              // p. 224
    ball.fillColor = .blue
    ball.onCollision = ballCollided(with:)              // p. 240
    ball.isDraggable = false                            // p. 242
    ball.bounciness = 0.6                               // p. 246
    scene.add(ball)                                     // p. 223
    scene.trackShape(ball)                              // p. 243
    ball.onExitedScene = ballExitedScene                // p. 243
    ball.onTapped = resetGame                           // p. 245
}

fileprivate func addBarrier(at position: Point, width: Double,
                            height: Double, angle: Double) {
    // Add a barrier to the scene                       // p. 225
    let barrierPoints = [                               // p. 250
        Point(x: 0, y: 0),                              // p. 250
        Point(x: 0, y: height),                         // p. 250
        Point(x: width, y: height),                     // p. 250
        Point(x: width, y: 0),                          // p. 250
    ]                                                   // p. 250
    let barrier = PolygonShape(points: barrierPoints)   // p. 250
    barriers.append(barrier)                            // p. 250
    barrier.position = position                         // p. 250
    barrier.hasPhysics = true                           // p. 225
    barrier.isImmobile = true                           // p. 226
    barrier.fillColor = .init(red: 0.5, green: 0.0, blue: 0.0)
    barrier.angle = angle                               // p. 250
    scene.add(barrier)                                  // p. 225
}

fileprivate func setupFunnel() {
    // Add a funnel to the scene                        // p. 228
    funnel.position = Point(x: 200, y: scene.height-25) // p. 228
    funnel.onTapped = dropBall                          // p. 229
    funnel.fillColor = .purple
    funnel.isDraggable = false                          // p. 242
    scene.add(funnel)                                   // p. 228
}

fileprivate func addTarget(at position: Point) {        // p. 252
    // Add a target to the scene                        // p. 237
    let targetPoints = [                                // p. 236
        Point(x: 10, y: 0),                             // p. 236
        Point(x: 0, y: 10),                             // p. 236
        Point(x: 10, y: 20),                            // p. 236
        Point(x: 20, y: 10)                             // p. 236
    ]                                                   // p. 236
    let target = PolygonShape(points: targetPoints)     // p. 236
    targets.append(target)                              // p. 253
    target.position = position                          // p. 253
    target.hasPhysics = true                            // p. 237
    target.isImmobile = true                            // p. 237
    target.isImpermeable = true                         // p. 237
    target.fillColor = .yellow                          // p. 237
    target.isDraggable = false                          // p. 242
    target.name = "target"                              // p. 241
    scene.add(target)                                   // p. 237
}

func setup() {
    setupBall()                                         // p. 234
    setupFunnel()                                       // p. 234
    // Create three barriers
    addBarrier(at: Point(x: 200, y:150), width: 80,
               height: 25, angle: 0.1)                  // p. 251
    addBarrier(at: Point(x: 94, y:151), width: 80,
               height: 25, angle: -0.2)
    addBarrier(at: Point(x:337, y:126), width: 80,
               height: 25, angle: 0.2)
    // Create three targets
    addTarget(at: Point(x: 172, y: 197))                // p. 237
    addTarget(at: Point(x: 228, y: 491))
    addTarget(at: Point(x: 171, y: 530))
    resetGame()                                         // p. 245
//    scene.onShapeMoved = printPosition(of:)             // p. 247
    
}

// Drops the ball by moving it to the funnel's position // p. 229
func dropBall() {                                       // p. 229
    ball.stopAllMotion()                                // p. 242
    ball.position = funnel.position                     // p. 229
    for barrier in barriers {
        barrier.isDraggable = false                     // p. 244 (Freeze position)
    }
    // Bug Fix.  Could also logically be in resetGame()
    for target in targets {
        target.fillColor = .yellow                      // Bug Fix
    }
}

// Handles collisions between the ball and the targets  // p. 240
func ballCollided(with otherShape: Shape) {             // p. 240
    if otherShape.name != "target" {return}             // p. 241
    otherShape.fillColor = .green                       // p. 240
}                                                       // p. 240

// Asynchronous callback for ball leaving screen
func ballExitedScene() {
    for barrier in barriers {
        barrier.isDraggable = true                      // p. 244 (Unfreeze position)
    }
}

// Resets the game by moving the ball below the scene   // p. 245
//  which will unlock the barriers.                     // p. 245
func resetGame() {
    ball.position = Point(x: 0, y: -80)
}

// Diagnostic function                                  // p. 247
func printPosition(of shape: Shape) {                   // p. 247
    print(shape.position)                               // p. 247
}                                                       // p. 247



