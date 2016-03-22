//
//  ChangePasswordTableVC.swift
//  DentalDsign
//
//  Created by Nimble Chapps on 29/01/16.
//  Copyright © 2016 Nimble Chapps. All rights reserved.
//

import UIKit

class ChangePasswordTableVC: UITableViewController {

    let userDetails = NSUserDefaults.standardUserDefaults().objectForKey("UserData")
    let token = NSUserDefaults.standardUserDefaults().objectForKey("TOKEN") as? String
    
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBOutlet weak var btnChange: UIButton! {
        didSet{
            btnChange.roundedButton()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTap:"))

    }

    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func btnChangeTapped(sender: AnyObject) {
        
        if txtOldPassword.text?.characters.count == 0{
            let alertView = UIAlertController(title: kAppName, message: "Please enter your old password.", preferredStyle: UIAlertControllerStyle.Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertView.addAction(defaultAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            
        }
        else if txtNewPassword.text?.characters.count == 0{
            let alertView = UIAlertController(title: kAppName, message: "Please enter new password.", preferredStyle: UIAlertControllerStyle.Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertView.addAction(defaultAction)
            self.presentViewController(alertView, animated: true, completion: nil)
        }
        else if txtConfirmPassword.text?.characters.count == 0{
            let alertView = UIAlertController(title: kAppName, message: "Please confirm your password.", preferredStyle: UIAlertControllerStyle.Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertView.addAction(defaultAction)
            self.presentViewController(alertView, animated: true, completion: nil)
        }
        else{
            
            if !Validation.isPasswordSame(txtNewPassword.text!, confirmPassword: txtConfirmPassword.text!){
                let alertView = UIAlertController(title: kAppName, message: "Passwords do not match.", preferredStyle: UIAlertControllerStyle.Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertView.addAction(defaultAction)
                self.presentViewController(alertView, animated: true, completion: nil)
            }
            else if !Validation.isPwdLenth(txtNewPassword.text!, confirmPassword: txtConfirmPassword.text!){
                let alertView = UIAlertController(title: kAppName, message: "Password length must be at least 6 characters.", preferredStyle: UIAlertControllerStyle.Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertView.addAction(defaultAction)
                self.presentViewController(alertView, animated: true, completion: nil)
            }
            else{
                self.changePassword(userDetails as! NSDictionary)
            }
        }
    }
    
    func changePassword(userData : NSDictionary) ->Void{
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let changePwd : [String : AnyObject] = [kUserAPIKey : "dental!123"  , kUserOldPassword : txtOldPassword.text! , kUserNewPassword : txtNewPassword.text! , kUserID : userData.objectForKey(kUserID)!]
        
        WebServies.makePost("changepassword", parameter: changePwd) { (json, error) -> () in
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            
            if error == nil {
                let mesg = "msg"
                let alert = UIAlertController(title: "TeethLog", message: "\(json.objectForKey(mesg) as! String)", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (result : UIAlertAction) -> Void in
                    
                    self.navigationController?.popViewControllerAnimated(true)
                })
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)            }
            else {
                let alertView = UIAlertController(title: "TeethLog", message: "\(json.objectForKey("msg") as! String)", preferredStyle: UIAlertControllerStyle.Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertView.addAction(defaultAction)
                self.presentViewController(alertView, animated: true, completion: nil)
            }
        }
        
    }
    
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == txtOldPassword{
            self.txtOldPassword.becomeFirstResponder()
        }else if textField == txtNewPassword{
            self.txtConfirmPassword.becomeFirstResponder()
        }else{
            self.txtConfirmPassword.resignFirstResponder()
        }
        self.view.endEditing(true)
        return true
    }
}
