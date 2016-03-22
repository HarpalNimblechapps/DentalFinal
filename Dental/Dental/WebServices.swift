//
//  WebServices.swift
//  DentalDsign
//
//  Created by Nimble Chapps on 08/03/16.
//  Copyright © 2016 Nimble Chapps. All rights reserved.
//

import Foundation

var kBasePath = "http://projects.developmentshowcase.com/dentallog/ws/"
var manager : AFHTTPSessionManager!

typealias CompletionBlock = ( json : AnyObject! , error : NSError!) -> ()

class WebServies: NSObject {
    
    
    override class func initialize() {
        manager = AFHTTPSessionManager(baseURL: NSURL(string: kBasePath))
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.MutableLeaves)
        
        //        AFNetworkReachabilityManager.sharedManager().startMonitoring()
        //        AFNetworkReachabilityManager.sharedManager().setReachabilityStatusChangeBlock{(status: AFNetworkReachabilityStatus?)          in
        //            switch status!.hashValue{
        //            case AFNetworkReachabilityStatus.NotReachable.hashValue:
        //                print("Not reachable")
        //            case AFNetworkReachabilityStatus.ReachableViaWiFi.hashValue , AFNetworkReachabilityStatus.ReachableViaWWAN.hashValue :
        //                print("Reachable")
        //            default:
        //                print("Unknown status")
        //            }
        //        }
    }
    
    class func makeGet(place : String, parameter : NSDictionary, block : CompletionBlock!) {
        
        manager.GET(place, parameters: parameter,
            success: { (dataTask : NSURLSessionDataTask!, response : AnyObject!) -> Void in
                block(json : response, error : nil)
            }) { (dataTask : NSURLSessionDataTask!, error : NSError!) -> Void in
                block(json: nil, error : error)
        }
    }
    
    
    class func makePut(place : String, parameter : NSDictionary, block : CompletionBlock!) {
        
        manager.PUT1(place, parameters: parameter, constructingBodyWithBlock: { (fromData : AFMultipartFormData!) -> Void in
            
            }, success: { (dataTask : NSURLSessionDataTask!, response : AnyObject!) -> Void in
                block(json : response, error : nil)
                
            }) { (dataTask : NSURLSessionDataTask!, error : NSError!) -> Void in
                block(json: nil, error : error)
        }
    }
    
    class func makePost(place : String, parameter : NSDictionary, block : CompletionBlock!) {
        
        manager.POST(place, parameters: parameter,
            success: { (dataTask : NSURLSessionDataTask!, response : AnyObject!) -> Void in
                block(json : response, error : nil)
                
            }) { (dataTask : NSURLSessionDataTask!, error : NSError!) -> Void in
                block(json: nil, error : error)
        }
    }
    
    class func makeDelete(relativePath : NSString, parameters : NSDictionary, block : CompletionBlock!){
        
        manager.DELETE1(relativePath as String, parameters: parameters, constructingBodyWithBlock: { (formData : AFMultipartFormData!) -> Void in
            }, success: { (dataTask : NSURLSessionDataTask! , response : AnyObject!) -> Void in
                block(json: response, error : nil)
            }) { (datatask : NSURLSessionDataTask!, error : NSError!) -> Void in
                block(json: nil, error : error)
        }
    }
    
    class func uploadEditImage(file: NSMutableArray, var url: String, name: String, fileName: String, mimeType: String, parameters: NSDictionary, block : CompletionBlock!) {
        
        url = kBasePath+url
        
        manager.POST(url, parameters: parameters, constructingBodyWithBlock: { (data) in
            
            file.enumerateObjectsUsingBlock({ (fileData : AnyObject, idx : Int, Stop : UnsafeMutablePointer<ObjCBool>) -> Void in
                
                data.appendPartWithFileData(fileData as! NSData, name: "vImage"+"\(idx)", fileName: "\(idx)"+".jpg", mimeType: mimeType as String)
            })
            
            }, success: { (operation, responseObject) in
                
                block(json: responseObject, error: nil)
            }, failure: { (operation, error) in
                block(json: nil, error: error)
        })
    }
    
    class func uploadFile(file: NSData, var url: String, name: String, fileName: String, mimeType: String, parameters: NSDictionary, block : CompletionBlock!) {
        
        url = kBasePath+url
        
        manager.POST(url, parameters: parameters, constructingBodyWithBlock: { (data) in
            
            data.appendPartWithFileData(file, name: name as String, fileName: fileName as String, mimeType: mimeType as String)
            
            }, success: { (operation, responseObject) in
                
                block(json: responseObject, error: nil)
            }, failure: { (operation, error) in
                block(json: nil, error: error)
        })
    }
}

