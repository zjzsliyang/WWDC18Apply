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

 Have you heard about the Temple of Heaven? 
 An imperial complex of religious buildings situated in the southeastern part of central Beijing, China. The complex was visited by the Emperors of the Ming and Qing dynasties for annual ceremonies of prayer to Heaven for good harvest. It has been regarded as a Taoist temple, although Chinese heaven worship, especially by the reigning monarch of the day, predates Taoism.

 hurry up to have a look now, Earth is by your side!
 
 **Try this:**

 Use the `explore()` method below to back to Beijing!

 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, explore())

