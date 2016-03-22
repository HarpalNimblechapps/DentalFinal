//
//  SignUPTableVC.swift
//  DentalDsign
//
//  Created by Nimble Chapps on 28/01/16.
//  Copyright © 2016 Nimble Chapps. All rights reserved.
//

import UIKit

class SignUPTableVC: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSignup: UIButton! {
        didSet {
            btnSignup.roundedButton()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    @IBAction func btnSignupTapped(sender: AnyObject) {
        
        if txtEmail.text?.characters.count == 0{
            let alertView = UIAlertController(title: kAppName, message: "Please enter your Email Id.", preferredStyle: UIAlertControllerStyle.Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertView.addAction(defaultAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            
        }
        else if txtPassword.text?.characters.count == 0{
            
            let alertView = UIAlertController(title: kAppName, message: "Please enter Password.", preferredStyle: UIAlertControllerStyle.Alert)
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
            
            if !Validation.isValidEmail(txtEmail.text!){
                
                let alertView = UIAlertController(title: kAppName, message: "Please enter a valid Email Id.", preferredStyle: UIAlertControllerStyle.Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertView.addAction(defaultAction)
                self.presentViewController(alertView, animated: true, completion: nil)
            }
            else if !Validation.isPwdLenth(txtPassword.text!, confirmPassword: txtConfirmPassword.text!){
                let alertView = UIAlertController(title: kAppName, message: "Password length must be at least 6 characters.", preferredStyle: UIAlertControllerStyle.Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertView.addAction(defaultAction)
                self.presentViewController(alertView, animated: true, completion: nil)
                
            }
            else if !Validation.isPasswordSame(txtPassword.text!, confirmPassword: txtConfirmPassword.text!){
                let alertView = UIAlertController(title: kAppName, message: "Passwords do not match.", preferredStyle: UIAlertControllerStyle.Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertView.addAction(defaultAction)
                self.presentViewController(alertView, animated: true, completion: nil)
                
            }
            else{
                self.signUpUser(txtEmail.text!, password: txtPassword.text!)
            }
        }
    }
    
    func signUpUser(emailID : String , password : String) -> Void{
        
        self.txtPassword.resignFirstResponder()
        self.txtConfirmPassword.resignFirstResponder()
        self.txtEmail.resignFirstResponder()
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let dictSignUp : [String : AnyObject] = [kUserEmailID : emailID , kUserPassword : password , kUserAPIKey : "dental!123"]
        WebServies.makePost("", parameter: dictSignUp) { (json, error) -> () in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            
            if error == nil {
                let alert = UIAlertController(title: kAppName, message: json.objectForKey("msg") as? String, preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (Result : UIAlertAction) -> Void in
                    
                    if  json.objectForKey("status") as! String == "200" || json.objectForKey("status") as! String == "201"{
                        self.navigationController?.popViewControllerAnimated(true)
                    }else{
                        print("Nothing")
                    }
                    
                })
                alert.addAction(action)
                self.navigationController?.presentViewController(alert, animated: true, completion: nil)
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
