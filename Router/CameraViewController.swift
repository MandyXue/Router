//
//  CameraViewController.swift
//  Router
//
//  Created by  Harold LIU on 5/17/16.
//  Copyright © 2016 MandyXue. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var chooseImage: UIImage?
    
    
    //MARK:- Life Cycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "home_background")!)
    }
    
    //MARK:- Helper
    func getCamera()  {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .Camera;
            imagePicker.allowsEditing = false
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertView(title: "Sorry",
                                    message: "我们不能访问您的相机📷",
                                    delegate: nil,
                                    cancelButtonTitle: "Ok")
            alert.show()

        }
    }
    
    func getAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .PhotoLibrary;
            imagePicker.allowsEditing = false
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertView(title: "Sorry",
                                    message: "我们不能访问您的相册⛵️",
                                    delegate: nil,
                                    cancelButtonTitle: "Ok")
            alert.show()
        }
    }
    
    func saveImage() {
        let imageData = UIImageJPEGRepresentation(chooseImage!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        let alert = UIAlertView(title: "Wow",
                                message: "您的图片已经被成功保存",
                                delegate: nil,
                                cancelButtonTitle: "Ok")
        alert.show()
    }
    
    func cameraAction(camera:String) {
        let alertSheet = UIAlertController(title: "选择对摄像头\(camera)的操作", message: "", preferredStyle: .ActionSheet)
        alertSheet.addAction(UIAlertAction(title: "拍照", style: .Default, handler: { (action) in
            self.getCamera()
        }))
        alertSheet.addAction(UIAlertAction(title: "查看照片", style: .Default, handler: { (action) in
            self.getAlbum()
        }))
        alertSheet.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil))
        presentViewController(alertSheet, animated: true, completion: nil)
    }
    
    func showImage() {
        let alert = UIAlertController(title: "📷:", message: "是否保存到相册?", preferredStyle: .Alert)
         alert.addAction(UIAlertAction(title: "保存", style: .Default, handler: { (action) in
            self.saveImage()
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil))
        let imageView = UIImageView(frame: CGRectMake(190, 10, 70, 54))
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.image = chooseImage
        alert.view.addSubview(imageView)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK:- Action
    @IBAction func camera1() {
        cameraAction("1")
    }
    
    @IBAction func camera2() {
        cameraAction("2")
    }
    
    @IBAction func camera3() {
        cameraAction("3")
    }
    
    @IBAction func camera4() {
        cameraAction("4")
    }
    
    @IBAction func AddCamera() {
        let alert = UIAlertView(title: "Wow",
                                message: "摄像机已满不能添加😱",
                                delegate: nil,
                                cancelButtonTitle: "Ok")
        alert.show()
    }
    
    //MARK:- Delegate 
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        chooseImage = image
        self.dismissViewControllerAnimated(true, completion: nil);
        showImage()
    }
    
    
}
