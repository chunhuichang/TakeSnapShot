//
//  ViewController.swift
//  TestProj04
//
//  Created by i9400519 on 2019/12/6.
//  Copyright © 2019 i9400519. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func shareClick(_ sender: UIButton) {
        
        //snap shot
        let screenshot = self.takeSnapShot(currentView: self.view, hideViews: [self.label1])
        
        //share photo
        let activityViewController = UIActivityViewController(activityItems: [screenshot], applicationActivities: nil)
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceRect = sender.convert(sender.bounds, to: self.view)
            popoverController.sourceView = self.view
            popoverController.permittedArrowDirections = .left
        }

        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    //截圖
    func takeSnapShot(currentView: UIView , hideViews: [UIView]?) -> UIImage {
        // excluded view
        if let hideViews = hideViews {
            for hideView in hideViews {
                hideView.isHidden = true
            }
        }

        // begin
        UIGraphicsBeginImageContextWithOptions(currentView.frame.size, false, 0.0)
        
        // draw view in that context.
        currentView.drawHierarchy(in: currentView.bounds, afterScreenUpdates: true)
        
        // get iamge
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let hideViews = hideViews {
            for hideView in hideViews {
                hideView.isHidden = false
            }
        }
        
        if (image != nil){
            return image!
        }
        
        return UIImage()
    }
}

