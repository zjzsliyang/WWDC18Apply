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
page.needsIndefiniteExecution = true
let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy

func explore() {
  proxy?.send(.string("explore"))
}

//#-end-hidden-code
/*:

 Welcome, travelers!

 Have you ever heard about the Temple of Heaven in Beijing? 

 The Temple of Heaven is an imperial complex of religious buildings situated in the southeastern part of central Beijing, China. The complex was visited by the Emperors of the Ming and Qing dynasties for annual ceremonies of prayer to Heaven for good harvest. It has been regarded as a Taoist temple, although Chinese heaven worship, especially by the reigning monarch of the day, predates Taoism.

 * callout(explore the Temple of Heaven on a planar surface):
 `explore()`
 
 I built an AR Model of the Temple of Heaven. Hurry up and have a look now, the Earth is by your side!

 Note: Since the model is pretty large and complicated, you may **wait for a moment while capturing a planar surface that are perpendicular to gravity**.


 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, explore())

