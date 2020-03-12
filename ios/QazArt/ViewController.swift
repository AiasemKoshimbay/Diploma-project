//
//  ViewController.swift
//  Harry Pokker
//

import UIKit
import SceneKit
import ARKit
class ViewController: UIViewController, ARSCNViewDelegate, AVAudioPlayerDelegate {
  @IBOutlet weak var copy_button: UIButton!
    var newReferenceImages:Set<ARReferenceImage> = Set<ARReferenceImage>();
    var imageUrls = [""]
    var videoUrls = ["https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4", "https://kinogoo.cc/28882-prizrak-2015-smotret-online-na-kinogo.html"]
        var visiblebutton : Bool = false {
            didSet{
                if(visiblebutton == true){
                    DispatchQueue.main.async {
                   //     self.copy_button.isHidden = false
                   //     print("visible")

                    }}
                else{
                    DispatchQueue.main.async {
                  //      self.copy_button.isHidden = true
                 //       print("not visible")
                    }
                }
            }
        }
        public func resetTracking() {
            let configuration = ARImageTrackingConfiguration()
            configuration.trackingImages = newReferenceImages
            configuration.maximumNumberOfTrackedImages = 1
            sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors, .stopTrackedRaycasts])
        }
        func loadImageFrom(url: URL, completionHandler:@escaping(UIImage)->()) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                   //         print("loaded");
                            completionHandler(image);
                        }
                    }
                }
            }
        }
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            visiblebutton = false
//            sceneView.delegate = self
//            for url in imageUrls{
//                self.loadImageFrom(url: URL(string: url)!) { (result) in
//                    let arImage = ARReferenceImage(result.cgImage!, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.15)
//                    arImage.name = url;
//                    self.newReferenceImages.insert(arImage)
//                    self.resetTracking();
//            }
//            }
//
//        }
//
//        @IBAction func copyCode(_ sender: Any) {
//            DispatchQueue.main.async {
//              //    SCLAlertView().showInfo("Копирование", subTitle: "Вы скопировали промокод 1234456")
//
//            }
//            UIPasteboard.general.string = "1234456"
//        }
//        override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//
//            // Create a session configuration
//            let configuration = ARImageTrackingConfiguration()
//
//            // first see if there is a folder called "ARImages" Resource Group in our Assets Folder
//    //        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "ARImages", bundle: Bundle.main) {
//    //
//    //            // if there is, set the images to track
//    //            //configuration.trackingImages = trackedImages
//    //             configuration.trackingImages = newReferenceImages
//    //            // at any point in time, only 1 image will be tracked
//    //            configuration.maximumNumberOfTrackedImages = 1
//    //        }
//
//            // Run the view's session
//           // sceneView.session.run(configuration)
//        }
//
//        @IBAction func openQR(_ sender: UIButton) {
//            navigationController?.popViewController(animated: true)
//            dismiss(animated: true, completion: nil)
//        }
//        public func nodeRotation(heading: Double) -> SCNVector4 {
//            return SCNVector4(0, 1, 0, Double.pi - ((heading * (Double.pi/180)) - Double.pi))
//        }
//        override func viewWillDisappear(_ animated: Bool) {
//            super.viewWillDisappear(animated)
//
//            // Pause the view's session
//            sceneView.session.pause()
//        }
//
//        // MARK: - ARSCNViewDelegate
//
//        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//            //visiblebutton = false
//
//             guard let imageAnchor = anchor as? ARImageAnchor else {return}
//            var fileUrlString = "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
//            var index = 0
//            for i in imageUrls{
//                if i == imageAnchor.referenceImage.name {
//                    if(videoUrls[index] != nil){
//                        fileUrlString = videoUrls[index]
//                    }
//                }
//                index += 1
//            }
//                  let videoItem = AVPlayerItem(url: URL(string: fileUrlString)!)
//
//            var player = AVPlayer(playerItem: videoItem)
//
//            if let plr = AVPlayer(url: URL(string: fileUrlString)!) as? AVPlayer {
//                player = plr
//            }
//            var videoNode = SKVideoNode(avPlayer: player)
//            player.play()
//            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { (notification) in
//                player.seek(to: CMTime.zero)
//                player.play()
//            }
//            let videoScene = SKScene(size: CGSize(width: 480, height: 350))
//            videoNode.size = CGSize(width: 480, height: 350 )
//            videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
//            videoNode.yScale = -1.0
//            videoScene.addChild(videoNode)
//            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
//            // set the first materials content to be our video scene
//            plane.firstMaterial?.diffuse.contents = videoScene
//            // create a node out of the plane
//            let planeNode = SCNNode(geometry: plane)
//            // since the created node will be vertical, rotate it along the x axis to have it be horizontal or parallel to our detected image
//            planeNode.eulerAngles.x = -Float.pi / 2
//            // finally add the plane node (which contains the video node) to the added node
//            node.addChildNode(planeNode)
//            if(imageAnchor.referenceImage.name == "4K Ultra HD - SAMSUNG UHD Demo- Nature in 4K"){
//                visiblebutton = true
//
//                if let particles = SKEmitterNode(fileNamed: "sparkle.sks") {
//                   // particles.advanceSimulationTime(5000)
//                    particles.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
//                    particles.zPosition = 15.0
//                playSound()
//                        videoScene.addChild(particles)
//                    particles.resetSimulation()
//                }
//            if let particles2 = SKEmitterNode(fileNamed: "firework2.sks") {
//               // particles.advanceSimulationTime(5000)
//                playSound()
//                particles2.position = CGPoint(x: videoScene.size.width - 100, y: 0)
//                particles2.zPosition = 15.0
//
//                    videoScene.addChild(particles2)
//                particles2.resetSimulation()
//            }
//            if let particles3 = SKEmitterNode(fileNamed: "firework3.sks") {
//                playSound()
//                      // particles.advanceSimulationTime(5000)
//                particles3.zPosition = 15.0
//
//                       particles3.position = CGPoint(x: videoScene.size.width - 200, y: 0)
//                           videoScene.addChild(particles3)
//                       particles3.resetSimulation()
//                   }
//
//            if let particles4 = SKEmitterNode(fileNamed: "firework2.sks") {
//                playSound()
//                      // particles.advanceSimulationTime(5000)
//                       particles4.position = CGPoint(x: 0, y: 0)
//                particles4.zPosition = 15.0
//                           videoScene.addChild(particles4)
//                       particles4.resetSimulation()
//                   }
//                DispatchQueue.main.async {
//                 //   self.copy_button.isHidden = false
//                   // SCLAlertView().showSuccess("Поздравляю", subTitle: "Вы нашли промокод. Чтобы скопировать его нажмите на кнопку выше или на видео.")
//
//                }
//
//                let text = SCNText(string: "1234456", extrusionDepth: 1)
//
//                        let material = SCNMaterial()
//                                       material.diffuse.contents = UIColor.green
//                                       text.materials = [material]
//                            let textNode2 = SCNNode()
//                            textNode2.scale = SCNVector3(x:0.0025,y:0.0075,z:0.005)
//                            textNode2.geometry = text
//                            textNode2.position = SCNVector3(x: -0.05, y:0.0, z: -0.05)
//                            sceneView.scene.rootNode.addChildNode(textNode2)
//                            sceneView.autoenablesDefaultLighting = true
//                            node.addChildNode(textNode2)
//                            let material2 = SCNMaterial()
//
//                DispatchQueue.main.async {
//                             let clickableElement = ClickableView(frame: CGRect(x: 0, y: 0,
//                                                                                width: 480,
//                                                                                height: 350))
//                             clickableElement.tag = 1
//                             material2.diffuse.contents = clickableElement
//                         }
//
//                      let plane2 = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
//                         let planeNode2 = SCNNode(geometry: plane2)
//                         planeNode2.geometry?.firstMaterial = material2
//                         planeNode2.opacity = 0.25
//                         planeNode2.eulerAngles.x = -.pi / 2
//                         node.addChildNode(planeNode2)
//            }
//
//        }
//        func playSound(){
//    //        let path : NSString? = Bundle.main.path(forResource: "exposion", ofType: "mp3")! as NSString
//    //        let url = NSURL(fileURLWithPath: path! as String)
//    //        do{ let sound = try AVAudioPlayer(contentsOf: url as URL)
//    //            sound.delegate = self
//    //            sound.volume = 0.5
//    //        sound.play()}
//    //        catch{
//    //
//    //        }
//
//        }
//
//
//        func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//
//               if node.isHidden == true {
//                   if let imageAnchor = anchor as? ARImageAnchor {
//                       sceneView.session.remove(anchor: imageAnchor)
//                   }
//               } else {
//
//               }
//           }
//    }
//    class ClickableView: UIButton{
//        override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.addTarget(self, action:  #selector(objectTapped(_:)), for: .touchUpInside)
//            self.backgroundColor = .clear
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    @objc func objectTapped(_ sender: UIButton){
//
//       // print(" Скопировано \(tag)")
//    //
//       DispatchQueue.main.async {
//       //     SCLAlertView().showInfo("Копирование", subTitle: "Вы скопировали промокод 1234456")
//
//        }
//      UIPasteboard.general.string = "1234456"
//
//       }
//
//    }

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        // first see if there is a folder called "ARImages" Resource Group in our Assets Folder
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "ARImages", bundle: Bundle.main) {
            
            // if there is, set the images to track
            configuration.trackingImages = trackedImages
            // at any point in time, only 1 image will be tracked
            configuration.maximumNumberOfTrackedImages = 1
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let imageAnchor = anchor as? ARImageAnchor, let fileUrlString = Bundle.main.path(forResource: "black", ofType: "mp4") else {return}
        let videoItem = AVPlayerItem(url: URL(fileURLWithPath: fileUrlString))
        
        let player = AVPlayer(playerItem: videoItem)
        let videoNode = SKVideoNode(avPlayer: player)
        
        player.play()
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { (notification) in
            player.seek(to: CMTime.zero)
            player.play()
            print("Looping Video")
        }
        
        let videoScene = SKScene(size: CGSize(width: 480, height: 360))
        videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
        videoNode.yScale = -1.0
        videoScene.addChild(videoNode)
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
        plane.firstMaterial?.diffuse.contents = videoScene
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -Float.pi / 2
        node.addChildNode(planeNode)
    }
}
