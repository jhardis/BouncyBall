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





/*
The setup() function is called once when the app launches. Without it, your app won't compile.
Use it to set up and start your app.

You can create as many other functions as you want, and declare variables and constants,
at the top level of the file (outside any function). You can't write any other kind of code,
for example if statements and for loops, at the top level; they have to be written inside
of a function.
*/

fileprivate func setupBall() {
    ball.position = Point(x: 250, y: 400)             // p. 223
    ball.hasPhysics = true                            // p. 224
    ball.fillColor = .blue
    scene.add(ball)                                   // p. 223
}

fileprivate func setupBarrier() {
    // Add a barrier to the scene                       // p. 225
    barrier.position = Point(x: 200, y:150)             // p. 225
    barrier.hasPhysics = true                           // p. 225
    barrier.isImmobile = true                           // p. 226
    barrier.fillColor = .init(red: 0.5, green: 0.0, blue: 0.0)
    scene.add(barrier)                                  // p. 225
}

fileprivate func setupFunnel() {
    // Add a funnel to the scene                        // p. 228
    funnel.position = Point(x: 200, y: scene.height-25) // p. 228
    funnel.onTapped = dropBall                          // p. 229
    funnel.fillColor = .purple
    scene.add(funnel)                                   // p. 228
}

func setup() {
    setupBall()                                         // p. 234
    setupBarrier()                                      // p. 234
    setupFunnel()                                       // p. 234
    
}

// Drops the ball by moving it to the funnel's position // p. 229
func dropBall() {                                       // p. 229
    ball.position = funnel.position                   // p. 229
}




