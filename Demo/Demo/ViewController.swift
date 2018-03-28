//
//  ViewController.swift
//  Demo
//
//  Created by Yang Li on 25/03/2018.
//  Copyright © 2018 Yang LI. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.session.delegate = self
        
//        let scene = SCNScene(named: "tiantan.scnassets/ship.scn")!
        
        let scene = SCNScene(named: "tiantan.scnassets/tiantannew.DAE")!
//        let tiantan = scene.rootNode.childNode(withName: "_D_Models_at_3dxy", recursively: true)!
//        print(tiantan.scale)
//        let action = SCNAction.scale(by: 0.1, duration: 1.0)
//        tiantan.runAction(action)
        
//        print(tiantan.scale)
        print(sceneView.frame)
        
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.isLightEstimationEnabled = true
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        print(frame.camera.transform)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print("anchor: \(anchor)")
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard let pointOfView = sceneView.pointOfView else {
            return
        }
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, transform.m33)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        print("----")
        print(orientation)
        print(location)
        print("----")
    }
}
