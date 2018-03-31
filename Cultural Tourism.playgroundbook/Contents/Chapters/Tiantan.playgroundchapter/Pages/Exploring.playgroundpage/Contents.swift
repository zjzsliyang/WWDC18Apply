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

 Welcome, balabala!

 
 
 **Try this:**

 Use the `explore()` method below to back to Beijing!

 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, explore())

