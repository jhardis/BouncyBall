import Foundation

//let circle = OvalShape(width: 150, height: 150)         // p. 223
let ball = OvalShape(width: 40, height: 40)             // p. 234

let barrierWidth = 300.0                                // p. 225
let barrierHeight = 25.0                                // p. 225
                                                        // p. 225
let barrierPoints = [                                   // p. 225
    Point(x:0, y:0),                                    // p. 225
    Point(x:0, y: barrierHeight),                       // p. 225
    Point(x: barrierWidth, y:barrierHeight),            // p. 225
    Point(x: barrierWidth, y:0)                         // p. 225
]                                                       // p. 225
                                                        // p. 225
let barrier = PolygonShape(points: barrierPoints)       // p. 225

let funnelPoints = [                                    // p. 227
    Point(x: 0, y: 50),                                 // p. 227
    Point(x: 80, y: 50),                                // p. 227
    Point(x: 60, y: 0),                                 // p. 227
    Point(x: 20, y: 0)                                  // p. 227
]                                                       // p. 227
                                                        // p. 227
let funnel = PolygonShape(points: funnelPoints)         // p. 227

let targetPoints = [                                    // p. 236
    Point(x: 10, y: 0),                                 // p. 236
    Point(x: 0, y: 10),                                 // p. 236
    Point(x: 10, y: 20),                                // p. 236
    Point(x: 20, y: 10)                                 // p. 236
]                                                       // p. 236
                                                        // p. 236
let target = PolygonShape(points: targetPoints)         // p. 236



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

fileprivate func setupBarrier() {
    // Add a barrier to the scene                       // p. 225
    barrier.position = Point(x: 200, y:150)             // p. 225
    barrier.hasPhysics = true                           // p. 225
    barrier.isImmobile = true                           // p. 226
    barrier.fillColor = .init(red: 0.5, green: 0.0, blue: 0.0)
    barrier.angle = 0.1                                 // p. 246
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

fileprivate func setupTarget() {                        // p. 237
    // Add a target to the scene                        // p. 237
    target.position = Point(x: 172, y: 197)             // p. 237
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
    setupBarrier()                                      // p. 234
    setupFunnel()                                       // p. 234
    setupTarget()                                       // p. 237
    resetGame()                                         // p. 245
//    scene.onShapeMoved = printPosition(of:)             // p. 247
    
}

// Drops the ball by moving it to the funnel's position // p. 229
func dropBall() {                                       // p. 229
    ball.stopAllMotion()                                // p. 242
    ball.position = funnel.position                     // p. 229
    barrier.isDraggable = false                         // p. 244 (Freeze position)
    //bug:  Not true on first instance, but fixed on p. 245
    target.fillColor = .yellow                          // Bug Fix
}

// Handles collisions between the ball and the targets  // p. 240
func ballCollided(with otherShape: Shape) {             // p. 240
    if otherShape.name != "target" {return}             // p. 241
    otherShape.fillColor = .green                       // p. 240
}                                                       // p. 240

// Asynchronous callback for ball leaving screen
func ballExitedScene() {
    barrier.isDraggable = true                          // p. 244 (Unfreeze position)
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



