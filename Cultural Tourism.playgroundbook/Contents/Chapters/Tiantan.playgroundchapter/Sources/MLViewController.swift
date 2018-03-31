// MLViewController.swift
// Created by Yang Li on 31/03/2018.
//
// Copyright © 2018 Yang Li, Tongji University, Shanghai.
// All rights reserved.
//

import UIKit
import Vision
import CoreML
import PlaygroundSupport

@available(iOS 11.2, *)
public class MLViewController: UIViewController {

    var backgroundView = UIImageView()
    var backgroundView1 = UIImageView()
    var backgroundView2 = UIImageView()

    var paintings1 = UIImageView()
    var paintings2 = UIImageView()
    var recognitionLabel1 = UILabel()
    var recognitionLabel2 = UILabel()

    override public func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.image = UIImage(named: "bg.jpg")
        backgroundView.frame = view.bounds
        view.addSubview(backgroundView)

        backgroundView1.image = UIImage(named: "bg1.png")
        backgroundView1.frame = CGRect(x: 0, y: 0, width: 1200 / 3.0 , height: 581 / 3.0)
        view.addSubview(backgroundView1)

        backgroundView2.image = UIImage(named: "bg2.png")
        backgroundView2.frame = CGRect(x: 420, y: 700, width: 485 / 2.0, height: 674 / 2.0)
        view.addSubview(backgroundView2)

        paintings1.image = UIImage(named: "AlongRiverDuringQingmingFestival_bw.jpg")
        paintings2.image = UIImage(named: "DwellingintheFuchunMountain_bw.jpg")
        paintings1.frame = CGRect(x: 0, y: 230, width: 800, height: 800 / 6.0)
        paintings2.frame = CGRect(x: 0, y: 450 + 800 / 6.0, width: 800, height: 800 / 6.0)
        view.addSubview(paintings1)
        view.addSubview(paintings2)
    }

    func polish() {
        // TODO: add imageview animation
        paintings1.image = UIImage(named: "AlongRiverDuringQingmingFestival_res.jpg")
        paintings2.image = UIImage(named: "DwellingintheFuchunMountain_res.jpg")

        // TODO: add line animation
    }

    func recognize() {
        recognitionLabel1.frame = CGRect(x: 420, y: 10, width: 250, height: 200)
        recognitionLabel2.frame = CGRect(x: 50, y: 450 + 800 / 6.0 + 150, width: 300, height: 200)
        recognitionLabel1.numberOfLines = 0
        recognitionLabel2.numberOfLines = 0
        
        recognizeUsingVision(image: paintings1.image!, label: recognitionLabel1)
        recognizeUsingVision(image: paintings2.image!, label: recognitionLabel2)

        view.addSubview(recognitionLabel1)
        view.addSubview(recognitionLabel2)
    }

    func recognizeUsingVision(image: UIImage, label: UILabel) {
        let model = DynastyRecognitionReduced()
        guard let visionModel = try? VNCoreMLModel(for: model.model) else {
            fatalError("something wrong")
        }
        let request = VNCoreMLRequest(model: visionModel) { request, error in
            if let observations = request.results as? [VNClassificationObservation] {
                let res = observations.prefix(through: 2).map { ($0.identifier, Double($0.confidence)) }
                self.show(results: res, label: label)
            }
        }
        request.imageCropAndScaleOption = .centerCrop
        let handler1 = VNImageRequestHandler(cgImage: image.cgImage!)
        try? handler1.perform([request])
    }

    typealias Recognition = (String, Double)

    func show(results: [Recognition], label: UILabel) {
        var s: [String] = []
        for (i, pred) in results.enumerated() {
            s.append(String(format: "%d: %@ (%3.2f%%)", i + 1, pred.0, pred.1 * 100))
        }
        label.text = s.joined(separator: "\n\n")
    }
}

@available(iOS 11.2, *)
extension MLViewController: PlaygroundLiveViewMessageHandler {
    public func receive(_ message: PlaygroundValue) {
        switch message {
        case let .string(text):
            if text == "polish" {
                polish()
            }
            if text == "recognize" {
                recognize()
            }
        default:
            break
        }
    }
}
