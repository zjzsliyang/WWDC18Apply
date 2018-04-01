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

 *Please use this playgroundbook in landscape mode.*

 Aha! After you exploring the Temple of Heaven. There are several faded paintings inside.

 As a programmer, help them with your new learned machine learning knowledge!

 Good luck!

 * callout(use mlmodel to colorize the faded paintings):
 `polish()`

 * callout(use mlmodel to speculate the dynasty of the painting):
 `recognize()`

 * callout(change to another painting):
 `changePainting()`

 Special feature introduction: 
 
 Slide your finger on the painting to observe the part of the painting in the semicircular "bronze mirror".

 Note: Do not forget to remove the previous function while call a new function!

 *I have trained two mlmodels, the one use to colorize is pretty large. Since WWDC limits the size up to 25MB, I can only use the result after colorization, the mlmodel can be found on my GitHub: https://github.com/zjzsliyang/WWDC18Apply/.*

 
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, polish())
//#-code-completion(identifier, show, recognize())
//#-code-completion(identifier, show, changePainting())
