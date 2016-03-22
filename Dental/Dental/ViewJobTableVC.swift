//
//  ViewJobTableVC.swift
//  DentalDsign
//
//  Created by Nimble Chapps on 02/03/16.
//  Copyright © 2016 Nimble Chapps. All rights reserved.
//

import UIKit
import MessageUI

class ViewJobTableVC: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var imgTeeth: UIImageView! {
        didSet {
            imgTeeth.image = UIImage(named: teethImage)
        }
    }
    @IBOutlet weak var lblTeethName: UILabel! {
        didSet {
            lblTeethName.text = teethName
        }
    }
    @IBOutlet weak var lblJobTitle: UILabel! {
        didSet {
            lblJobTitle.text = selectedJob.objectForKey("vJobTitle") as? String
        }
    }
    @IBOutlet weak var lblJobType: UILabel! {
        didSet {
            lblJobType.text = selectedJob.objectForKey("vJobTypeName") as? String
        }
    }
    @IBOutlet weak var lblPracticianName: UILabel! {
        didSet {
            lblPracticianName.text = selectedJob.objectForKey("vPracticianName") as? String
        }
    }
    @IBOutlet weak var lblPracticianEmail: UILabel! {
        didSet {
            lblPracticianEmail.text =  selectedJob.objectForKey("vPracticianEmail") as? String
        }
    }
    @IBOutlet weak var lblPracticianContactNo: UILabel! {
        didSet {
            lblPracticianContactNo.text = selectedJob.objectForKey("vPractcianContact") as? String
        }
    }
    @IBOutlet weak var lblJobDate: UILabel! {
        didSet {
            lblJobDate.text = newDate((selectedJob.objectForKey("dJobDate") as? String)!)
        }
    }
    @IBOutlet weak var lblJobDuration: UILabel! {
        didSet {
            self.lblJobDuration.text = self.convertHoursAndMinutes((selectedJob.objectForKey(kJobDuration)! as? String)!)
        }
    }
    @IBOutlet weak var lblJobMaterial: UILabel! {
        didSet {
            lblJobMaterial.text = selectedJob.objectForKey("vMaterial") as? String
        }
    }
    @IBOutlet weak var lblJobNote: UILabel! {
        didSet {
            lblJobNote.text = selectedJob.objectForKey("tDescription") as? String
        }
    }
    
    
    @IBOutlet weak var image11: UIImageView!
    @IBOutlet weak var image12: UIImageView!
    @IBOutlet weak var image13: UIImageView!
    @IBOutlet weak var image14: UIImageView!
    @IBOutlet weak var image15: UIImageView!
    @IBOutlet weak var image16: UIImageView!
    @IBOutlet weak var image17: UIImageView!
    @IBOutlet weak var image18: UIImageView!
    
    @IBOutlet weak var image21: UIImageView!
    @IBOutlet weak var image22: UIImageView!
    @IBOutlet weak var image23: UIImageView!
    @IBOutlet weak var image24: UIImageView!
    @IBOutlet weak var image25: UIImageView!
    @IBOutlet weak var image26: UIImageView!
    @IBOutlet weak var image27: UIImageView!
    @IBOutlet weak var image28: UIImageView!
    
    @IBOutlet weak var image31: UIImageView!
    @IBOutlet weak var image32: UIImageView!
    @IBOutlet weak var image33: UIImageView!
    @IBOutlet weak var image34: UIImageView!
    @IBOutlet weak var image35: UIImageView!
    @IBOutlet weak var image36: UIImageView!
    @IBOutlet weak var image37: UIImageView!
    @IBOutlet weak var image38: UIImageView!
    
    @IBOutlet weak var image41: UIImageView!
    @IBOutlet weak var image42: UIImageView!
    @IBOutlet weak var image43: UIImageView!
    @IBOutlet weak var image44: UIImageView!
    @IBOutlet weak var image45: UIImageView!
    @IBOutlet weak var image46: UIImageView!
    @IBOutlet weak var image47: UIImageView!
    @IBOutlet weak var image48: UIImageView!
    
    
    
    
    let arrayImagesURLs = NSMutableArray()
    let arrayScrolledImagesURLs = NSMutableArray()

    var zoomScrollView : UIScrollView!
    var tapScrollGesture : UITapGestureRecognizer!
    var zoomedImageView : UIImageView!
    
    @IBOutlet weak var collactionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageTeeth: UIImageView!
    
    
    var isfull = false
    var teethImage = ""
    var teethName = ""
    var selectedJob = NSDictionary()
    var isZoomed = false
    var cellHeight : CGFloat = 140.0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        
        let toothNumber = Int((selectedJob.objectForKey("iToothNo") as? String)!)
        self.redTeethMark(toothNumber!)
        
        if selectedJob.objectForKey("vLinkedJob") as? String == "" {
            
            print("Nothing")
            
        }else{
            let components = (selectedJob.objectForKey("vLinkedJob") as? String)?.componentsSeparatedByString(",")
            for linkNum in components!{
                
                let number = Int(linkNum)
                self.yellowTeethMark(number!)
            }
        }
        let gallery = selectedJob.objectForKey("gallery") as? NSMutableArray ?? NSMutableArray()
        
        if gallery.count > 0{
            
            for dictImage in gallery{
                let imageName = dictImage.objectForKey(kUserImage) as! String+"_50"+"_50"
                let imageExtenstion = dictImage.objectForKey("vExtension") as! String
                let imageP = kBaseImagePath+imageName+imageExtenstion
                let urls = NSURL(string: imageP)
                arrayImagesURLs.addObject(urls!)
                
                // Scroll Images
                
                let imageNameScroll = dictImage.objectForKey(kUserImage) as! String+"_400"+"_400"
                let imageExtenstionScroll = dictImage.objectForKey("vExtension") as! String
                let imagePScroll = kBaseImagePath+imageNameScroll+imageExtenstionScroll
                let urlsScroll = NSURL(string: imagePScroll)
                arrayScrolledImagesURLs.addObject(urlsScroll!)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 8 {
            if (isZoomed) {
                isZoomed = false
                tableView.beginUpdates()
                cellHeight = 140.0
                tableView.endUpdates()
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height)
                    self.imageTeeth.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
                    self.imageTeeth.contentMode = UIViewContentMode.ScaleAspectFit
                    self.scrollView.scrollEnabled = false
                })
            }
            else {
                isZoomed = true
                tableView.beginUpdates()
                cellHeight = 240.0
                tableView.endUpdates()
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.scrollView.contentSize = CGSizeMake(1152.0, self.scrollView.frame.size.height)
                    self.imageTeeth.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
                    self.callingFrame()
                    self.imageTeeth.contentMode = UIViewContentMode.ScaleAspectFit
                    self.scrollView.scrollEnabled     = true
                })
            }
        }
    }
    
    
    func callingFrame() {
        self.image11.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image12.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image13.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image14.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image15.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image16.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image17.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image18.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        
        self.image21.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image22.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image23.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image24.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image25.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image26.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image27.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image28.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        
        self.image31.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image32.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image33.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image34.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image35.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image36.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image37.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image38.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        
        self.image41.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image42.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image43.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image44.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image45.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image46.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image47.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
        self.image48.frame = CGRectMake(0, 0, 1152,self.scrollView.frame.size.height)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0 :
            return 142
        case 4 :
            if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad{
                
                if isfull == false{
                    return 90
                }else{
                    return 250
                }
                
            }else{
                if isfull == false{
                    return 65
                }else{
                    return 140
                }
            }
        case 8 :
            return cellHeight
        case 9 :
            return UITableViewAutomaticDimension
        case 10 :
            return 117
        default :
            return tableView.estimatedRowHeight
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImagesURLs.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellJobImages", forIndexPath: indexPath) as! CellViewJobImages
        cell.imgProfile.setImageWithURL(self.arrayImagesURLs.objectAtIndex(indexPath.row) as! NSURL, placeholderImage: nil)
        cell.imgProfile.layer.cornerRadius = 5.0
        cell.imgProfile.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.zoomScroll(indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        return CGSizeMake(50, 50)
    }
    
    func zoomScroll(indexPath:NSIndexPath)->Void{
        
        self.tableView.scrollEnabled = false
        
        
        self.zoomScrollView = UIScrollView(frame: self.view.bounds)
        self.zoomScrollView.backgroundColor = UIColor(white: 0.5, alpha: 0.8)
        
        self.tapScrollGesture = UITapGestureRecognizer(target: self, action: "imageViewWasTapped")
        self.zoomScrollView.addGestureRecognizer(self.tapScrollGesture)
        
        
        let countOfUrl : CGFloat = CGFloat(arrayScrolledImagesURLs.count)
        
        for (var i : CGFloat = 0; i < countOfUrl ; i++){
            self.zoomedImageView = UIImageView()
            self.zoomScrollView.pagingEnabled = true
            self.zoomedImageView = UIImageView(frame: CGRectMake(self.zoomScrollView.frame.size.width * i,0, self.view.frame.size.width, self.view.frame.size.height))
            self.zoomedImageView.contentMode = UIViewContentMode.ScaleAspectFit
            self.zoomedImageView.userInteractionEnabled = true
            let fileUrl = arrayScrolledImagesURLs.objectAtIndex(Int(i)) as! NSURL
            self.zoomedImageView.setImageWithURL(fileUrl, placeholderImage:  nil)
            self.zoomScrollView.addSubview(self.zoomedImageView)
            
        }
        self.view.addSubview(self.zoomScrollView)
        self.zoomScrollView.bringSubviewToFront(self.view)
        self.zoomScrollView.contentSize = CGSizeMake(zoomScrollView.frame.size.width * countOfUrl,zoomedImageView.frame.size.height)
        
        self.zoomScrollView.setContentOffset(CGPointMake(self.zoomScrollView.frame.size.width * CGFloat(indexPath.row), 0), animated: false)
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            self.zoomScrollView.layoutIfNeeded()
            self.zoomScrollView.frame = self.view.bounds
        })
    }
    
    func imageViewWasTapped()->Void
    {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            }) { (finish : Bool) -> Void in
                self.zoomScrollView.removeFromSuperview()
                self.tableView.scrollEnabled = true
        }
    }
    
    @IBAction func btnMoreTapped(sender: AnyObject) {
        tableView.beginUpdates()
        if isfull == false{
            self.isfull = true
            
        }else{
            self.isfull = false
            
        }
        tableView.endUpdates()
    }
    
    @IBAction func btnEditeTapped(sender: AnyObject) {
        let ActionSheet = UIAlertController(title: nil, message: "DentaLog", preferredStyle: .ActionSheet)
        
        let edit = UIAlertAction(title: "Edit", style: .Default) { (alert : UIAlertAction) -> Void in
            let mainStory = UIStoryboard(name: "Main", bundle: nil)
            let Editable  = mainStory.instantiateViewControllerWithIdentifier("NewJobTableVC") as! NewJobTableVC
            Editable.isEditable = true
            Editable.editableData = self.selectedJob
            Editable.teethNo = Int((self.selectedJob.objectForKey("iToothNo") as? String)!)!
            self.navigationController?.pushViewController(Editable, animated: true)
        }
        
        //For Delete
        let delete = UIAlertAction(title: "Delete", style: .Default, handler: {
            (alert: UIAlertAction) -> Void in
            
            self.deleteJob(self.selectedJob)
        })
        
        //For Cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction) -> Void in
            
        })
        
        let share = UIAlertAction(title: "Share", style: .Default, handler: {
            (alert: UIAlertAction) -> Void in
            let mailComposeViewController = self.configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        })
        
        ActionSheet.addAction(edit)
        ActionSheet.addAction(share)
        ActionSheet.addAction(delete)
        
        ActionSheet.addAction(cancelAction)
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad
        {
            let presentC : UIPopoverPresentationController  = ActionSheet.popoverPresentationController!
            presentC.sourceView = self.tableView
            presentC.sourceRect = CGRectMake(self.view.frame.size.width-300, -500, 300, 500)
            presentC.permittedArrowDirections = UIPopoverArrowDirection.Up
            
            self.presentViewController(ActionSheet, animated: true, completion: nil)
        }
        else
        {
            self.presentViewController(ActionSheet, animated: true, completion: nil)
        }
        
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let num = Int((self.selectedJob.objectForKey("iToothNo")! as! String))!
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        var ImageUrls : String = ""
        var JobSummary : String = "<p><strong>Job Summary : </strong></p>"
        if let jobtitle = self.selectedJob["vJobTitle"]{
            JobSummary = "<p><strong>Job Summary :</strong> \(jobtitle)</p>"
        }
        
        var JobType : String = "<p><strong>Job Type : </strong></p>"
        if let jobtype = self.selectedJob["vJobTypeName"]{
            JobType = "<p><strong>Job Type :</strong> \(jobtype)</p>"
        }
        
        var Practitioner : String = "<p><strong>Practitioner : </strong></p>"
        if let practitioner = self.selectedJob["vPracticianName"]{
            Practitioner = "<p><strong>Practitioner :</strong> \(practitioner)</p>"
        }
        
        var PractitionerEmail : String = "<li>email </li>"
        if let practitionermail = self.selectedJob["vPracticianEmail"]{
            PractitionerEmail = "<p><strong>email :</strong> \(practitionermail)</p>"
        }
        
        var PractitionerPhone : String = "<li>phone </li>"
        if let practitionerphone = self.selectedJob["vPractcianContact"]{
            PractitionerPhone = "<p><strong>phone :</strong> \(practitionerphone)</p>"
        }
        
        var MaterialUsed : String = "<p><strong>Material used : </strong> </p>"
        if let material = self.selectedJob["vMaterial"]{
            MaterialUsed = "<p><strong>Material used : </strong> \(material)</p>"
        }
        
        var LinkedTeeth : String = "<p><strong>Linked teeth : </strong> </p>"
        if let linked = self.selectedJob["vLinkedJob"]{
            LinkedTeeth = "<p><strong>Linked teeth : </strong> \(linked)</p>"
        }
        
        var JobNotes : String = " "
        if let jobnotes = self.selectedJob["tDescription"]{
            JobNotes = "<p>\(jobnotes)</p>"
        }
        
        for url in self.arrayScrolledImagesURLs{
            let st : String = "&nbsp;<img src=\"\(url)\" alt=\"\">"
            ImageUrls =  ImageUrls+st
        }
        
        //mailComposerVC.setToRecipients()
        mailComposerVC.setSubject("Sharing teeth job information")
        mailComposerVC.setMessageBody("<font face=\"Helvetica\" color=\"Black\"> <h2>Dental Log</h2> <h4><p>Job information for teeth \(self.teethNumber(num))</p></h4> \(JobSummary) \(JobType) \(Practitioner) \(PractitionerEmail) \(PractitionerPhone) </p> <p><strong>Date : </strong>\(newDate(self.selectedJob["dJobDate"] as! String))</p> <p><strong>Duration : </strong>\(self.convertHoursAndMinutes(self.selectedJob["iDuration"] as! String))</p> \(MaterialUsed) \(LinkedTeeth) <p><strong>Job Notes : </strong></p> \(JobNotes)  <p><strong>Job Images : </strong>  </p> \(ImageUrls) </font>"
            , isHTML: true)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func convertHoursAndMinutes(duration : String) -> String{
        
        let duration1 = Int(duration)! as Int
        if duration1 < 60 {
            return "0" + " " + "hours," + "\(duration1)" + " " + "mins"
        }
        else{
            let time = Int(duration1)
            let hours = time / 60
            let minute =  time % 60
            return "\(hours)" + " " + "hours, " + "\(minute)" + " " + "mins"
        }
    }
    
    
    func deleteJob(dictionary : NSDictionary){
        let deleteJob : [String : AnyObject] = ["X-API-KEY" : "dental!123" , "iJobID" : dictionary.objectForKey(kJobID)! , "iUserID" : dictionary.objectForKey(kUserID)!]
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        WebServies.makeDelete("job/jobdelete", parameters: deleteJob) { (json, error) -> () in
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            
            let alert = UIAlertController(title: kAppName, message: "Record deleted successfully" , preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (Result : UIAlertAction) -> Void in
                
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKindOfClass(JobListVC) {
                        self.navigationController?.popToViewController(controller as UIViewController, animated: true)
                        break
                    }
                }
            })
            alert.addAction(action)
            self.navigationController?.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    func redTeethMark(value : Int){
        
        switch(value){
            
        case 1:
            
            self.image18.hidden = false
            self.image18.image = UIImage(named: "18_r")
            break
            
        case 2:
            
            self.image17.hidden = false
            self.image17.image = UIImage(named: "17_r")
            break
            
        case 3:
            
            self.image16.hidden = false
            self.image16.image = UIImage(named: "16_r")
            break
            
            
        case 4:
            
            self.image15.hidden = false
            self.image15.image = UIImage(named: "15_r")
            break
            
        case 5:
            
            self.image14.hidden = false
            self.image14.image = UIImage(named: "14_r")
            break
            
            
        case 6:
            
            self.image13.hidden = false
            self.image13.image = UIImage(named: "13_r")
            break
            
            
        case 7:
            
            self.image12.hidden = false
            self.image12.image = UIImage(named: "12_r")
            break
            
        case 8:
            
            self.image11.hidden = false
            self.image11.image = UIImage(named: "11_r")
            break
            
        case 9:
            
            self.image21.hidden = false
            self.image21.image = UIImage(named: "21_r")
            break
            
        case 10:
            
            self.image22.hidden = false
            self.image22.image = UIImage(named: "22_r")
            break
            
            
        case 11:
            
            self.image23.hidden = false
            self.image23.image = UIImage(named: "23_r")
            break
            
            
        case 12:
            
            self.image24.hidden = false
            self.image24.image = UIImage(named: "24_r")
            break
            
            
        case 13:
            
            self.image25.hidden = false
            self.image25.image = UIImage(named: "25_r")
            break
            
            
        case 14:
            
            self.image26.hidden = false
            self.image26.image = UIImage(named: "26_r")
            break
            
            
        case 15:
            
            self.image27.hidden = false
            self.image27.image = UIImage(named: "27_r")
            break
            
            
        case 16:
            
            self.image28.hidden = false
            self.image28.image = UIImage(named: "28_r")
            break
            
            
        case 17:
            
            self.image38.hidden = false
            self.image38.image = UIImage(named: "38_r")
            break
            
            
        case 18:
            
            self.image37.hidden = false
            self.image37.image = UIImage(named: "37_r")
            break
            
            
            
        case 19:
            
            self.image36.hidden = false
            self.image36.image = UIImage(named: "36_r")
            break
            
            
        case 20:
            
            self.image35.hidden = false
            self.image35.image = UIImage(named: "35_r")
            break
            
            
        case 21:
            
            self.image34.hidden = false
            self.image34.image = UIImage(named: "34_r")
            break
            
        case 22:
            
            self.image33.hidden = false
            self.image33.image = UIImage(named: "33_r")
            break
            
            
            
        case 23:
            
            self.image32.hidden = false
            self.image32.image = UIImage(named: "32_r")
            break
            
            
            
        case 24:
            
            self.image31.hidden = false
            self.image31.image = UIImage(named: "31_r")
            break
            
            
        case 25:
            
            self.image41.hidden = false
            self.image41.image = UIImage(named: "41_r")
            break
            
            
        case 26:
            
            self.image42.hidden = false
            self.image42.image = UIImage(named: "42_r")
            break
            
        case 27:
            
            self.image43.hidden = false
            self.image43.image = UIImage(named: "43_r")
            break
            
        case 28:
            
            self.image44.hidden = false
            self.image44.image = UIImage(named: "44_r")
            break
            
        case 29:
            
            self.image45.hidden = false
            self.image45.image = UIImage(named: "45_r")
            break
            
        case 30:
            
            self.image46.hidden = false
            self.image46.image = UIImage(named: "46_r")
            break
            
        case 31:
            
            self.image47.hidden = false
            self.image47.image = UIImage(named: "47_r")
            break
            
        case 32:
            
            self.image48.hidden = false
            self.image48.image = UIImage(named: "48_r")
            break
            
        default :
            
            print("None")
            break
            
        }
        
    }
    
    
    func yellowTeethMark(value : Int){
        
        switch(value){
            
        case 1:
            
            self.image18.hidden = false
            self.image18.image = UIImage(named: "18_y")
            break
            
        case 2:
            
            self.image17.hidden = false
            self.image17.image = UIImage(named: "17_y")
            break
            
        case 3:
            
            self.image16.hidden = false
            self.image16.image = UIImage(named: "16_y")
            break
            
            
        case 4:
            
            self.image15.hidden = false
            self.image15.image = UIImage(named: "15_y")
            break
            
        case 5:
            
            self.image14.hidden = false
            self.image14.image = UIImage(named: "14_y")
            break
            
            
        case 6:
            
            self.image13.hidden = false
            self.image13.image = UIImage(named: "13_y")
            break
            
            
        case 7:
            
            self.image12.hidden = false
            self.image12.image = UIImage(named: "12_y")
            break
            
        case 8:
            
            self.image11.hidden = false
            self.image11.image = UIImage(named: "11_y")
            break
            
        case 9:
            
            self.image21.hidden = false
            self.image21.image = UIImage(named: "21_y")
            break
            
        case 10:
            
            self.image22.hidden = false
            self.image22.image = UIImage(named: "22_y")
            break
            
            
        case 11:
            
            self.image23.hidden = false
            self.image23.image = UIImage(named: "23_y")
            break
            
            
        case 12:
            
            self.image24.hidden = false
            self.image24.image = UIImage(named: "24_y")
            break
            
            
        case 13:
            
            self.image25.hidden = false
            self.image25.image = UIImage(named: "25_y")
            break
            
            
        case 14:
            
            self.image26.hidden = false
            self.image26.image = UIImage(named: "26_y")
            break
            
            
        case 15:
            
            self.image27.hidden = false
            self.image27.image = UIImage(named: "27_y")
            break
            
            
        case 16:
            
            self.image28.hidden = false
            self.image28.image = UIImage(named: "28_y")
            break
            
            
        case 17:
            
            self.image38.hidden = false
            self.image38.image = UIImage(named: "38_y")
            break
            
            
        case 18:
            
            self.image37.hidden = false
            self.image37.image = UIImage(named: "37_y")
            break
            
            
            
        case 19:
            
            self.image36.hidden = false
            self.image36.image = UIImage(named: "36_y")
            break
            
            
        case 20:
            
            self.image35.hidden = false
            self.image35.image = UIImage(named: "35_y")
            break
            
            
        case 21:
            
            self.image34.hidden = false
            self.image34.image = UIImage(named: "34_y")
            break
            
        case 22:
            
            self.image33.hidden = false
            self.image33.image = UIImage(named: "33_y")
            break
            
            
            
        case 23:
            
            self.image32.hidden = false
            self.image32.image = UIImage(named: "32_y")
            break
            
            
            
        case 24:
            
            self.image31.hidden = false
            self.image31.image = UIImage(named: "31_y")
            break
            
            
        case 25:
            
            self.image41.hidden = false
            self.image41.image = UIImage(named: "41_y")
            break
            
            
        case 26:
            
            self.image42.hidden = false
            self.image42.image = UIImage(named: "42_y")
            break
            
        case 27:
            
            self.image43.hidden = false
            self.image43.image = UIImage(named: "43_y")
            break
            
        case 28:
            
            self.image44.hidden = false
            self.image44.image = UIImage(named: "44_y")
            break
            
        case 29:
            
            self.image45.hidden = false
            self.image45.image = UIImage(named: "45_y")
            break
            
        case 30:
            
            self.image46.hidden = false
            self.image46.image = UIImage(named: "46_y")
            break
            
        case 31:
            
            self.image47.hidden = false
            self.image47.image = UIImage(named: "47_y")
            break
            
        case 32:
            
            self.image48.hidden = false
            self.image48.image = UIImage(named: "48_y")
            break
            
        default :
            
            print("None")
            break
            
        }
        
    }
    func teethNumber(teeth : Int) -> Int{
        
        switch(teeth){
            
        case 1:
            return 18
            
        case 2:
            return 17
            
        case 3:
            return 16
            
        case 4:
            
            return 15
            
            
        case 5:
            
            return 14
            
            
            
        case 6:
            
            return 13
            
            
            
        case 7:
            
            return 12
            
            
        case 8:
            
            return 11
            
            
        case 9:
            
            return 21
            
            
        case 10:
            
            return 22
            
            
            
        case 11:
            
            return 23
            
            
            
        case 12:
            
            return 24
            
            
            
        case 13:
            
            return 25
            
        case 14:
            
            return 26
            
        case 15:
            
            return 27
            
        case 16:
            
            return 28
            
        case 17:
            
            return 38
            
        case 18:
            
            return 37
            
        case 19:
            
            return 36
            
        case 20:
            
            return 35
            
        case 21:
            
            return 34
            
        case 22:
            
            return 33
            
        case 23:
            
            return 32
            
        case 24:
            
            return 31
            
        case 25:
            
            return 41
            
            
            
        case 26:
            
            return 42
            
            
            
        case 27:
            
            return 43
            
            
        case 28:
            
            return 44
            
            
        case 29:
            
            return 45
            
            
        case 30:
            
            return 46
            
            
        case 31:
            
            return 47
            
            
        case 32:
            
            return 48
            
            
        default :
            return 0
            
        }
    }
}




class CellViewJobImages: UICollectionViewCell {
    @IBOutlet weak var imgProfile: UIImageView!
}
