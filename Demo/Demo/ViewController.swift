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

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
        
//        let scene = SCNScene(named: "tiantan.scnassets/tiantannew.DAE")!
//        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.isLightEstimationEnabled = true
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {
            return
        }
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        guard let tiantanScene = SCNScene(named: "tiantan.scnassets/tiantannew.DAE"),
            let tiantanNode = tiantanScene.rootNode.childNode(withName: "_D_Models_at_3dxy", recursively: true)
            else { return }

        tiantanNode.runAction(SCNAction.scale(by: 0.1, duration: 1.0))
        tiantanNode.position = SCNVector3(x - 1, y, z)

        node.addChildNode(tiantanNode)

    }
    
}
