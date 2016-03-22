//
//  NewJobTableVC.swift
//  DentalDsign
//
//  Created by Nimble Chapps on 27/02/16.
//  Copyright © 2016 Nimble Chapps. All rights reserved.
//

import UIKit
import AddressBookUI
import ContactsUI
import PhotosUI
import AssetsLibrary


class NewJobTableVC: UITableViewController, AllImageAsset, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource,UIPickerViewDelegate,ABPeoplePickerNavigationControllerDelegate {
    
    
    //MARK:- Teeth Outlet
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn10: UIButton!
    @IBOutlet weak var btn11: UIButton!
    @IBOutlet weak var btn12: UIButton!
    @IBOutlet weak var btn13: UIButton!
    @IBOutlet weak var btn14: UIButton!
    @IBOutlet weak var btn15: UIButton!
    @IBOutlet weak var btn16: UIButton!
    @IBOutlet weak var btn17: UIButton!
    @IBOutlet weak var btn18: UIButton!
    @IBOutlet weak var btn19: UIButton!
    @IBOutlet weak var btn20: UIButton!
    @IBOutlet weak var btn21: UIButton!
    @IBOutlet weak var btn22: UIButton!
    @IBOutlet weak var btn23: UIButton!
    @IBOutlet weak var btn24: UIButton!
    @IBOutlet weak var btn25: UIButton!
    @IBOutlet weak var btn26: UIButton!
    @IBOutlet weak var btn27: UIButton!
    @IBOutlet weak var btn28: UIButton!
    @IBOutlet weak var btn29: UIButton!
    @IBOutlet weak var btn30: UIButton!
    @IBOutlet weak var btn31: UIButton!
    @IBOutlet weak var btn32: UIButton!
    
    @IBOutlet weak var txtTeethNo: UITextField!
    @IBOutlet var viewTeethNo: UIView!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var img6: UIImageView!
    @IBOutlet weak var img7: UIImageView!
    @IBOutlet weak var img8: UIImageView!
    @IBOutlet weak var img9: UIImageView!
    @IBOutlet weak var img10: UIImageView!
    @IBOutlet weak var img11: UIImageView!
    @IBOutlet weak var img12: UIImageView!
    @IBOutlet weak var img13: UIImageView!
    @IBOutlet weak var img14: UIImageView!
    @IBOutlet weak var img15: UIImageView!
    @IBOutlet weak var img16: UIImageView!
    @IBOutlet weak var img17: UIImageView!
    @IBOutlet weak var img18: UIImageView!
    @IBOutlet weak var img19: UIImageView!
    @IBOutlet weak var img20: UIImageView!
    @IBOutlet weak var img21: UIImageView!
    @IBOutlet weak var img22: UIImageView!
    @IBOutlet weak var img23: UIImageView!
    @IBOutlet weak var img24: UIImageView!
    @IBOutlet weak var img25: UIImageView!
    @IBOutlet weak var img26: UIImageView!
    @IBOutlet weak var img27: UIImageView!
    @IBOutlet weak var img28: UIImageView!
    @IBOutlet weak var img29: UIImageView!
    @IBOutlet weak var img30: UIImageView!
    @IBOutlet weak var img31: UIImageView!
    @IBOutlet weak var img32: UIImageView!
    @IBOutlet weak var imgRed: UIImageView!
    
    var arrayNewLinked = NSMutableArray()
    let userDetails = NSUserDefaults.standardUserDefaults().objectForKey("UserData")
    var ArrayoldImage = NSMutableArray()
    
    var arrayMateriaList = NSMutableArray()
    
    var arrJobTypeList = NSMutableArray()
    var jobTypeId : String!
    var originalDate : String!
    var durationMinute : String!
    var linkedTeeth = ""
    
    
    @IBOutlet var tableview: UITableView!
    
