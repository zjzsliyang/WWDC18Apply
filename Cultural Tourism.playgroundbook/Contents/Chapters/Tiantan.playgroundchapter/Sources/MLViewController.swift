// MLViewController.swift
// Created by Yang Li on 31/03/2018.
//
// Copyright © 2018 Yang Li, Tongji University, Shanghai.
// All rights reserved.
//

import UIKit
import PlaygroundSupport

public class MLViewController: UIViewController {

    var backgroundView = UIImageView()
    var backgroundView1 = UIImageView()
    var backgroundView2 = UIImageView()

    var paintings1 = UIImageView()
    var paintings2 = UIImageView()

    override public func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.image = UIImage(named: "bg.jpg")
        backgroundView.frame = view.bounds
        view.addSubview(backgroundView)

        // view.backgroundColor = UIColor.white
        backgroundView1.image = UIImage(named: "bg1.png")
        backgroundView1.frame = CGRect(x: 0, y: 0, width: 1200 / 3.0 , height: 581 / 3.0)
        view.addSubview(backgroundView1)

        backgroundView2.image = UIImage(named: "bg2.png")
        backgroundView2.frame = CGRect(x: 420, y: 700, width: 485 / 2.0, height: 674 / 2.0)
        view.addSubview(backgroundView2)

        paintings1.image = UIImage(named: "AlongRiverDuringQingmingFestival.jpg")
        paintings2.image = UIImage(named: "AThousandMilesofRiversandMountains.jpg")
        paintings1.frame = CGRect(x: 0, y: 230, width: 800, height: 800 / 6.0)
        paintings2.frame = CGRect(x: 0, y: 450 + 800 / 6.0, width: 800, height: 800 / 6.0)
        view.addSubview(paintings1)
        view.addSubview(paintings2)
    }
}