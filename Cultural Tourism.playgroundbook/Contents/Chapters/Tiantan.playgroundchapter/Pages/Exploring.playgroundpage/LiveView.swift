// LiveView.swift
// Created by Yang Li on 31/03/2018.
//
// Copyright © 2018 Yang Li, Tongji University, Shanghai.
// All rights reserved.
//

import PlaygroundSupport
import UIKit

let page = PlaygroundPage.current
if #available(iOS 11.0, *) {
    page.liveView = ARViewController()
}

