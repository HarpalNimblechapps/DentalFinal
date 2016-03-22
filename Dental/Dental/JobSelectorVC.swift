//
//  JobSelectorVC.swift
//  DentalDsign
//
//  Created by Nimble Chapps on 26/02/16.
//  Copyright © 2016 Nimble Chapps. All rights reserved.
//

import UIKit

class JobSelectorVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, KLHorizontalSelectDelegate {

    let upperToothNO : [Int] = [11,12,13,14,15,16,17,18,21,22,23,24,25,26,27,28]
    let lowerToothNo : [Int] = [31,32,33,34,35,36,37,38,41,42,43,44,45,46,47,48]
    let teeths = ["11","12","13","14","15","16","17","18","21","22","23","24","25","26","27","28","31","32","33","34","35","36","37","38","41","42","43","44","45","46","47","48"]
    
    let teethsNames = ["Right Third Molar","Right Second Molar","Right First Molar","Right Second Bicuspid","Right First Bicuspid","Right Canine","Right Lateral Incisor","Right Central Incisor","Left Central Incisor","Left Lateral Incisor","Left Canine","Left First Bicuspid","Left Second Bicuspid","Left First Molar","Left Second Molar","Left Third Molar","Left  Central Incisor","Left Lateral Incisor","Left Canine","Left First Bicuspid","Left Second Bicuspid","Left First Molar","Left Second Molar","Left Third Molar","Right Central Incisor","Right Lateral Incisor","Right Canine","Right First Bicuspid","Right Second Bicuspid","Right First Molar","Right Second Molar","Right Third Molar"]
    
    
    var index = "0"
    var teethData = NSMutableArray()
    var noOfJob = 0
    var teethArrIndex = 0
    
    @IBOutlet weak var btnEditWidth_Constrain: NSLayoutConstraint!
    @IBOutlet weak var upperView: UIView! {
        didSet {
            upperView.layer.cornerRadius = 5.0
        }
    }
    
    @IBOutlet weak var lblJobCount: UILabel!
    @IBOutlet weak var lowerView: UIView!
        {
        didSet {
            lowerView.layer.cornerRadius = 5.0
        }
    }
    @IBOutlet weak var lowerCollactionView: UICollectionView! {
        didSet {
            lowerCollactionView.layer.cornerRadius = 5.0
        }
    }
    
    @IBOutlet weak var btnEdit: UIButton! {
        didSet{
            btnEdit.layer.cornerRadius = 3.0
        }
    }
    
    @IBOutlet weak var btnNewJob: UIButton!{
        didSet{
            btnNewJob.layer.cornerRadius = 3.0
        }
    }
    @IBOutlet weak var imghorozontal: UIImageView! {
        didSet{
            imghorozontal.layer.cornerRadius = self.imghorozontal.frame.height/2
            imghorozontal.backgroundColor = UIColor(colorLiteralRed: 24/255, green: 222/255, blue: 208/255, alpha: 0.5)
        }
    }
    @IBOutlet var horizontalSelector : KLHorizontalSelect!
    
    var viewdData = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lowerCollactionView.delegate = self
        self.lowerCollactionView.dataSource = self
        self.teethArrIndex = teethIndex(teeths.indexOf(index)!+1)-1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.horizontalSelector = KLHorizontalSelect(frame: CGRectMake(0, 3, self.upperView.frame.width, 60))
            self.horizontalSelector.currentIndex = NSIndexPath(forRow: self.teeths.indexOf(self.index)!, inSection: 0)
            self.horizontalSelector.delegate = self
            self.horizontalSelector.tableData = self.teeths
            self.horizontalSelector.arrow.show(false)
            self.upperView.addSubview(self.horizontalSelector)
            self.upperView.bringSubviewToFront(self.imghorozontal)
        }
        
    }
    
    @IBAction func btnEditTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("EditJobSegue", sender: nil)
    }
    
    @IBAction func btnNewJobTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("NewJobSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "NewJobSegue") {
            let destination = segue.destinationViewController as! NewJobTableVC
            destination.teethNo = horizontalSelector.currentIndex.row+1
        }
        else if (segue.identifier == "EditJobSegue") {
            let destination = segue.destinationViewController as! NewJobTableVC
            destination.teethNo = Int((self.viewdData.objectForKey("iToothNo") as? String)!)!
            destination.isEditable = true
            destination.editableData = viewdData
        }else if(segue.identifier == "ViewJobSugue") {
            let destination = segue.destinationViewController as! ViewJobTableVC
            destination.selectedJob = sender as! NSDictionary
            destination.teethImage = "\(self.teeths.indexOf(index)!+1)"
            destination.teethName = teethsNames[teeths.indexOf(index)!]
        }
    }
    
    //MARK:- CollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         noOfJob = teethData[teethIndex(teeths.indexOf(index)!+1)-1].count
        if(noOfJob == 0){
            return 1
        }
        return noOfJob
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell : JobSelectorCell = collectionView.dequeueReusableCellWithReuseIdentifier("JobSelectorCell", forIndexPath: indexPath) as! JobSelectorCell
        
        cell.teethImage.image = UIImage(named : "\(self.teeths.indexOf(index)!+1)")
        cell.lblTeethName.text = teethsNames[teeths.indexOf(index)!]
        
        if teethData[teethIndex(teeths.indexOf(index)!+1)-1].count > 0 {
            lblJobCount.text = "\(indexPath.row + 1) of \(noOfJob)"
            cell.viewNoJob.hidden = true
           
            viewdData = NSDictionary()
            viewdData = teethData.objectAtIndex(teethArrIndex).objectAtIndex(indexPath.row) as! NSDictionary
            
            cell.lblDate.text = newDate(self.teethData.objectAtIndex(teethArrIndex).objectAtIndex(indexPath.row).objectForKey("dJobDate") as! String)
            
            cell.lblDocName.text = self.teethData.objectAtIndex(teethArrIndex).objectAtIndex(indexPath.row).objectForKey("vPracticianName") as? String
            
            cell.lblJobType.text = self.teethData.objectAtIndex(teethArrIndex).objectAtIndex(indexPath.row).objectForKey("vJobTypeName") as? String
            cell.txtDescription.text = self.teethData.objectAtIndex(teethArrIndex).objectAtIndex(indexPath.row).objectForKey("tDescription") as? String
            self.btnEditWidth_Constrain.constant = 46
        }
        else {
            lblJobCount.text = "1 of 1"
            cell.viewNoJob.hidden = false
            self.btnEditWidth_Constrain.constant = 0
        }
        
        return cell
    }
    
    func getTeethInfo(no : Int) -> Int{
        return teeths.indexOf("\(no)")!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell : JobSelectorCell = self.lowerCollactionView.cellForItemAtIndexPath(indexPath) as! JobSelectorCell
        
        if(cell.viewNoJob.hidden == true) {
            self.performSegueWithIdentifier("ViewJobSugue", sender: self.teethData.objectAtIndex(teethArrIndex).objectAtIndex(indexPath.row))
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        let size =  CGSize(width: lowerCollactionView.frame.width, height: collectionView.frame.height)
        return size
    }
    
    func horizontalSelect(horizontalSelect: AnyObject!, didSelectCell cell: KLHorizontalSelectCell!) {
        self.index = teeths[horizontalSelector.currentIndex.row]
        self.teethArrIndex = teethIndex(teeths.indexOf(index)!+1)-1
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.lowerCollactionView.reloadData()
        }
        
    }
    
    
}
