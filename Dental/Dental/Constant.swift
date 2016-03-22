//
//  Constant.swift
//  DentalDsign
//
//  Created by Nimble Chapps on 09/03/16.
//  Copyright © 2016 Nimble Chapps. All rights reserved.
//

import UIKit

class Constant: NSObject {

}
// SignUp
let kAppName = "DentaLog"

let  kUserAPIKey         =  "X-API-KEY"
let  kUserEmailID        =  "vEmail"
let  kUserPassword       =  "vPassword"

let  kUserOldPassword       =  "vOldPassword"
let  kUserNewPassword       =  "vNewPassword"



// Login

let  kUserSocialType         =  "eSocialMediaType"
let  kUserName               =  "vName"
let  kUserImage              =  "vImage"
let  kUserID                 =  "iUserID"
let  kUserToken              =  "accesstoken"

// Response JOB

let  kJobParcticianName            =  "vPracticianName"
let  kJobParcticianAddress         =  "tPracticianAddress"
let  kJobParcticianContact         =  "vPractcianContact"
let  kJobParcticianEmail           =  "vPracticianEmail"

let  kJobDate                      =  "dJobDate"
let  kJobGallery                   =  "gallery"
let  kJobImageTitle                =  "vTitle"
let  kJobExtenstin                 =  "vExtension"
let  kJobDuration                  =  "iDuration"
let  kJobID                        =  "iJobID"
let  kJobTypeID                    =  "iJobTypeID"
let  kJobTypeName                  =  "vJobTypeName"

let  kJobLinkedJob                 =  "vLinkedJob"
let  kJobOldLinked                 =  "voldLink"
let  kJobCurrentLinkedJob          =  "vCurrentLinkedJob"
let  kJobMaterial                  =  "vMaterial"
let  kJobTitle                     =  "vJobTitle"
let  kJobDescription               =  "tDescription"
let  kToothNo                      =  "iToothNo"
let  kJobOldImage                  =  "vOldImage"

let  kBaseImagePath   = "http://projects.developmentshowcase.com/dentallog/ws/"

func teethIndex(teeth : Int) -> Int{
    
    switch(teeth){
        
    case 1:
        
        return 8
        
        
    case 2:
        
        return 7
        
        
    case 3:
        
        return 6
        
    case 4:
        
        return 5
        
        
    case 5:
        
        return 4
        
        
        
    case 6:
        
        return 3
        
        
        
    case 7:
        
        return 2
        
        
    case 8:
        
        return 1
        
        
    case 9:
        
        return 9
        
        
    case 10:
        
        return 10
        
        
        
    case 11:
        
        return 11
        
        
        
    case 12:
        
        return 12
        
        
        
    case 13:
        
        return 13
        
    case 14:
        
        return 14
        
    case 15:
        
        return 15
        
    case 16:
        
        return 16
        
    case 17:
        
        return 24
        
    case 18:
        
        return 23
        
    case 19:
        
        return 22
        
    case 20:
        
        return 21
        
    case 21:
        
        return 20
        
    case 22:
        
        return 19
        
    case 23:
        
        return 18
        
    case 24:
        
        return 17
        
    case 25:
        
        return 25
        
        
        
    case 26:
        
        return 26
        
        
        
    case 27:
        
        return 27
        
        
    case 28:
        
        return 28
        
        
    case 29:
        
        return 29
        
        
    case 30:
        
        return 30
        
        
    case 31:
        
        return 31
        
        
    case 32:
        
        return 32
        
        
    default :
        return 0
        
    }
}
func newDate(date : String)-> String{
    let dateFormate = NSDateFormatter()
    dateFormate.dateFormat = "yyyy-MM-dd"
    let dateN = dateFormate.dateFromString(date)
    
    let dateFormate1 = NSDateFormatter()
    dateFormate1.dateFormat = "MMM, yyyy"
    let dateN1 = dateFormate1.stringFromDate(dateN!)
    
    var days = (date as NSString).substringFromIndex(date.characters.count-2)
    
    switch (days) {
    case "1":
        days.appendContentsOf("st")
    case "2":
        days.appendContentsOf("st")
    case "3":
        days.appendContentsOf("rd")
    default:
        days.appendContentsOf("th")
    }
    return days + " " + dateN1
}



