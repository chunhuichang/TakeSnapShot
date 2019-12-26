//
//  ViewController.swift
//  TestProj04
//
//  Created by Jill on 2019/12/6.
//  Copyright © 2019 Jill. All rights reserved.
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
        //such as copying items to the pasteboard, posting content to social media sites, sending items via email or SMS, and more.
        let activityViewController = UIActivityViewController(activityItems: [screenshot], applicationActivities: nil)
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceRect = sender.convert(sender.bounds, to: self.view)
            popoverController.sourceView = self.view
            //default .any
//            popoverController.permittedArrowDirections = .right
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
        //size:指定建立出來的bitmap大小
        //opaque:true為透明,false為不透明
        //scale:縮放,0為不縮放
        UIGraphicsBeginImageContextWithOptions(currentView.frame.size, false, 0.0)
        
        // draw view in that context.
        //afterScreenUpdates:是否重繪畫面
        currentView.drawHierarchy(in: currentView.bounds, afterScreenUpdates: true)
        
        // get iamge
        //取得UIGraphicsBeginImageContext所創的bitmap
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //清除UIGraphicsBeginImageContext產生的context
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

