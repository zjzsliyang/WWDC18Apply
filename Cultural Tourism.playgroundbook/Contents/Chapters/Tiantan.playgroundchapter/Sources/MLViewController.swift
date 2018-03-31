// MLViewController.swift
// Created by Yang Li on 31/03/2018.
//
// Copyright © 2018 Yang Li, Tongji University, Shanghai.
// All rights reserved.
//

import UIKit
import PlaygroundSupport

public class MLViewController: UIViewController {

    var backgroundView1 = UIImageView()
    var backgroundView2 = UIImageView()

    override public func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        backgroundView1.image = UIImage(named: "bg1.png")
        backgroundView1.frame = CGRect(x: 0, y: 0, width: 1200 / 3 , height: 581 / 3)
        view.addSubview(backgroundView1)

        backgroundView2.image = UIImage(named: "bg2.png")
        backgroundView2.frame = CGRect(x: 400, y: 600, width: 485 / 2, height: 674 / 2)
        view.addSubview(backgroundView2)
    }
}