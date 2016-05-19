//
//  NewDiscoverViewController.swift
//  Router
//
//  Created by MandyXue on 16/5/19.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud
import MBProgressHUD

class NewDiscoverViewController: UIViewController, UITextViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate {
    
    var sharing = SharingModel()
    
    @IBOutlet weak var contentTextView: UITextView! {
        didSet {
            contentTextView.delegate = self
            contentTextView.returnKeyType = .Done
            contentTextView.text = "这一刻的想法..."
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - BaseViewController
    
    static func loadFromStoryboard() -> UIViewController {
        let controller = UIStoryboard.router_discoverStoryboard().instantiateViewControllerWithIdentifier(self.router_className())
        return controller
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "新建朋友圈"
        
        setUpUI()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Text View Delegate
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if (textView.text == "这一刻的想法...") {
            textView.text = ""
            textView.textColor = UIColor.blackColor()
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if (textView.text == "") {
            textView.text = "这一刻的想法..."
            textView.textColor = UIColor.lightGrayColor()
        }
        textView.resignFirstResponder()
    }
    
    // MARK: - ImagePickerController Delegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let imageToSave = info[UIImagePickerControllerEditedImage]
        imageView.image = imageToSave as? UIImage
        let data = UIImagePNGRepresentation((imageToSave as? UIImage)!)
        let file = AVFile(data: data)
        sharing.image = file
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - ActionSheet Delegate
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch(buttonIndex) {
        case 1:
            print("拍照")
            takePhotoByCamera()
        case 2:
            print("从相册选取")
            choosePhotoFromAlbum()
        default: break
        }
    }
    
    // MARK: - Helper
    
    func setUpUI() {
        // navigation bar items
        let rightBarButton = UIBarButtonItem(title: "发布", style: .Plain, target: self, action: #selector(post))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageClicked))
        imageView.addGestureRecognizer(tapGesture)
        self.imageView.userInteractionEnabled = true
    }
    
    func post(sender: UIBarButtonItem) {
        if (sharing.image != nil) {
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = .AnnularDeterminate
            hud.labelText = "上传中..."
            if contentTextView.text == nil {
                hud.hide(true)
                let alert = UIAlertController(title: "错误❌", message: "内容不可以为空", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "关闭", style: .Cancel, handler: { (action: UIAlertAction) -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                // 获取内容
                sharing.content = contentTextView.text
                sharing.user = RouterUser.currentUser()
                sharing.username = RouterUser.currentUser().username
                sharing.saveInBackgroundWithBlock({ (succeed: Bool, error: NSError!) -> Void in
                    hud.hide(true)
                    if (succeed) {
                        let alert = UIAlertController(title: "上传成功😆", message: nil, preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "关闭", style: .Cancel, handler: { (action: UIAlertAction) -> Void in
                            self.navigationController?.popViewControllerAnimated(true)
                        }))
                        self.presentViewController(alert, animated: true, completion: nil)
                        print("succeed")
                    } else {
                        let alert = UIAlertController(title: "上传失败😭", message: nil, preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "关闭", style: .Cancel, handler: { (action: UIAlertAction) -> Void in
                            self.navigationController?.popViewControllerAnimated(true)
                        }))
                        self.presentViewController(alert, animated: true, completion: nil)
                        print("fail")
                    }
                })
            }
        }
    }
    
    func imageClicked() {
        let actionSheet = getImagePickerActionSheet()
        actionSheet.showInView(self.view)
    }
    
    func getImagePickerActionSheet() -> UIActionSheet {
        let actionSheet = UIActionSheet(title: "选取照片", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从相册选取")
        actionSheet.actionSheetStyle = .BlackOpaque
        return actionSheet
    }
    
    // 从相册选取照片
    func choosePhotoFromAlbum() {
        let ipc = UIImagePickerController()
        ipc.delegate = self
        ipc.sourceType = .PhotoLibrary
        ipc.allowsEditing = true
        presentViewController(ipc, animated: true, completion: nil)
    }
    
    // 拍照
    func takePhotoByCamera() {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