    @IBOutlet weak var txtJobSummery: UITextField!
    @IBOutlet weak var txtJobtype: UITextField!
    @IBOutlet weak var txtPracticianName: UITextField!
    @IBOutlet weak var txtPracticianEmailId: UITextField!
    @IBOutlet weak var txtPracticianContactNo: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtDuration: UITextField!
    @IBOutlet weak var txtMaterialUsed: UITextField!
    @IBOutlet weak var txtJobNote: UITextView! {
        didSet {
            txtJobNote.layer.cornerRadius = 5.0
            txtJobNote.layer.borderWidth = 0.5
            txtJobNote.layer.borderColor = UIColor(colorLiteralRed: 200.0/255.0, green: 200.0/255.0, blue: 201.0/255.0, alpha: 1).CGColor
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dtPicker = UIDatePicker()
    var pickerView : UIPickerView!
    var teethSelectorScrollVw : UIScrollView!
    
    let peoplePicker = ABPeoplePickerNavigationController()
    
    let imagP = UIImagePickerController()
    var arrImages = NSMutableArray()
    var isExpend = false
    
    var teethNo = 0
    
    var isEditable = false
    var editableData = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayMateriaList = NSUserDefaults.standardUserDefaults().valueForKey("MateriaList") as! NSMutableArray
        arrJobTypeList = NSUserDefaults.standardUserDefaults().valueForKey("JobList") as! NSMutableArray
        
        self.txtJobtype.resignFirstResponder()
        self.txtDuration.resignFirstResponder()
        self.txtDate.resignFirstResponder()
        self.txtMaterialUsed.resignFirstResponder()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        PhotoListViewController.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTap:"))
        
        viewTeethNo = NSBundle.mainBundle().loadNibNamed("View", owner: self, options: nil)[0] as! UIView
        self.setTeethTag()
        if isEditable {
            self.teethNo = teethIndex(self.teethNo)
            redMark(teethNo)
            
            jobTypeId = editableData.objectForKey("iJobTypeID")! as! String
            
            txtJobSummery.text = editableData.objectForKey("vJobTitle") as? String
            txtJobtype.text = editableData.objectForKey("vJobTypeName") as? String
            txtPracticianName.text = editableData.objectForKey("vPracticianName") as? String
            txtPracticianEmailId.text = editableData.objectForKey("vPracticianEmail") as? String
            txtPracticianContactNo.text = editableData.objectForKey("vPractcianContact") as? String
            txtJobNote.text = editableData.objectForKey("tDescription") as? String
            txtMaterialUsed.text = editableData.objectForKey("vMaterial") as? String
            
            let dateString = self.editableData.objectForKey(kJobDate) as? String
            let dateFormatter1 = NSDateFormatter()
            dateFormatter1.dateFormat = "yyyy-MM-dd"
            let dat1 = dateFormatter1.dateFromString(dateString!)
            let dateFormatter2 = NSDateFormatter()
            dateFormatter2.dateStyle = .MediumStyle
            dateFormatter2.timeStyle = .NoStyle
            txtDate.text = dateFormatter2.stringFromDate(dat1!)
            
            
            durationMinute = self.editableData.objectForKey(kJobDuration) as? String
            self.txtDuration.text = self.convertHoursAndMinutes(durationMinute!)
            
            if editableData.objectForKey("vLinkedJob") as? String == "" {
                print("Nothing")
            }else{
                linkedTeeth = editableData.objectForKey("vLinkedJob") as! String
                let components = linkedTeeth.componentsSeparatedByString(",")
                for linkNum in components{
                    let number = Int(linkNum)
                    clickButton(number!)
                }
            }
            
            let gallery = editableData.objectForKey("gallery") as? NSMutableArray ?? NSMutableArray()
            
            if gallery.count > 0{
                
                for dictImage in gallery{
                    let imageName = dictImage.objectForKey(kUserImage) as! String+"_50"+"_50"
                    let imageExtenstion = dictImage.objectForKey("vExtension") as! String
                    let imageP = kBaseImagePath+imageName+imageExtenstion
                    let urls = NSURL(string: imageP)
                    arrImages.addObject(urls!)
                }
            }
            
            
        }
        else {
            redMark(teethNo)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.row) {
            
        case 2 :
            if (isExpend) {
                return 205
            }
            else {
                return 85
            }
        case 6 :
            return 160
        case 7 :
            return 155
        case 8 :
            return 155
        default :
            return 85
        }
    }
    @IBAction func btnMoreTapped(sender: AnyObject) {
        self.tableview.beginUpdates()
        if (isExpend) {
            isExpend = false
        }
        else {
            isExpend = true
        }
        self.tableview.endUpdates()
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == txtDate || textField == txtDuration {
            showDtPicker(textField)
        }
        else if textField == txtJobtype || textField == txtMaterialUsed || textField == txtTeethNo{
            showPickerView(textField)
        }
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func btnContactTapped(sender: AnyObject) {
        self.view.endEditing(true)
        
        let status = ABAddressBookGetAuthorizationStatus()
        if status == .Denied || status == .Restricted {
            
            let alert = UIAlertController(title: kAppName, message: "\(kAppName) not have a permission to access Contact List", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Setting", style: .Default, handler: { (action : UIAlertAction) -> Void in
                let settingsUrl = NSURL(string: UIApplicationOpenSettingsURLString)
                if let url = settingsUrl {
                    UIApplication.sharedApplication().openURL(url)
                }
            }))
            self.navigationController?.presentViewController(alert, animated: true, completion: nil)
            
            
            return
        }
        
        // open it
        
        var error: Unmanaged<CFError>?
        let addressBook: ABAddressBook? = ABAddressBookCreateWithOptions(nil, &error)?.takeRetainedValue()
        if addressBook == nil {
            // print(error?.takeRetainedValue())
            return
        }
        
        // request permission to use it
        
        ABAddressBookRequestAccessWithCompletion(addressBook) {
            granted, error in
            
            if !granted {
                // warn the user that because they just denied permission, this functionality won't work
                // also let them know that they have to fix this in settings
                return
            }
            self.peoplePicker.peoplePickerDelegate = self
            self.presentViewController(self.peoplePicker, animated: true, completion: nil)
            
        }
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord) {
        
        self.txtPracticianName.becomeFirstResponder()
        
        
        var fname : String = ""
        var lname : String = ""
        
        
        if let first = ABRecordCopyValue(person, kABPersonFirstNameProperty)?.takeRetainedValue() as? String    {
            fname = first
        }
        if let last  = ABRecordCopyValue(person, kABPersonLastNameProperty)?.takeRetainedValue() as? String {
            lname = last
        }
        
        
        
        self.txtPracticianName.text = (fname + " " + lname)
        
        let phone: ABMultiValueRef = ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue()
        if ABMultiValueGetCount(phone) > 0 {
            let index = 0 as CFIndex
            let phoneNo = ABMultiValueCopyValueAtIndex(phone, index).takeRetainedValue() as! String
            self.txtPracticianContactNo.text = phoneNo
            //print(phoneNo)
        } else {
            print("No phone Number")
            txtPracticianContactNo.text = ""
        }
        
        let emails: ABMultiValueRef = ABRecordCopyValue(person, kABPersonEmailProperty).takeRetainedValue()
        if ABMultiValueGetCount(emails) > 0 {
            let index = 0 as CFIndex
            let emailAddress = ABMultiValueCopyValueAtIndex(emails, index).takeRetainedValue() as! String
            self.txtPracticianEmailId.text = emailAddress
            //print(emailAddress)
        } else {
            print("No email address")
            txtPracticianEmailId.text = ""
        }
    }
    
    
    func showDtPicker(textField : UITextField) {
        dtPicker = UIDatePicker(frame:CGRectMake(0, 0, self.view.frame.size.width, 216))
        dtPicker.backgroundColor = UIColor.whiteColor()
        textField.inputView = dtPicker
        
        if textField == txtDate {
            dtPicker.datePickerMode = UIDatePickerMode.Date
        }
        else  if textField == txtDuration{
            dtPicker.datePickerMode = UIDatePickerMode.Time
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat =  "HH:mm"
            let date = dateFormatter.dateFromString("00:00")
            dtPicker.date = date!
            dtPicker.locale = NSLocale(localeIdentifier: "NL")
        }
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton, spaceButton, cancelButton : UIBarButtonItem
        if textField == txtDate {
            doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "doneClickDate")
            spaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
            cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "cancelClickDate")
        }
        else {
            doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "doneClickDuratin")
            spaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
            cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "cancelClickDuration")
        }
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    func showPickerView(textField : UITextField){
        
        pickerView = UIPickerView(frame:CGRectMake(0, 0, self.view.frame.size.width, 216))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.whiteColor()
        textField.inputView = pickerView
        
        if textField == txtTeethNo {
            teethSelectorScrollVw = UIScrollView(frame:CGRectMake(0, 0, self.view.frame.size.width, 216))
            teethSelectorScrollVw.contentSize = CGSizeMake(800, 216);
            teethSelectorScrollVw.addSubview(viewTeethNo)
            textField.inputView = teethSelectorScrollVw
            self.txtTeethNo.tintColor = UIColor.clearColor()
        }
        else if textField == txtMaterialUsed{
            pickerView.tag = 1
        }else{
            pickerView.tag = 2
        }
        
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "pickerClick")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "pickerClick")
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        
    }
    func pickerClick() {
        self.txtJobtype.resignFirstResponder()
        self.txtMaterialUsed.resignFirstResponder()
        self.txtTeethNo.resignFirstResponder()
    }
    
    //MARK:- PickerView DataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1{
            return self.arrayMateriaList.count
        }else{
            return self.arrJobTypeList.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1{
            self.txtMaterialUsed.text = self.arrayMateriaList[row].objectForKey("vMaterialValue") as? String
            return self.arrayMateriaList[row].objectForKey("vMaterialValue") as? String
        }else{
            self.txtJobtype.text = self.arrJobTypeList[row].objectForKey("vJobTypeName") as? String
            jobTypeId = self.arrJobTypeList[row]["iJobTypeID"] as? String
            return self.arrJobTypeList[row].objectForKey("vJobTypeName") as? String
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1{
            self.txtMaterialUsed.text = self.arrayMateriaList[row].objectForKey("vMaterialValue") as? String
        }else{
            jobTypeId = self.arrJobTypeList[row]["iJobTypeID"] as? String
            self.txtJobtype.text = self.arrJobTypeList[row].objectForKey("vJobTypeName") as? String
        }
    }
    
    func doneClickDate() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        originalDate = dateFormatter.stringFromDate(dtPicker.date)
        
        let dateFormator = NSDateFormatter()
        dateFormator.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormator.timeStyle = NSDateFormatterStyle.NoStyle
        txtDate.text = dateFormator.stringFromDate(dtPicker.date)
        txtDate.resignFirstResponder()
    }
    
    func cancelClickDate() {
        txtDate.resignFirstResponder()
    }
    
    func doneClickDuratin() {
        let dateFormator = NSDateFormatter()
        dateFormator.dateFormat = "HH:mm"
        
        durationMinute = self.convertMinute(dateFormator.stringFromDate(dtPicker.date).componentsSeparatedByString(":")[0], minute: dateFormator.stringFromDate(dtPicker.date).componentsSeparatedByString(":")[1])
        
        
        txtDuration.text = dateFormator.stringFromDate(dtPicker.date).componentsSeparatedByString(":")[0] + " Hours, " +
            dateFormator.stringFromDate(dtPicker.date).componentsSeparatedByString(":")[1] + " Mins"
        txtDuration.resignFirstResponder()
        
    }
    
    func convertMinute(hours : String , minute : String ) -> String{
        let hour = Int(hours)
        let mint = Int(minute)
        let total = (hour! * 60) + mint!
        return String(total)
    }
    
    func cancelClickDuration() {
        txtDuration.resignFirstResponder()
    }
    
    
    
    
    
    //MARK:- CollectionView DataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (arrImages.count + 1)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : JobImagesCell = collectionView.dequeueReusableCellWithReuseIdentifier("JobImages", forIndexPath: indexPath) as! JobImagesCell
        cell.btnRemove.layer.cornerRadius = 9.0
        cell.PrifleImage.layer.masksToBounds = true
        cell.PrifleImage.layer.cornerRadius = 5.0
        if(indexPath.row == arrImages.count) {
            cell.PrifleImage.image = UIImage(named: "addBtn")
            cell.btnRemove.hidden = true
        }
        else {
            if isEditable {
                if (arrImages.objectAtIndex(indexPath.row).isKindOfClass(PHAsset)){
                    let imageC = self.arrImages.objectAtIndex(indexPath.row) as? PHAsset
                    cell.PrifleImage.image = self.getAssetThumbnail(imageC!)
                    
                }else if (arrImages.objectAtIndex(indexPath.row).isKindOfClass(UIImage)){
                    cell.PrifleImage.image = self.arrImages .objectAtIndex(indexPath.row) as? UIImage
                    
                }else{
                    cell.PrifleImage.setImageWithURL(self.arrImages.objectAtIndex(indexPath.row) as! NSURL, placeholderImage: nil)
                }
                cell.btnRemove.hidden = false
                cell.btnRemove.tag = indexPath.row
                cell.btnRemove.addTarget(self, action: "btnRemoveTapped:", forControlEvents: UIControlEvents.TouchUpInside)
                
            }
            else {
                cell.PrifleImage.image = self.getAssetThumbnail(self.arrImages.objectAtIndex(indexPath.row) as! PHAsset)
                cell.btnRemove.hidden = true
                cell.btnRemove.tag = indexPath.row
                cell.btnRemove.addTarget(self, action: "btnRemoveTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            }
        }
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.txtJobNote.endEditing(true)
        if (indexPath.row == arrImages.count) {
            ImageFromCameraAndMultuiSelection()
        }
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.defaultManager()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.synchronous = true
        
        
        manager.requestImageForAsset(asset, targetSize: CGSize(width: 120.0, height: 120.0), contentMode: .AspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
    
    func btnRemoveTapped(button : UIButton!) {
        
        if (arrImages.objectAtIndex(button.tag).isKindOfClass(PHAsset)){
            
        }else if (arrImages.objectAtIndex(button.tag).isKindOfClass(UIImage)){
            
        }else{
            
            if let  url  = self.arrImages.objectAtIndex(button.tag) as? NSURL{
                if let str = url.lastPathComponent{
                    self.ArrayoldImage.addObject(str.stringByReplacingOccurrencesOfString("_50_50", withString:""))
                }
            }
            else{
                print("Nothing to add")
            }
            
            
        }
        
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.arrImages.removeObjectAtIndex(button.tag)
            self.collectionView.reloadData()
        }
    }
    
    func ImageFromCameraAndMultuiSelection(){
        
        let ActionSheet = UIAlertController(title: nil, message: "Select Photos", preferredStyle: .ActionSheet)
        
        let cameraPhoto = UIAlertAction(title: "Camera", style: .Default, handler: {
            (alert: UIAlertAction) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
                self.imagP.delegate = self
                self.imagP.sourceType = UIImagePickerControllerSourceType.Camera;
                self.imagP.allowsEditing = false
                self.presentViewController(self.imagP, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: kAppName, message: "Device doen't have Camera", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
                self.navigationController?.presentViewController(alert, animated: true, completion: nil)
            }
        })
        
        let PhotoLibrary = UIAlertAction(title: "Photo Library", style: .Default, handler: {
            (alert: UIAlertAction) -> Void in
            
            if PHPhotoLibrary.authorizationStatus() == .Authorized {
                self.performSegueWithIdentifier("AlbumTypeSegue", sender: nil)
            }
            else {
                let alert = UIAlertController(title: kAppName, message: "\(kAppName) not have a permission to access Photo Library", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Setting", style: .Default, handler: { (action : UIAlertAction) -> Void in
                    let settingsUrl = NSURL(string: UIApplicationOpenSettingsURLString)
                    if let url = settingsUrl {
                        UIApplication.sharedApplication().openURL(url)
                    }
                }))
                self.navigationController?.presentViewController(alert, animated: true, completion: nil)
            }
            
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction) -> Void in
        })
        
        ActionSheet.addAction(cameraPhoto)
        ActionSheet.addAction(PhotoLibrary)
        ActionSheet.addAction(cancelAction)
        
        self.presentViewController(ActionSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func btnSubmitTapped(sender: AnyObject) {
        self.view.endEditing(true)
        
        if txtJobSummery.text?.characters.count == 0{
            let alert = UIAlertController(title: kAppName, message: "Please enter Job Summary.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.navigationController?.presentViewController(alert, animated: true, completion: nil)
        }
        else if txtJobtype.text?.characters.count == 0 {
            let alert = UIAlertController(title: kAppName, message: "Please enter Job Type.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.navigationController?.presentViewController(alert, animated: true, completion: nil)
        }
        else if txtPracticianName.text?.characters.count == 0 {
            let alert = UIAlertController(title: kAppName, message: "Please enter Practician Name or select from addressbook.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.navigationController?.presentViewController(alert, animated: true, completion: nil)
        }
        else if txtDate.text?.characters.count == 0 {
            let alert = UIAlertController(title: kAppName, message: "Please choose Date.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.navigationController?.presentViewController(alert, animated: true, completion: nil)
        }
        else if txtDuration.text?.characters.count == 0 {
            let alert = UIAlertController(title: kAppName, message: "Please choose Duration.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.navigationController?.presentViewController(alert, animated: true, completion: nil)
        }
        else if txtMaterialUsed.text?.characters.count == 0 {
            let alert = UIAlertController(title: kAppName, message: "Please choose Material.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.navigationController?.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            if isEditable == true {
                // Update Record
                self.editJob()
            }
            else {
                // Insert Record
                self.addNewJob()
            }
        }
    }
    
    func addNewJob() -> Void {
        
        var link : String!
        if let linked : String = arrayNewLinked.componentsJoinedByString(","){
            link = linked
        }
        link = link + "," + "\(teethIndex(teethNo))"
        
        
        var parameter : [String : AnyObject] = [kUserAPIKey : "dental!123" ,
            kJobTitle : txtJobSummery.text! ,
            kToothNo : "\(teethIndex(teethNo))",
            kUserID : userDetails!.objectForKey(kUserID)! ,
            kJobTypeID : jobTypeId! ,
            kJobParcticianName : txtPracticianName.text!,
            kJobParcticianAddress : "Address",
            kJobParcticianContact : self.txtPracticianContactNo.text! ,
            kJobParcticianEmail : self.txtPracticianEmailId.text! ,
            kJobDate : originalDate!,
            kJobDuration : durationMinute! ,
            kJobLinkedJob : link!,
            kJobMaterial : self.txtMaterialUsed.text! ,
            kJobDescription : txtJobNote.text!]
        
        if arrImages.count == 0 {
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            WebServies.makePost("job/add", parameter: parameter) { (json, error) -> () in
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                if error == nil {
                    if json.objectForKey("msg") as! String == "Job added successfully"{
                        
                        let alert = UIAlertController(title: kAppName, message: json.objectForKey("msg") as? String , preferredStyle: UIAlertControllerStyle.Alert)
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
                        
                    }else{
                        
                        let alert = UIAlertController(title: kAppName, message: json.objectForKey("msg") as? String , preferredStyle: UIAlertControllerStyle.Alert)
                        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                        alert.addAction(action)
                        self.navigationController?.presentViewController(alert, animated: true, completion: nil)
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
        else {
            
            let imageArray = NSMutableArray()
            
            var indexTitle = 0
            
            for i in 0..<self.arrImages.count{
                
                if (arrImages.objectAtIndex(i).isKindOfClass(PHAsset)){
                    let title = ""
                    parameter["vTitle"+"\(indexTitle + 1)"] = title
                    imageArray.addObject(UIImageJPEGRepresentation(self.originalImage(arrImages.objectAtIndex(i) as! PHAsset), 0.5)!)
                    indexTitle++
                    
                }else if(arrImages.objectAtIndex(i).isKindOfClass(UIImage)){
                    let title = ""
                    parameter["vTitle"+"\(indexTitle + 1)"] = title
                    imageArray.addObject(UIImageJPEGRepresentation(arrImages.objectAtIndex(i) as! UIImage, 0.5)!)
                    indexTitle++
                }else{
                    print("nothing")
                }
            }
            
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            WebServies.uploadEditImage(imageArray, url: "job/add", name: "vImage", fileName: "vImage", mimeType: "image/jpg", parameters: parameter, block: { (json, error) -> () in
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                if error == nil {
                    
                    if json.objectForKey("status") as! String == "200" || json.objectForKey("status") as! String == "201"{
                        
                        let alert = UIAlertController(title: kAppName, message: json.objectForKey("msg") as? String , preferredStyle: UIAlertControllerStyle.Alert)
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
                        
                    }else{
                        
                        let alert = UIAlertController(title: "TeethLog", message: json.objectForKey("msg") as? String , preferredStyle: UIAlertControllerStyle.Alert)
                        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (Result : UIAlertAction) -> Void in
                        })
                        alert.addAction(action)
                        self.navigationController?.presentViewController(alert, animated: true, completion: nil)
                    }
                    
                }
                else {
                    let alertView = UIAlertController(title: kAppName, message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertView.addAction(defaultAction)
                    self.presentViewController(alertView, animated: true, completion: nil)
                }
            })
            
        }
    }
    
    func originalImage(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.defaultManager()
        let option = PHImageRequestOptions()
        option.synchronous = true
        var thumbnail = UIImage()
        option.synchronous = true
        manager.requestImageForAsset(asset, targetSize: CGSize(width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height), contentMode: .AspectFill, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
    
    func editJob()->Void {
        
        originalDate = editableData.objectForKey("dJobDate") as! String + " " + "00:00:00"
        
        var linkAllTeeth = linkedTeeth + "," + "\(teethIndex(teethNo))"
        
        if (linkAllTeeth as NSString).substringToIndex(1) == ","{
            
            linkAllTeeth = (linkAllTeeth as NSString).substringFromIndex(1)
        }
        
        var linkCurrentTeeth : String!
        if let linked : String = arrayNewLinked.componentsJoinedByString(","){
            linkCurrentTeeth = linked
        }
        linkCurrentTeeth = linkCurrentTeeth + "," + "\(teethIndex(teethNo))"
        
        if (linkCurrentTeeth as NSString).substringToIndex(1) == ","{
            
            linkCurrentTeeth = (linkCurrentTeeth as NSString).substringFromIndex(1)
        }
        
        
        let oldImagenumber : String!
        
        if self.ArrayoldImage.count > 0{
            oldImagenumber = self.ArrayoldImage.componentsJoinedByString(",")
        }else{
            oldImagenumber  = ""
        }
        
        var parameter : [String : AnyObject] = [kUserAPIKey : "dental!123",
            kJobTitle : txtJobSummery.text! ,
            kJobID : self.editableData.objectForKey(kJobID)!,
            kToothNo : "\(teethIndex(teethNo))",
            kUserID : userDetails!.objectForKey(kUserID)! ,
            kJobTypeID : jobTypeId! ,
            kJobParcticianName : txtPracticianName.text!,
            kJobParcticianAddress : "Address",
            kJobParcticianContact : self.txtPracticianContactNo.text! ,
            kJobParcticianEmail : self.txtPracticianEmailId.text! ,
            kJobDate : originalDate!,
            kJobDuration : durationMinute! ,
            kJobOldLinked : linkAllTeeth,
            kJobCurrentLinkedJob : linkCurrentTeeth,
            kJobMaterial : self.txtMaterialUsed.text! ,
            kJobDescription : txtJobNote.text!,
            kJobOldImage : oldImagenumber]
        
        let imageArray = NSMutableArray()
        
        var indexTitle = 0
        
        for i in 0..<self.arrImages.count{
            
            if (arrImages.objectAtIndex(i).isKindOfClass(PHAsset)){
                let title = ""
                parameter["vTitle"+"\(indexTitle + 1)"] = title
                imageArray.addObject(UIImageJPEGRepresentation(self.originalImage(arrImages.objectAtIndex(i) as! PHAsset), 0.5)!)
                indexTitle++
                
            }else if(arrImages.objectAtIndex(i).isKindOfClass(UIImage)){
                let title = ""
                parameter["vTitle"+"\(indexTitle + 1)"] = title
                imageArray.addObject(UIImageJPEGRepresentation(arrImages.objectAtIndex(i) as! UIImage, 0.5)!)
                indexTitle++
            }else{
                
                print("nothing")
            }
        }
        
        if imageArray.count == 0{
            
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            WebServies.makePost("job/edit", parameter: parameter, block: { (json, error) -> () in
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                if error == nil {
                    if json.objectForKey("status") as! String == "200" || json.objectForKey("status") as! String == "201"{
                        
                        let alert = UIAlertController(title: kAppName, message: json.objectForKey("msg") as? String , preferredStyle: UIAlertControllerStyle.Alert)
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
                else {
                    let alertView = UIAlertController(title: kAppName, message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertView.addAction(defaultAction)
                    self.presentViewController(alertView, animated: true, completion: nil)
                }
            })
        }
        else {
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            WebServies.uploadEditImage(imageArray, url: "job/edit", name: "vImage", fileName: "vImage", mimeType: "image/jpg", parameters: parameter, block: { (json, error) -> () in
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                
                if error == nil {
                    if json.objectForKey("status") as! String == "200" || json.objectForKey("status") as! String == "201"{
                        
                        let alert = UIAlertController(title: kAppName, message: json.objectForKey("msg") as? String , preferredStyle: UIAlertControllerStyle.Alert)
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
                else {
                    let alertView = UIAlertController(title: kAppName, message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertView.addAction(defaultAction)
                    self.presentViewController(alertView, animated: true, completion: nil)
                }
            })
        }
    }
    
    func getResponse(responseObject: NSMutableArray) {
        self.arrImages.addObjectsFromArray(responseObject as [AnyObject])
        self.collectionView.reloadData()
    }
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
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
    
    //MARK:- Teeth Methods
    
    @IBAction func Click_1(sender: UIButton) {
        sender.tintColor = UIColor(colorLiteralRed: 250/255, green: 200/255, blue: 29/255, alpha: 1)
        yellowMark(sender.tag)
        
    }
    
    func redMark(no : Int) {
        
        switch no {
            
        case 8 :
            self.btn1.userInteractionEnabled = false
            self.btn1.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img1.image = UIImage(named: "18_r")
            img1.hidden = false
            break
            
        case 7:
            self.btn2.userInteractionEnabled = false
            self.btn2.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img2.image = UIImage(named: "17_r")
            img2.hidden = false
            break
            
        case 6:
            self.btn3.userInteractionEnabled = false
            self.btn3.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img3.image = UIImage(named: "16_r")
            img3.hidden = false
            break
            
        case 5:
            self.btn4.userInteractionEnabled = false
            self.btn4.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img4.image = UIImage(named: "15_r")
            img4.hidden = false
            break
            
        case 4:
            self.btn5.userInteractionEnabled = false
            self.btn5.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img5.image = UIImage(named: "14_r")
            img5.hidden = false
            break
            
        case 3:
            self.btn6.userInteractionEnabled = false
            self.btn6.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img6.image = UIImage(named: "13_r")
            img6.hidden = false
            break
            
        case 2:
            self.btn7.userInteractionEnabled = false
            self.btn7.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img7.image = UIImage(named: "12_r")
            img7.hidden = false
            break
            
        case 1:
            self.btn8.userInteractionEnabled = false
            self.btn8.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img8.image = UIImage(named: "11_r")
            img8.hidden = false
            break
            
        case 9:
            self.btn9.userInteractionEnabled = false
            self.btn9.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img9.image = UIImage(named: "21_r")
            img9.hidden = false
            break
            
        case 10:
            self.btn10.userInteractionEnabled = false
            self.btn10.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img10.image = UIImage(named: "22_r")
            img10.hidden = false
            break
            
        case 11:
            self.btn11.userInteractionEnabled = false
            self.btn11.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img11.image = UIImage(named: "23_r")
            img11.hidden = false
            break
            
        case 12:
            self.btn12.userInteractionEnabled = false
            self.btn12.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img12.image = UIImage(named: "24_r")
            img12.hidden = false
            break
            
        case 13:
            self.btn13.userInteractionEnabled = false
            self.btn13.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img13.image = UIImage(named: "25_r")
            img13.hidden = false
            break
        case 14:
            self.btn14.userInteractionEnabled = false
            self.btn14.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img14.image = UIImage(named: "26_r")
            img14.hidden = false
            break
            
        case 15:
            self.btn15.userInteractionEnabled = false
            self.btn15.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img15.image = UIImage(named: "27_r")
            img15.hidden = false
            break
            
        case 16:
            self.btn16.userInteractionEnabled = false
            self.btn16.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img16.image = UIImage(named: "28_r")
            img16.hidden = false
            break
            
        case 24:
            self.btn17.userInteractionEnabled = false
            self.btn17.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img17.image = UIImage(named: "38_r")
            img17.hidden = false
            break
            
        case 23:
            self.btn18.userInteractionEnabled = false
            self.btn18.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img18.image = UIImage(named: "37_r")
            img18.hidden = false
            break
            
        case 22:
            self.btn19.userInteractionEnabled = false
            self.btn19.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img19.image = UIImage(named: "36_r")
            img19.hidden = false
            break
            
        case 21:
            self.btn20.userInteractionEnabled = false
            self.btn20.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img20.image = UIImage(named: "35_r")
            img20.hidden = false
            break
            
        case 20:
            self.btn21.userInteractionEnabled = false
            self.btn21.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img21.image = UIImage(named: "34_r")
            img21.hidden = false
            break
            
        case 19:
            self.btn22.userInteractionEnabled = false
            self.btn22.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img22.image = UIImage(named: "33_r")
            img22.hidden = false
            break
            
        case 18:
            self.btn23.userInteractionEnabled = false
            self.btn23.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img23.image = UIImage(named: "32_r")
            img23.hidden = false
            break
            
        case 17:
            self.btn24.userInteractionEnabled = false
            self.btn24.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img24.image = UIImage(named: "31_r")
            img24.hidden = false
            break
            
        case 25:
            self.btn25.userInteractionEnabled = false
            self.btn25.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img25.image = UIImage(named: "41_r")
            img25.hidden = false
            break
            
        case 26:
            self.btn26.userInteractionEnabled = false
            self.btn26.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img26.image = UIImage(named: "42_r")
            img26.hidden = false
            break
            
        case 27:
            self.btn27.userInteractionEnabled = false
            self.btn27.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img27.image = UIImage(named: "43_r")
            img27.hidden = false
            break
            
        case 28:
            self.btn28.userInteractionEnabled = false
            self.btn28.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img28.image = UIImage(named: "44_r")
            img28.hidden = false
            break
            
        case 29:
            self.btn29.userInteractionEnabled = false
            self.btn29.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img29.image = UIImage(named: "45_r")
            img29.hidden = false
            break
            
        case 30:
            self.btn30.userInteractionEnabled = false
            self.btn30.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img30.image = UIImage(named: "46_r")
            img30.hidden = false
            break
            
        case 31:
            self.btn31.userInteractionEnabled = false
            self.btn31.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img31.image = UIImage(named: "47_r")
            img31.hidden = false
            break
            
        case 32:
            self.btn32.userInteractionEnabled = false
            self.btn32.setImage(UIImage(named: "RedBtn"), forState: UIControlState.Normal)
            img32.image = UIImage(named: "48_r")
            img32.hidden = false
            break
            
        default :
            print("Pass Teeth No")
        }
    }
    
    func yellowMark(no : Int) {
        
        switch no {
            
        case 18 :
            if img1.tag == 0 {
                arrayNewLinked.addObject("1")
                self.btn1.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img1.image = UIImage(named: "18_y")
                img1.hidden = false
                img1.tag = 1
            }
            else {
                arrayNewLinked.removeObject("1")
                self.btn1.setImage(nil, forState: UIControlState.Normal)
                img1.image = nil
                img1.hidden = true
                img1.tag = 0
            }
            break
            
        case 17:
            if img2.tag == 0 {
                arrayNewLinked.addObject("2")
                self.btn2.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img2.image = UIImage(named: "17_y")
                img2.hidden = false
                img2.tag = 1
            }
            else {
                arrayNewLinked.removeObject("2")
                self.btn2.setImage(nil, forState: UIControlState.Normal)
                img2.image = nil
                img2.hidden = true
                img2.tag = 0
            }
            break
            
        case 16:
            if img3.tag == 0 {
                arrayNewLinked.addObject("3")
                self.btn3.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img3.image = UIImage(named: "16_y")
                img3.hidden = false
                img3.tag = 1
            }
            else {
                arrayNewLinked.removeObject("3")
                self.btn3.setImage(nil, forState: UIControlState.Normal)
                img3.image = nil
                img3.hidden = true
                img3.tag = 0
            }
            break
            
        case 15:
            if img4.tag == 0 {
                arrayNewLinked.addObject("4")
                self.btn4.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img4.image = UIImage(named: "15_y")
                img4.hidden = false
                img4.tag = 1
            }
            else {
                arrayNewLinked.removeObject("4")
                self.btn4.setImage(nil, forState: UIControlState.Normal)
                img4.image = nil
                img4.hidden = true
                img4.tag = 0
            }
            break
            
        case 14:
            if img5.tag == 0 {
                arrayNewLinked.addObject("5")
                self.btn5.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img5.image = UIImage(named: "14_y")
                img5.hidden = false
                img5.tag = 1
            }
            else {
                arrayNewLinked.removeObject("5")
                self.btn5.setImage(nil, forState: UIControlState.Normal)
                img5.image = nil
                img5.hidden = true
                img5.tag = 0
            }
            break
            
        case 13:
            if img6.tag == 0 {
                arrayNewLinked.addObject("6")
                self.btn6.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img6.image = UIImage(named: "13_y")
                img6.hidden = false
                img6.tag = 1
            }
            else {
                arrayNewLinked.removeObject("6")
                self.btn6.setImage(nil, forState: UIControlState.Normal)
                img6.image = nil
                img6.hidden = true
                img6.tag = 0
            }
            break
            
        case 12:
            if img7.tag == 0 {
                arrayNewLinked.addObject("7")
                self.btn7.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img7.image = UIImage(named: "12_y")
                img7.hidden = false
                img7.tag = 1
            }
            else {
                arrayNewLinked.removeObject("7")
                self.btn7.setImage(nil, forState: UIControlState.Normal)
                img7.image = nil
                img7.hidden = true
                img7.tag = 0
            }
            break
            
        case 11:
            if img8.tag == 0 {
                arrayNewLinked.addObject("8")
                self.btn8.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img8.image = UIImage(named: "11_y")
                img8.hidden = false
                img8.tag = 1
            }
            else {
                arrayNewLinked.removeObject("8")
                self.btn8.setImage(nil, forState: UIControlState.Normal)
                img8.image = nil
                img8.hidden = true
                img8.tag = 0
            }
            break
            
        case 21:
            if img8.tag == 0 {
                arrayNewLinked.addObject("9")
                self.btn9.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img9.image = UIImage(named: "21_y")
                img9.hidden = false
                img8.tag = 1
            }
            else {
                arrayNewLinked.removeObject("9")
                self.btn9.setImage(nil, forState: UIControlState.Normal)
                img9.image = nil
                img9.hidden = true
                img8.tag = 0
            }
            break
            
        case 22:
            if img10.tag == 0 {
                arrayNewLinked.addObject("10")
                self.btn10.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img10.image = UIImage(named: "22_y")
                img10.hidden = false
                img10.tag = 1
            }
            else {
                arrayNewLinked.removeObject("10")
                self.btn10.setImage(nil, forState: UIControlState.Normal)
                img10.image = nil
                img10.hidden = true
                img10.tag = 0
            }
            break
            
        case 23:
            if img11.tag == 0 {
                arrayNewLinked.addObject("11")
                self.btn11.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img11.image = UIImage(named: "23_y")
                img11.hidden = false
                img11.tag = 1
            }
            else {
                arrayNewLinked.removeObject("11")
                self.btn11.setImage(nil, forState: UIControlState.Normal)
                img11.image = nil
                img11.hidden = true
                img11.tag = 0
            }
            break
            
        case 24:
            if img12.tag == 0 {
                arrayNewLinked.addObject("12")
                self.btn12.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img12.image = UIImage(named: "24_y")
                img12.hidden = false
                img12.tag = 1
            }
            else {
                arrayNewLinked.removeObject("12")
                self.btn12.setImage(nil, forState: UIControlState.Normal)
                img12.image = nil
                img12.hidden = true
                img12.tag = 0
            }
            break
            
        case 25:
            if img13.tag == 0 {
                arrayNewLinked.addObject("13")
                self.btn13.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img13.image = UIImage(named: "25_y")
                img13.hidden = false
                img13.tag = 1
            }
            else {
                arrayNewLinked.removeObject("13")
                self.btn13.setImage(nil, forState: UIControlState.Normal)
                img13.image = nil
                img13.hidden = true
                img13.tag = 0
            }
            break
        case 26:
            if img14.tag == 0 {
                arrayNewLinked.addObject("14")
                self.btn14.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img14.image = UIImage(named: "26_y")
                img14.hidden = false
                img14.tag = 1
            }
            else {
                arrayNewLinked.removeObject("14")
                self.btn14.setImage(nil, forState: UIControlState.Normal)
                img14.image = nil
                img14.hidden = true
                img14.tag = 0
            }
            break
            
        case 27:
            if img15.tag == 0 {
                arrayNewLinked.addObject("15")
                self.btn15.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img15.image = UIImage(named: "27_y")
                img15.hidden = false
                img15.tag = 1
            }
            else {
                arrayNewLinked.removeObject("15")
                self.btn15.setImage(nil, forState: UIControlState.Normal)
                img15.image = nil
                img15.hidden = true
                img15.tag = 0
            }
            break
            
        case 28:
            if img16.tag == 0 {
                arrayNewLinked.addObject("16")
                self.btn16.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img16.image = UIImage(named: "28_y")
                img16.hidden = false
                img16.tag = 1
            }
            else {
                arrayNewLinked.removeObject("16")
                self.btn16.setImage(nil, forState: UIControlState.Normal)
                img16.image = nil
                img16.hidden = true
                img16.tag = 0
            }
            break
            
        case 38:
            if img17.tag == 0 {
                arrayNewLinked.addObject("17")
                self.btn17.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img17.image = UIImage(named: "38_y")
                img17.hidden = false
                img17.tag = 1
            }
            else {
                arrayNewLinked.removeObject("17")
                self.btn17.setImage(nil, forState: UIControlState.Normal)
                img17.image = nil
                img17.hidden = true
                img17.tag = 0
            }
            break
            
        case 37:
            if img18.tag == 0 {
                arrayNewLinked.addObject("18")
                self.btn18.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img18.image = UIImage(named: "37_y")
                img18.hidden = false
                img18.tag = 1
            }
            else {
                arrayNewLinked.removeObject("18")
                self.btn18.setImage(nil, forState: UIControlState.Normal)
                img18.image = nil
                img18.hidden = true
                img18.tag = 0
            }
            break
            
        case 36:
            if img19.tag == 0 {
                arrayNewLinked.addObject("19")
                self.btn19.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img19.image = UIImage(named: "36_y")
                img19.hidden = false
                img19.tag = 1
            }
            else {
                arrayNewLinked.removeObject("19")
                self.btn19.setImage(nil, forState: UIControlState.Normal)
                img19.image = nil
                img19.hidden = true
                img19.tag = 0
            }
            break
            
        case 35:
            if img20.tag == 0 {
                arrayNewLinked.addObject("20")
                self.btn20.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img20.image = UIImage(named: "35_y")
                img20.hidden = false
                img20.tag = 1
            }
            else {
                arrayNewLinked.removeObject("20")
                self.btn20.setImage(nil, forState: UIControlState.Normal)
                img20.image = nil
                img20.hidden = true
                img20.tag = 0
            }
            break
            
        case 34:
            if img21.tag == 0 {
                arrayNewLinked.addObject("21")
                self.btn21.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img21.image = UIImage(named: "34_y")
                img21.hidden = false
                img21.tag = 1
            }
            else {
                arrayNewLinked.removeObject("21")
                self.btn21.setImage(nil, forState: UIControlState.Normal)
                img21.image = nil
                img21.hidden = true
                img21.tag = 0
            }
            break
            
        case 33:
            if img22.tag == 0 {
                arrayNewLinked.addObject("22")
                self.btn22.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img22.image = UIImage(named: "33_y")
                img22.hidden = false
                img22.tag = 1
            }
            else {
                arrayNewLinked.removeObject("22")
                self.btn22.setImage(nil, forState: UIControlState.Normal)
                img22.image = nil
                img22.hidden = true
                img22.tag = 0
            }
            break
            
        case 32:
            if img23.tag == 0 {
                arrayNewLinked.addObject("23")
                self.btn23.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img23.image = UIImage(named: "32_y")
                img23.hidden = false
                img23.tag = 1
            }
            else {
                arrayNewLinked.removeObject("23")
                self.btn23.setImage(nil, forState: UIControlState.Normal)
                img23.image = nil
                img23.hidden = true
                img23.tag = 0
            }
            break
            
        case 31:
            if img24.tag == 0 {
                arrayNewLinked.addObject("24")
                self.btn24.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img24.image = UIImage(named: "31_y")
                img24.hidden = false
                img24.tag = 1
            }
            else {
                arrayNewLinked.removeObject("24")
                self.btn24.setImage(nil, forState: UIControlState.Normal)
                img24.image = nil
                img24.hidden = true
                img24.tag = 0
            }
            break
            
        case 41:
            if img25.tag == 0 {
                arrayNewLinked.addObject("25")
                self.btn25.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img25.image = UIImage(named: "41_y")
                img25.hidden = false
                img25.tag = 1
            }
            else {
                arrayNewLinked.removeObject("25")
                self.btn25.setImage(nil, forState: UIControlState.Normal)
                img25.image = nil
                img25.hidden = true
                img25.tag = 0
            }
            break
            
        case 42:
            if img26.tag == 0 {
                arrayNewLinked.addObject("26")
                self.btn26.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img26.image = UIImage(named: "42_y")
                img26.hidden = false
                img26.tag = 1
            }
            else {
                arrayNewLinked.removeObject("26")
                self.btn26.setImage(nil, forState: UIControlState.Normal)
                img26.image = nil
                img26.hidden = true
                img26.tag = 0
            }
            break
            
        case 43:
            if img27.tag == 0 {
                arrayNewLinked.addObject("27")
                self.btn27.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img27.image = UIImage(named: "43_y")
                img27.hidden = false
                img27.tag = 1
            }
            else {
                arrayNewLinked.removeObject("27")
                self.btn27.setImage(nil, forState: UIControlState.Normal)
                img27.image = nil
                img27.hidden = true
                img27.tag = 0
            }
            break
            
        case 44:
            if img28.tag == 0 {
                arrayNewLinked.addObject("28")
                self.btn28.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img28.image = UIImage(named: "44_y")
                img28.hidden = false
                img28.tag = 1
            }
            else {
                arrayNewLinked.removeObject("28")
                self.btn28.setImage(nil, forState: UIControlState.Normal)
                img28.image = nil
                img28.hidden = true
                img28.tag = 0
            }
            break
            
        case 45:
            if img29.tag == 0 {
                arrayNewLinked.addObject("29")
                self.btn29.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img29.image = UIImage(named: "45_y")
                img29.hidden = false
                img29.tag = 1
            }
            else {
                arrayNewLinked.removeObject("29")
                self.btn29.setImage(nil, forState: UIControlState.Normal)
                img29.image = nil
                img29.hidden = true
                img29.tag = 0
            }
            break
            
        case 46:
            if img30.tag == 0 {
                arrayNewLinked.addObject("30")
                self.btn30.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img30.image = UIImage(named: "46_y")
                img30.hidden = false
                img30.tag = 1
            }
            else {
                arrayNewLinked.removeObject("30")
                self.btn30.setImage(nil, forState: UIControlState.Normal)
                img30.image = nil
                img30.hidden = true
                img30.tag = 0
            }
            break
            
        case 47:
            if img31.tag == 0 {
                arrayNewLinked.addObject("31")
                self.btn31.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img31.image = UIImage(named: "47_y")
                img31.hidden = false
                img31.tag = 1
            }
            else {
                arrayNewLinked.removeObject("31")
                self.btn31.setImage(nil, forState: UIControlState.Normal)
                img31.image = nil
                img31.hidden = true
                img31.tag = 0
            }
            break
            
        case 48:
            if img32.tag == 0 {
                arrayNewLinked.addObject("32")
                self.btn32.setImage(UIImage(named: "YellowBtn"), forState: UIControlState.Normal)
                img32.image = UIImage(named: "48_y")
                img32.hidden = false
                img32.tag = 1
            }
            else {
                arrayNewLinked.removeObject("32")
                self.btn32.setImage(nil, forState: UIControlState.Normal)
                img32.image = nil
                img32.hidden = true
                img32.tag = 0
            }
            break
            
        default :
            print("Pass Teeth No")
        }
    }
    
    func clickButton(no : Int) {
        switch no {
        case 1 :
            self.Click_1(btn1)
        case 2 :
            self.Click_1(btn2)
        case 3 :
            self.Click_1(btn3)
        case 4 :
            self.Click_1(btn4)
        case 5 :
            self.Click_1(btn5)
        case 6 :
            self.Click_1(btn6)
        case 7 :
            self.Click_1(btn7)
        case 8 :
            self.Click_1(btn8)
        case 9 :
            self.Click_1(btn9)
        case 10 :
            self.Click_1(btn10)
        case 11 :
            self.Click_1(btn11)
        case 12 :
            self.Click_1(btn12)
        case 13 :
            self.Click_1(btn13)
        case 14 :
            self.Click_1(btn14)
        case 15 :
            self.Click_1(btn15)
        case 16 :
            self.Click_1(btn16)
        case 17 :
            self.Click_1(btn17)
        case 18 :
            self.Click_1(btn18)
        case 19 :
            self.Click_1(btn19)
        case 20 :
            self.Click_1(btn20)
        case 21 :
            self.Click_1(btn21)
        case 22 :
            self.Click_1(btn22)
        case 23 :
            self.Click_1(btn23)
        case 24 :
            self.Click_1(btn24)
        case 25 :
            self.Click_1(btn25)
        case 26 :
            self.Click_1(btn26)
        case 27 :
            self.Click_1(btn27)
        case 28 :
            self.Click_1(btn28)
        case 29 :
            self.Click_1(btn29)
        case 30 :
            self.Click_1(btn30)
        case 31 :
            self.Click_1(btn31)
        case 32 :
            self.Click_1(btn32)
        default :
            print("default called")
        }
        
    }
    
    func setTeethTag() {
        self.btn1.tag = 18
        self.btn2.tag = 17
        self.btn3.tag = 16
        self.btn4.tag = 15
        self.btn5.tag = 14
        self.btn6.tag = 13
        self.btn7.tag = 12
        self.btn8.tag = 11
        self.btn9.tag = 21
        self.btn10.tag = 22
        self.btn11.tag = 23
        self.btn12.tag = 24
        self.btn13.tag = 25
        self.btn14.tag = 26
        self.btn15.tag = 27
        self.btn16.tag = 28
        self.btn17.tag = 38
        self.btn18.tag = 37
        self.btn19.tag = 36
        self.btn20.tag = 35
        self.btn21.tag = 34
        self.btn22.tag = 33
        self.btn23.tag = 32
        self.btn24.tag = 31
        self.btn25.tag = 41
        self.btn26.tag = 42
        self.btn27.tag = 43
        self.btn28.tag = 44
        self.btn29.tag = 45
        self.btn30.tag = 46
        self.btn31.tag = 47
        self.btn32.tag = 48
    }
}
