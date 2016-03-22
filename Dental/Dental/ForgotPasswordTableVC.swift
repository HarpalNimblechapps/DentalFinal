//
//  ForgotPasswordTableVC.swift
//  DentalDsign
//
//  Created by Nimble Chapps on 16/03/16.
//  Copyright © 2016 Nimble Chapps. All rights reserved.
//

import UIKit

class ForgotPasswordTableVC: UITableViewController {
    
    @IBOutlet weak var btnSend: UIButton! {
        didSet {
            btnSend.roundedButton()
        }
    }
    @IBOutlet weak var txtEmailId: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnCancelTapped(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func btnSendTapped(sender: AnyObject) {
        
        if !Validation.isValidEmail(txtEmailId.text!){
            
            let alertView = UIAlertController(title: kAppName, message: "Please enter valied email id.", preferredStyle: UIAlertControllerStyle.Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertView.addAction(defaultAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            
        }else{
            
            self.txtEmailId.resignFirstResponder()
            self.sendPasswordEmailID(txtEmailId.text!)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        txtEmailId.resignFirstResponder()
        return true
    }
    
    func sendPasswordEmailID(emailID : String){
        
        let parameter : [String : AnyObject] = [kUserEmailID : emailID , kUserAPIKey : "dental!123"]
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        WebServies.makePost("forgotpassword", parameter: parameter) { (json, error) -> () in
            if error == nil {
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                if json.objectForKey("status") as! String == "200" || json.objectForKey("status") as! String == "201"{
                    
                    let alert = UIAlertController(title: kAppName, message: json.objectForKey("msg") as? String , preferredStyle: UIAlertControllerStyle.Alert)
                    let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (Result : UIAlertAction) -> Void in
                        
                        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                    })
                    alert.addAction(action)
                    self.navigationController?.presentViewController(alert, animated: true, completion: nil)
                    
                }
                else {
                    let alertView = UIAlertController(title: kAppName, message : json.objectForKey("msg") as? String , preferredStyle: UIAlertControllerStyle.Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertView.addAction(defaultAction)
                    self.presentViewController(alertView, animated: true, completion: nil)
                }
            }
            else {
                let alertView = UIAlertController(title: kAppName, message : error.localizedDescription , preferredStyle: UIAlertControllerStyle.Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertView.addAction(defaultAction)
                self.presentViewController(alertView, animated: true, completion: nil)
            }
        }
    }
}
