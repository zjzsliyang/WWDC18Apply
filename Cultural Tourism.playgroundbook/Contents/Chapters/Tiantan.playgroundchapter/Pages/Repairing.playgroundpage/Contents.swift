//#-hidden-code

// Contents.swift
// Created by Yang Li on 31/03/2018.
//
// Copyright © 2018 Yang Li, Tongji University, Shanghai.
// All rights reserved.
//

import UIKit
import PlaygroundSupport

let page = PlaygroundPage.current
let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy

var rocketSpeed: CGFloat = 0.0

func launchRocket() {
  if rocketSpeed < 7.9 {
    PlaygroundPage.current.assessmentStatus = .fail(hints: ["Oops! The rocket is **falling**! ", "Try a little faster."], solution: "*7.9 - 11.2* can be around the earth")
  } else if rocketSpeed > 11.2 {
    PlaygroundPage.current.assessmentStatus = .fail(hints: ["What! It is **far away**!", "Try a little slower."], solution: "*7.9 - 11.2* can be around the earth")
  } else {
    proxy?.send(PlaygroundValue.string("launch"))
    PlaygroundPage.current.assessmentStatus = .pass(message: "**Congratulations**!🎉 What a perfect launch!")
  }
}

//#-end-hidden-code
/*:
 **Goal:** Launch the rocket🚀 and make it turn around the earth🌏.
 
 Remember the [cosmic velocity](glossary://cosmic%20velocity).
 
 There is a related history for your reference: **Newton's cannonball**
 
 *Newton's cannonball was a thought experiment Isaac Newton used to hypothesize that the force of gravity was universal, and it was the key force for planetary motion. It appeared in his book(A Treatise of the System of the World).*
 
 Some data(approximately) is shown as follows:
 
 * callout(Gravitational acceleration & Earth radius):
    *g = 10 m/s*
 
    *R = 6241 km*

 
 You may use the function:
 
 * callout(calculate the square root):
    `sqrt()`
 
 1. Calculate the rocket speed(*km/s*) to make it turn around the earth, just the value and the formula with number can both OK👌!
 
 2. Fire🔥 with the function `launchRocket()` !
 
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, sqrt())
rocketSpeed = /*#-editable-code*/0.0/*#-end-editable-code*/

launchRocket()
