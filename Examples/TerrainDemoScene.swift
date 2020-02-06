import Foundation
import SceneKit
import SpriteKit

/**
 Basic setup of camrea and lighting nodes for non-AR demo scenes.
 **/
@objc(MBTerrainDemoScene)
final class TerrainDemoScene: SCNScene {
    @objc public let cameraNode: SCNNode = Camera()
    @objc public let directionalLight: SCNNode = DirectionalLight()
    @objc public let debugNode: SCNNode = {
        let debugNode = SCNNode()
        
        for axis in ["x", "y", "z"] {
            let axisBox = SCNNode(geometry: SCNBox(
                width: axis == "x" ? 100 : 1,
                height: axis == "y" ? 100 : 1,
                length: axis == "z" ? 100 : 1,
                chamferRadius: 0
            ))
            let mat = SCNMaterial()
            if axis == "x" {
                mat.diffuse.contents = Color.red
            } else if axis == "y" {
                mat.diffuse.contents = Color.green
            } else if axis == "z" {
                mat.diffuse.contents = Color.blue
            }
            axisBox.geometry!.materials = [mat]
            axisBox.position = SCNVector3(0, 0, 0)
            axisBox.name = "\(axis) Axis Guide"
            debugNode.addChildNode(axisBox)
        }
        
        return debugNode
    }()
//    @objc public var floorColor: SKColor = Color.lightGray {
//        didSet {
//            floorNode.floorMaterial.diffuse.contents = floorColor
//        }
//    }
//    @objc public var floorReflectivity: CGFloat = 0.1 {
//        didSet {
//            floorNode.floor.reflectivity = floorReflectivity
//        }
//    }
//
//    fileprivate let floorNode: FloorNode = FloorNode()

    override init() {
        super.init()

        rootNode.addChildNode(debugNode)

//        rootNode.addChildNode(floorNode)
        rootNode.addChildNode(AmbientLight())
        rootNode.addChildNode(directionalLight)
        directionalLight.position = SCNVector3Make(0, 5000, 0)
        background.contents = Color(red: 61.0/255.0, green: 171.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        rootNode.addChildNode(cameraNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

fileprivate final class Camera: SCNNode {
    override init() {
        super.init()

        name = "Camera"
        camera = SCNCamera()
        camera!.automaticallyAdjustsZRange = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate final class DirectionalLight: SCNNode {
    override init() {
        super.init()
        name = "Directional Light"
        light = SCNLight()
        light!.type = .directional
        light!.color = Color.white
        light!.temperature = 5500
        light!.intensity = 1300
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate final class AmbientLight: SCNNode {
    override init() {
        super.init()
        name = "Ambient Light"
        light = SCNLight()
        light!.type = .ambient
        light!.color = Color(white: 0.6, alpha: 1.0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate final class FloorNode: SCNNode {
    let floorMaterial: SCNMaterial = SCNMaterial()
    let floor: SCNFloor = SCNFloor()

    override init() {
        floorMaterial.diffuse.contents = Color.lightGray
        floorMaterial.locksAmbientWithDiffuse = true
        floorMaterial.isDoubleSided = true

        floor.materials = [floorMaterial]
        floor.reflectivity = 0.1

        super.init()

        geometry = floor
        name = "Floor"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
