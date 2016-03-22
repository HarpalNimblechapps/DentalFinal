//
//  ProfileTableVC.swift
//  DentalDsign
//
//  Created by Nimble Chapps on 29/01/16.
//  Copyright © 2016 Nimble Chapps. All rights reserved.
//

import UIKit

class ProfileTableVC: UITableViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate , UITextFieldDelegate {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var ImgProfile: UIImageView! {
        didSet {
            ImgProfile.layer.cornerRadius = 50.0
            ImgProfile.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var btnUpdateProfile: UIButton! {
        didSet{
            btnUpdateProfile.roundedButton()
        }
    }
    @IBOutlet weak var btnChangePassword: UIButton! {
        didSet{
            btnChangePassword.roundedButton()
        }
    }
    
    let userDetails = NSUserDefaults.standardUserDefaults().objectForKey("UserData")
    let imagP = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NSUserDefaults.standardUserDefaults().objectForKey("Login") as! String == "NormalLogin"{
            
            let subPath =  (userDetails?.objectForKey("vImage")! as? String)!
            let imageExtenstion = userDetails!.objectForKey("vExtension") as! String
            let imageP = kBaseImagePath+subPath+"_400_400"+imageExtenstion
            let urls = NSURL(string: imageP)
            self.ImgProfile.setImageWithURL(urls, placeholderImage: UIImage(named: "profilePlaceHolder"))
            
            
        }else{
            
            if userDetails?.objectForKey("vExtension")! as? String == ""{
                let imageURL = NSURL(string: (userDetails?.objectForKey("vImage")! as? String)!)
                self.ImgProfile.setImageWithURL(imageURL, placeholderImage: UIImage(named: "profilePlaceHolder"))
                
            }else{
                
                let subPath =  (userDetails?.objectForKey("vImage")! as? String)!
                let imageExtenstion = userDetails!.objectForKey("vExtension") as! String
                let imageP = kBaseImagePath+subPath+"_400_400"+imageExtenstion
                let urls = NSURL(string: imageP)
                self.ImgProfile.setImageWithURL(urls, placeholderImage: UIImage(named: "profilePlaceHolder"))
            }
        }
        
        self.txtEmail.text = userDetails?.objectForKey("vEmail")! as? String
        self.txtName.text = userDetails?.objectForKey("vName")! as? String
        
        self.tableView.endEditing(true)
        self.view.endEditing(true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func changeProfileTapped(sender: AnyObject) {
        
        let ActionSheet = UIAlertController(title: nil, message: "Select Photo", preferredStyle: .ActionSheet)
        
        let cameraPhoto = UIAlertAction(title: "Camera", style: .Default, handler: {
            (alert: UIAlertAction) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
                
                self.imagP.delegate = self
                self.imagP.sourceType = UIImagePickerControllerSourceType.Camera;
                self.imagP.allowsEditing = false
                
                self.presentViewController(self.imagP, animated: true, completion: nil)
            }
            else{
                //println("No Camrera")
            }
            
        })
        
        let PhotoLibrary = UIAlertAction(title: "Photo Library", style: .Default, handler: {
            (alert: UIAlertAction) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
                
                self.imagP.delegate = self
                self.imagP.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
                self.imagP.allowsEditing = false
                
                self.presentViewController(self.imagP, animated: true, completion: nil)
            }
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction) -> Void in
            
        })
        
        ActionSheet.addAction(cameraPhoto)
        ActionSheet.addAction(PhotoLibrary)
        ActionSheet.addAction(cancelAction)
        
        self.presentViewController(ActionSheet, animated: true, completion: nil)
    }
    
    
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
        
        ImgProfile.image=info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.None)
    }
    
    
    @IBAction func btnLogoutTapped(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject("none", forKey: "isLogin")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    @IBAction func btnUpdateProfileTapped(sender: AnyObject) {
        if txtName.text?.characters.count == 0 {
            let alertView = UIAlertController(title: kAppName, message: "Please enter new name.", preferredStyle: UIAlertControllerStyle.Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertView.addAction(defaultAction)
            self.presentViewController(alertView, animated: true, completion: nil)
        }
        else {
            self.editProfile(userDetails as! NSDictionary)
        }
    }
    
    
    func editProfile(userData : NSDictionary) ->Void{
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let dictImage : [String : AnyObject] = [kUserAPIKey : "dental!123" , kUserEmailID : userData.objectForKey(kUserEmailID)! , kUserName : txtName.text!, kUserID : userData.objectForKey(kUserID)!]
        
        WebServies.uploadFile(UIImageJPEGRepresentation(ImgProfile.image!, 0.5)!, url: "profile/editprofile", name: kUserImage, fileName: "image.jpg", mimeType: "image/jpg", parameters: dictImage) { (json, error) -> () in
            
            MBProgressHUD.hideAllHUDsForView(self.view, animated:  true)
            if error == nil {
                if json.objectForKey("status") as! String == "401" {
                    let alertView = UIAlertController(title: kAppName, message: json.objectForKey("msg") as! String, preferredStyle: UIAlertControllerStyle.Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertView.addAction(defaultAction)
                    self.presentViewController(alertView, animated: true, completion: nil)
                }
                else {
                    let userDict = json.objectForKey("data")!.objectAtIndex(0)
                    NSUserDefaults.standardUserDefaults().setObject(userDict, forKey: "UserData")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    let alertView = UIAlertController(title: kAppName, message: json.objectForKey("msg") as! String, preferredStyle: UIAlertControllerStyle.Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertView.addAction(defaultAction)
                    self.presentViewController(alertView, animated: true, completion: nil)
                }
            }
            else {
                let alertView = UIAlertController(title: kAppName, message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertView.addAction(defaultAction)
                self.presentViewController(alertView, animated: true, completion: nil)
            }
        }
    }
}
