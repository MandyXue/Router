//
//  InfoSettingController.swift
//  Router
//
//  Created by  Harold LIU on 5/18/16.
//  Copyright © 2016 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud
import SDWebImage
import MBProgressHUD

class InfoSettingController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //MARK:- Params
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var carNumber: UILabel!
    @IBOutlet weak var carType: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var distict: UILabel!
   
    var chooseImage:UIImage?
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setInfo()
    }
    //MARK:- Helper
    func setInfo() {
        uploadPic()
        usernameLabel.text = RouterUser.currentUser().username
        AVFile.getFileWithObjectId(RouterUser.currentUser().avatar?.objectId) { (file: AVFile!, error: NSError!) in
            if (error == nil) {
                let data = file.getData()
                self.avatar.image = UIImage(data: data)
            } else {
                print(error)
            }
        }
        carNumber.text = RouterUser.currentUser().carNumber
        carType.text = RouterUser.currentUser().carType
        email.text = RouterUser.currentUser().email
        phone.text = RouterUser.currentUser().mobilePhoneNumber
        gender.text = RouterUser.currentUser().gender
        distict.text = RouterUser.currentUser().district
    }
    
    func cameraAction() {
        let alertSheet = UIAlertController(title: "", message: "", preferredStyle: .ActionSheet)
        alertSheet.addAction(UIAlertAction(title: "拍照", style: .Default, handler: { (action) in
            self.getCamera()
        }))
        alertSheet.addAction(UIAlertAction(title: "从照片中选择", style: .Default, handler: { (action) in
            self.getAlbum()
        }))
        alertSheet.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil))
        presentViewController(alertSheet, animated: true, completion: nil)
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

    
    //MARK:- Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("editInfo") as! EditInfoViewController
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                cameraAction()
                break
            case 1:
                vc.title = "修改用户名"
                vc.info = usernameLabel.text
                navigationController?.pushViewController(vc, animated: true)
                break
            case 2:
                vc.title = "修改车牌号"
                vc.info = carNumber.text
                navigationController?.pushViewController(vc, animated: true)
                break
            case 3:
                vc.title = "修改车型"
                vc.info = carType.text
                navigationController?.pushViewController(vc, animated: true)
                break
            default:break
            }
        }
        else {
            switch indexPath.row {
            case 0:
                vc.title = "修改邮箱"
                vc.info = email.text
                navigationController?.pushViewController(vc, animated: true)
                break
            case 1:
                vc.title = "修改手机号"
                vc.info = phone.text
                navigationController?.pushViewController(vc, animated: true)
                break
            case 2:
                vc.title = "修改性别"
                vc.info = gender.text
                navigationController?.pushViewController(vc, animated: true)
                break
            case 3:
                vc.title = "修改地区"
                vc.info = distict.text
                navigationController?.pushViewController(vc, animated: true)
                break
            default:break
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
            chooseImage = image
            self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    func uploadPic() {
        guard chooseImage != nil else {
            
            return
        }
        let file = AVFile(data: UIImagePNGRepresentation(chooseImage!))
        let hud =  MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = .Indeterminate
        hud.labelText = "正在上传..."
        file.saveInBackgroundWithBlock { (status, error) in
            if status {
                hud.mode = .CustomView
                let imageView = UIImage(named: "Checkmark")?.imageWithRenderingMode(.AlwaysTemplate)
                hud.customView = UIImageView(image:imageView)
                hud.square = true
                hud.labelText = "上传成功"
                hud.hide(true, afterDelay: 1)
                self.delay(2, closure: {
                    RouterUser.currentUser().avatar = file
                    self.avatar.image = self.chooseImage
                })
            }
            else {
                self.delay(2, closure: {
                    print(error)
                    hud.mode = .Text
                    hud.labelText = "上传失败，请检查网络"
                    hud.hide(true, afterDelay: 1)
                })
            }
        }
    }
    
}
