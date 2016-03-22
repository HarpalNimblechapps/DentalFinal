//
//  PhotoListViewController.swift
//  DentalDsign
//
//  Created by Nimble Chapps on 29/02/16.
//  Copyright © 2016 Nimble Chapps. All rights reserved.
//

import UIKit
import PhotosUI


class PhotoListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnDone: UIButton!
    
    static var delegate : AllImageAsset!
    var arrSelectedImgIndex = [Int]()
    var arrAllImages = NSMutableArray()
    var imageArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnDone.enabled = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.defaultManager()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.synchronous = true
        
        
        manager.requestImageForAsset(asset, targetSize: CGSize(width: 120.0, height: 120.0), contentMode: .AspectFit, options: option, resultHandler: {(result, info)->Void in
            if result != nil {
                thumbnail = result!
            }
        })
        return thumbnail
    }
    
    @IBAction func btnDoneTapped(sender: AnyObject) {
        PhotoListViewController.delegate.getResponse(arrAllImages)
        
        let vcs = self.navigationController?.viewControllers
        for (_, vc) in (vcs?.enumerate())! {
            if vc.isKindOfClass(NewJobTableVC) {
                self.navigationController?.popToViewController(vc, animated: true)
                break
            }
        }
    }


    //MARK:- CollactionView DataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.imageArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AllPhotoCell", forIndexPath: indexPath) as! PhotoListCell
        cell.prifileImg.image = self.getAssetThumbnail(self.imageArray.objectAtIndex(indexPath.row) as! PHAsset)
        
        if arrSelectedImgIndex.contains(indexPath.row){
            cell.backgroundColor = UIColor.purpleColor()
        }
        else {
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if arrSelectedImgIndex.contains(indexPath.row){
            collectionView.cellForItemAtIndexPath(indexPath)?.backgroundColor = UIColor.whiteColor()
            let indx = arrSelectedImgIndex.indexOf(indexPath.row)
            arrSelectedImgIndex.removeAtIndex(indx!)
            arrAllImages.removeObjectAtIndex(indexPath.row)
            
        }
        else {
            collectionView.cellForItemAtIndexPath(indexPath)?.backgroundColor = UIColor.purpleColor()
            arrSelectedImgIndex.append(indexPath.row)
            arrAllImages.addObject(imageArray.objectAtIndex(indexPath.row))
        }
        if (arrSelectedImgIndex.count >= 1){
            btnDone.enabled = true
        }
        else {
            btnDone.enabled = false
        }
    }
    
    //MARK:- CollactionView Delegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        let size = CGSize(width: (self.view.frame.height - 90)/4, height: (self.view.frame.height - 90)/4)
        //let size =  CGSize(width: ((collectionView.frame.maxX - 20) / 3), height: ((collectionView.frame.maxX - 20)) / 3)
        return size
    }
    
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        self.collectionView.reloadData()
    }
   
}
