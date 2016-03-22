//
//  Validation.swift
//  DentalDsign
//
//  Created by Nimble Chapps on 09/03/16.
//  Copyright © 2016 Nimble Chapps. All rights reserved.
//

import UIKit

class Validation: NSObject {

    // Email Validation
    
    class func isValidEmail(testStr:String) -> Bool {
        
        //println("validate emilId: \(testStr)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluateWithObject(testStr)
        
        return result
        
    }
    
    // PhoneNumber Validation
    
    class func isValidPhone(value: String) -> Bool {
        
        let PHONE_REGEX = "^\\+\\d{3}-\\d{2}-\\d{7}$"
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        
        let result =  phoneTest.evaluateWithObject(value)
        
        return result
        
    }
    
    // Pincode Validation with 4 digit
    
    class func isValidPincode(value: String) -> Bool {
        
        if value.characters.count >= 4
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    
    // Password validation
    
    class func isPasswordSame(password: String , confirmPassword : String) -> Bool {
        
        if password == confirmPassword
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    
    // Password lenth Validation
    
    class func isPwdLenth(password: String , confirmPassword : String) -> Bool {
        
        if password.characters.count >= 7 && confirmPassword.characters.count >= 7
        {
            return true
        }
        else
        {
            return false
        }
        
    }
}
