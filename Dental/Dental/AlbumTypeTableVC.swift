//
//  AlbumTypeTableVC.swift
//  DentalDsign
//
//  Created by Nimble Chapps on 29/02/16.
//  Copyright © 2016 Nimble Chapps. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

@objc protocol AllImageAsset {
    func getResponse(responseObject : NSMutableArray)
}

class AlbumTypeTableVC: UITableViewController {

    var sectionFetchResults = NSMutableArray()
    var sectionLocalizedTitles = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let allPhotosoption = PHFetchOptions()
        allPhotosoption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let allPhotos = PHAsset.fetchAssetsWithMediaType(.Image, options: allPhotosoption)
        
        let allPhotosoptionOnly = PHFetchOptions()
        
        let smartAlbums = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.SmartAlbum, subtype: PHAssetCollectionSubtype.AlbumRegular, options: allPhotosoptionOnly)
        
        
        self.sectionFetchResults = [allPhotos , smartAlbums ]
        self.sectionLocalizedTitles = ["" , NSLocalizedString("Smart Albums", comment: "")]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sectionFetchResults.count;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        
        if (section == 0) {
            numberOfRows = 1;
        } else {
            
            let fetchResult = self.sectionFetchResults[section]
            numberOfRows = fetchResult.count;
        }
        return numberOfRows;
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.section == 0{
            
            cell = tableView.dequeueReusableCellWithIdentifier("AlbumTypeCell", forIndexPath: indexPath)
            cell.textLabel?.text = NSLocalizedString("All Photos", comment: "")
            
        }else{
            
            let fetchResult = self.sectionFetchResults[indexPath.section]
            let collection  = fetchResult[indexPath.row]
            cell = tableView.dequeueReusableCellWithIdentifier("AlbumTypeCell", forIndexPath: indexPath)
            cell.textLabel?.text = collection.localizedTitle
            
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionLocalizedTitles[section] as? String
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if indexPath.section == 0{
            
            let photos = NSMutableArray()
            self.sectionFetchResults.objectAtIndex(indexPath.section).enumerateObjectsUsingBlock { (object, _, _) -> Void in
                if let asset = object as? PHAsset {
                    
                    photos.addObject(asset)
                }
            }
            self.performSegueWithIdentifier("PhotoListSegue", sender: photos)
        }else{
            
            let photos = NSMutableArray()
            let optionImage = PHFetchOptions()
            let result = PHAsset.fetchAssetsInAssetCollection(self.sectionFetchResults.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as! PHAssetCollection, options:optionImage)
            result.enumerateObjectsUsingBlock({ (object, _, _) -> Void in
                if let asset = object as? PHAsset {
                    photos.addObject(asset)
                }
            })
            self.performSegueWithIdentifier("PhotoListSegue", sender: photos)
        }
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destionationV = segue.destinationViewController as! PhotoListViewController
        destionationV.imageArray = NSMutableArray(array: sender! as! [AnyObject])
        
    }
    
}
