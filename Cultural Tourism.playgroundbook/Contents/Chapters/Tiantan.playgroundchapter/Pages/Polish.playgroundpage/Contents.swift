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

func polish() {
  proxy?.send(.string("polish"))
}

func recognize() {
    proxy?.send(.string("recognize"))
}

func changePainting() {
    proxy?.send(.string("changePainting"))
}

//#-end-hidden-code
/*:

 Aha! You have found there! 
 
 The staff of the Temple of Heaven have some trouble.

 As a programmer, help them with your new learned machine learning knowledge!

Good luck!


 Note:

 *I trained two mlmodels, one to recognize the dytasty and the other is used to colorize. Since WWDC limits the size up to 25MB, I can not add colorize.mlmodel there and use the result after colorization, the mlmodel can be found on my GitHub.*

 
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, polish())
//#-code-completion(identifier, show, recognize())
//#-code-completion(identifier, show, changePainting())
