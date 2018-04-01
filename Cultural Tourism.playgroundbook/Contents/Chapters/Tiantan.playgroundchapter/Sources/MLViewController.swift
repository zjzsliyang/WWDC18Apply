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
    let materials = ["DwellingintheFuchunMountain_bw.jpg", "AlongRiverDuringQingmingFestival_bw.jpg"]
    let materialsRes = ["DwellingintheFuchunMountain_res.jpg", "AlongRiverDuringQingmingFestival_res.jpg"]
    let descriptions = ["Dwelling in the Fuchun Mountains \n\n This is one of the few surviving works by the painter Huang Gongwang (1269–1354) and it is considered to be among his greatest works. The Chinese landscape painting was burnt into two pieces in 1650.", "Along the River During the Qingming Festival \n\n Along the River During the Qingming Festival, also known by its Chinese name as the Qingming Shanghe Tu, is a painting by the Song dynasty artist Zhang Zeduan (1085–1145). It has been called \"China's Mona Lisa.\""]
    var index = 0
    var colorized = 0

    var backgroundView = UIImageView()
    var paintings = UIImageView()
    var paintingsNew = UIImageView()
    var detailView = UIImageView()
    var recognitionLabel = UILabel()

    override public func viewDidLoad() {
        super.viewDidLoad()

        backgroundView.image = UIImage(named: "bg2.jpg")
        backgroundView.frame = CGRect(x: 0, y: 0, width: view.frame.height / 1.5, height: view.frame.height)
        view.addSubview(backgroundView)

        paintings.image = UIImage(named: materials[index])
        paintings.contentMode = .scaleAspectFill
        paintings.frame = CGRect(x: 10, y: view.frame.height - 130 - view.frame.width / 12.0, width: view.frame.width / 2.0 - 20, height: view.frame.width / 12.0)
        paintings.clipsToBounds = true
        view.insertSubview(paintings, at: 2)

        let outerView = UIView(frame: paintings.frame)
        outerView.clipsToBounds = false
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 1
        outerView.layer.shadowOffset = CGSize.zero
        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 0).cgPath
        view.insertSubview(outerView, at: 1)

        detailView.frame = CGRect(x: view.frame.width / 2 - view.frame.height / 4, y: view.frame.height / 5, width: view.frame.height / 2, height: view.frame.height / 2)
        detailView.layer.masksToBounds = false
        detailView.clipsToBounds = true
        detailView.layer.borderWidth = 1
        detailView.layer.borderColor = UIColor(red: 151 / 255, green: 121 / 255, blue: 102 / 255, alpha: 1).cgColor
        detailView.layer.cornerRadius = detailView.frame.height / 2
        updateDetailView(point: CGPoint(x: 0, y: 0))
        view.addSubview(detailView)
    }

    func updateDetailView(point: CGPoint) {
        if !(paintings.bounds.contains(point)) {
            return
        }
        var tmpView = UIImageView()
        if colorized == 0 {
            tmpView.image = paintings.image
        } else {
            tmpView.image = paintingsNew.image
        }
        let detailImage = tmpView.image?.cgImage?.cropping(to: CGRect(x: 3 * point.x, y: 0, width: detailView.frame.width, height: detailView.frame.height))
        detailView.contentMode = .scaleAspectFill
        detailView.image = UIImage(cgImage: detailImage!)
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch: UITouch = touches.first {
            updateDetailView(point: touch.location(in: self.paintings))
        }
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch: UITouch = touches.first {
            updateDetailView(point: touch.location(in: self.paintings))
        }
    }

    func polish() {
        colorized = 1
        paintingsNew.image = UIImage(named: materialsRes[index])
        paintingsNew.contentMode = .scaleAspectFill
        paintingsNew.frame = paintings.frame
        paintingsNew.clipsToBounds = true
        paintingsNew.alpha = 0
        view.insertSubview(paintingsNew, at: 3)

        UIView.animate(withDuration: 3, delay: 0.0, options: [], animations: {
            self.paintingsNew.alpha = 1
        }, completion: { (finished: Bool) in
            self.updateDetailView(point: CGPoint(x: 0, y: 0))
        })
    }

    func recognize() {
        let recognitionTitle = UILabel()
        recognitionTitle.frame = CGRect(x: view.frame.height / 4 - 20, y: view.frame.height / 10 - 10, width: 250, height: view.frame.height / 10)
        recognitionTitle.font = UIFont(name: "Avenir-Heavy", size: 18)
        recognitionTitle.text = "Dynasty Possibility:"
        view.addSubview(recognitionTitle)

        recognitionLabel.frame = CGRect(x: view.frame.height / 4, y: view.frame.height / 6, width: 250, height: view.frame.height / 8)
        recognitionLabel.numberOfLines = 0
        recognitionLabel.font = UIFont(name: "Avenir-Heavy", size: 15)
        recognitionLabel.textColor = UIColor(red: 151 / 255, green: 121 / 255, blue: 102 / 255, alpha: 1)
        recognizeUsingVision(image: paintings.image!, label: recognitionLabel)

        view.addSubview(recognitionLabel)
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

    func changePainting() {
        index = (index + 1) % 2
        
        paintings.image = UIImage(named: materials[index])
        updateDetailView(point: CGPoint(x: 0, y: 0))
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
            if text == "changePainting" {
                changePainting()
            }
        default:
            break
        }
    }
}
