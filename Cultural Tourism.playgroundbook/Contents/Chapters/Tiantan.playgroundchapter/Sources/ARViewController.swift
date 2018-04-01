// ARViewController.swift
// Created by Yang Li on 31/03/2018.
//
// Copyright © 2018 Yang Li, Tongji University, Shanghai.
// All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import PlaygroundSupport

@available(iOS 11.0, *)
public class ARViewController: UIViewController, ARSCNViewDelegate {

    var backgroundView = UIImageView()
    var blurView: UIVisualEffectView?
    var cnt = 0

    lazy var isARWorldTrackingSupported: Bool = { return ARWorldTrackingConfiguration.isSupported }()

    override public func viewDidLoad() {
        super.viewDidLoad()

        backgroundView.image = UIImage(named: "bg.jpg")
        backgroundView.backgroundColor = UIColor.black
        backgroundView.frame = CGRect(x: 0, y: 0, width: view.frame.height / 1.5, height: view.frame.height)
        view.addSubview(backgroundView)
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard isARWorldTrackingSupported else {
            displayUnsupportedMessage()
            return
        }

        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            // The playground handles the granted/not-granted situations automatically. We're pre-empting to intentionally trigger AX notifications in the correct order.
        }
    }

    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't show the message again
        guard isARWorldTrackingSupported else { return }
    }

    private func displayUnsupportedMessage() {
        // This device does not support AR world tracking.
        let title = NSLocalizedString("This challenge is not supported on this device.", comment: "Title for unsupported iPad alert.")
        let message = NSLocalizedString("Augmented reality requires an iPad Pro or iPad (5th generation) running iOS 11.", comment: "Message for augmented reality not supported.")
        let buttonTitle = NSLocalizedString("OK", comment: "OK button title for unsupported iPad alert.")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        blurBackground()
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { action in
            self.unblurBackground()
        }))
        self.present(alertController, animated: true, completion: nil)
    }

    private func blurBackground() {
        let blurEffectView = UIVisualEffectView()
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        UIView.animate(withDuration: 0.5) {
            blurEffectView.effect = UIBlurEffect(style: .light)
        }
        
        blurView = blurEffectView
    }

    private func unblurBackground() {
        guard let blurEffectView = blurView else { return }
        
        UIView.animate(withDuration: 0.5, animations: {
            blurEffectView.effect = nil
        }, completion: { (complete: Bool) in
            blurEffectView.removeFromSuperview()
            self.blurView = nil
        })
    }

    func explore() {
        guard ARWorldTrackingConfiguration.isSupported else { return }
        
        let arscnView = ARSCNView(frame: view.frame)
        arscnView.delegate = self
        view.addSubview(arscnView)
        backgroundView.isHidden = true
        
        arscnView.translatesAutoresizingMaskIntoConstraints = false
        // Constraints for new arscnView
        NSLayoutConstraint.activate([
            arscnView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            arscnView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            arscnView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            arscnView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        ])
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.isLightEstimationEnabled = true
        arscnView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
//        arscnView.session.run(configuration)
        
        // Automatic VoiceOver to notify user screen is now on camera view
        let axScreenDescription = NSLocalizedString("The screen is now displaying a direct camera feed.", comment: "Camera screen description initial page.")
        UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, axScreenDescription)
    }

    public func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {
            return
        }
        // TODO: to be optimized
        if cnt == 0 {
            let x = CGFloat(planeAnchor.center.x)
            let y = CGFloat(planeAnchor.center.y)
            let z = CGFloat(planeAnchor.center.z)
            let tiantanScene = SCNScene(named: "art.scnassets/tiantannew.scn")!
            let tiantanNode = tiantanScene.rootNode.childNode(withName: "_D_Models_at_3dxy", recursively: true)!

            tiantanNode.runAction(SCNAction.scale(by: 0.1, duration: 1.0))
            tiantanNode.position = SCNVector3(x - 1, y, z)
            
            node.addChildNode(tiantanNode)
            cnt += 1
        }
    }
}

@available(iOS 11.0, *)
extension ARViewController: PlaygroundLiveViewMessageHandler {
    public func receive(_ message: PlaygroundValue) {
        switch message {
        case let .string(text):
            if text == "explore" {
                explore()
            }
        default:
            break
        }
    }
}
