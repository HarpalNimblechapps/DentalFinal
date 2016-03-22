//
//  LoginTableVC.swift
//  DentalDsign
//
//  Created by Nimble Chapps on 28/01/16.
//  Copyright © 2016 Nimble Chapps. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import TwitterKit

extension UIButton{
    func roundedButton(){
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 1.2
    }
}

class LoginTableVC: UITableViewController, UITextFieldDelegate{
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogIn: UIButton! {
        didSet{
            btnLogIn.roundedButton()
        }
    }
    @IBOutlet weak var lblForgotPsw: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 79.0/255.0, green: 75.0/255.0, blue: 103.0/255.0, alpha: 1)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTap:"))
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.txtEmail.text = "me@gmail.com"
        self.txtPassword.text = "123"
        self.btnLogIn.userInteractionEnabled = true
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
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func btnLoginTapped(sender: AnyObject) {

        self.txtEmail.resignFirstResponder()
        self.txtPassword.resignFirstResponder()
        
        let alertView = UIAlertController(title: kAppName, message: "", preferredStyle: UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertView.addAction(defaultAction)
        
        if txtEmail.text?.characters.count == 0{
            alertView.message = "Please enter your emailid."
            self.presentViewController(alertView, animated: true, completion: nil)
        }
        else if txtPassword.text?.characters.count == 0{
            alertView.message = "Please enter password."
            self.presentViewController(alertView, animated: true, completion: nil)
        }
        else{
            
            if !Validation.isValidEmail(txtEmail.text!){
                alertView.message = "Please enter valid emailid."
                self.presentViewController(alertView, animated: true, completion: nil)
            }
            else{
                btnLogIn.userInteractionEnabled = false
                self.loginUser(txtEmail.text!, password: txtPassword.text!, key: "dental!123")
            }
        }
    }
    
    func loginUser(emailID : String , password : String , key : String) -> Void{
        let dictSignUp : [String : AnyObject] = [kUserEmailID : emailID , kUserPassword : password , kUserAPIKey : key]
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        WebServies.makePost("login", parameter: dictSignUp) { (json, error) -> () in
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            if error == nil {
                if json.objectForKey("status") as! String == "401" {
                    let alertView = UIAlertController(title: kAppName, message: json.objectForKey("msg") as? String, preferredStyle: UIAlertControllerStyle.Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: { (action : UIAlertAction) -> Void in
                        self.btnLogIn.userInteractionEnabled = true
                    })
                    alertView.addAction(defaultAction)
                    self.presentViewController(alertView, animated: true, completion: nil)
                    
                }
                else {
                    let userDictionary = json.objectForKey("data")?.objectAtIndex(0)
                    NSUserDefaults.standardUserDefaults().setObject(userDictionary, forKey: "UserData")
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isLogin")
                    NSUserDefaults.standardUserDefaults().setObject((userDictionary!.objectForKey("accesstoken") as? String)!, forKey: "TOKEN")
                    NSUserDefaults.standardUserDefaults().setObject("NormalLogin", forKey: "Login")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                    self.performSegueWithIdentifier("segueJobList", sender: nil)
                }
            }
            else {
                let alertView = UIAlertController(title: kAppName, message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertView.addAction(defaultAction)
                self.presentViewController(alertView, animated: true, completion: nil)
                self.btnLogIn.userInteractionEnabled = true
            }
        }
    }
    
    @IBAction func btnFacebookLoginTapped(sender: AnyObject) {
        let manager = FBSDKLoginManager()
        manager.loginBehavior = FBSDKLoginBehavior.Browser
        
        manager.logInWithReadPermissions(["public_profile","email","user_birthday"], fromViewController: self) { (result : FBSDKLoginManagerLoginResult!, error : NSError!) -> Void in
            
            
            if (error != nil){
                print("Error")
            }
            else if result.isCancelled{
                print("Cancel")
            }
            else{
                let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"])
                graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                    
                    let fbID = result.objectForKey("id")!
                    let userImage = "http://graph.facebook.com/\(fbID)/picture?type=large"
                    
                    let facebookDictionary : [String : AnyObject] = [kUserAPIKey : "dental!123" , kUserEmailID : result.objectForKey("email")! , kUserSocialType : "facebook" , kUserName : result.objectForKey("name")! , kUserImage : userImage , "vExtension" : "" , "iTwitterID" : ""]
                    
                    self.loginWithFacebook(facebookDictionary)
                    
                })
            }
        }
        
    }
    
    @IBAction func btnTweeterLoginTapped(sender: AnyObject) {
        Twitter.sharedInstance().logInWithCompletion { (session, error) -> Void in
            if session != nil {
                let twitterDictionary : [String : AnyObject] = [kUserAPIKey : "dental!123" , kUserEmailID : "" , kUserSocialType : "twitter" , kUserName : session!.userName , kUserImage : "" , "vExtension" : "" , "iTwitterID" : session!.userID]
                
                self.loginWithTwitter(twitterDictionary)
            }
            else {
                print("Not Login")
            }
        }
        
    }
    
    func loginWithTwitter(dictTwitter : [String : AnyObject]) -> Void{
        
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        WebServies.makePost("login/SocialLogin", parameter: dictTwitter) { (json, error) -> () in
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            
            if error == nil {
                if json.objectForKey("status") as! String == "401"{
                    
                    let alertView = UIAlertController(title: kAppName, message: json.objectForKey("msg") as! String, preferredStyle: UIAlertControllerStyle.Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertView.addAction(defaultAction)
                    self.presentViewController(alertView, animated: true, completion: nil)
                    
                }else{
                    
                    let userDict = json.objectForKey("data")!.objectAtIndex(0)
                    NSUserDefaults.standardUserDefaults().setObject((userDict.objectForKey("accesstoken") as? String)!, forKey: "TOKEN")
                    NSUserDefaults.standardUserDefaults().setObject(userDict, forKey: "UserData")
                    NSUserDefaults.standardUserDefaults().setObject("login", forKey: "isLogin")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    NSUserDefaults.standardUserDefaults().setObject("FacebookLogin", forKey: "Login")
                    self.performSegueWithIdentifier("segueJobList", sender: nil)
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
    
    @IBAction func btnEmailLoginTapped(sender: AnyObject) {
        performSegueWithIdentifier("SegueSignUp", sender: nil)
    }
    
    
    
    func loginWithFacebook(dictFacebook : [String : AnyObject]) -> Void{
        
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        WebServies.makePost("login/SocialLogin", parameter: dictFacebook) { (json, error) -> () in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            if error == nil {
                if json.objectForKey("status") as! String == "401"{
                    
                    let alertView = UIAlertController(title: kAppName, message: json.objectForKey("msg") as? String, preferredStyle: UIAlertControllerStyle.Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertView.addAction(defaultAction)
                    self.presentViewController(alertView, animated: true, completion: nil)
                    self.btnLogIn.userInteractionEnabled = true
                    
                }else{
                    
                    let userDict = json.objectForKey("data")!.objectAtIndex(0)
                    NSUserDefaults.standardUserDefaults().setObject((userDict.objectForKey("accesstoken") as? String)!, forKey: "TOKEN")
                    NSUserDefaults.standardUserDefaults().setObject(userDict, forKey: "UserData")
                    NSUserDefaults.standardUserDefaults().setObject("login", forKey: "isLogin")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    NSUserDefaults.standardUserDefaults().setObject("FacebookLogin", forKey: "Login")
                    self.performSegueWithIdentifier("segueJobList", sender: nil)
                }
            }
            else {
                
            }
        }
    }
}
