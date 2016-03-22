//
//  JobListVC.swift
//  DentalDsign
//
//  Created by Nimble Chapps on 29/01/16.
//  Copyright © 2016 Nimble Chapps. All rights reserved.
//

import UIKit
class JobListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let upperToothNO : [Int] = [11,12,13,14,15,16,17,18,21,22,23,24,25,26,27,28]
    let lowerToothNo : [Int] = [31,32,33,34,35,36,37,38,41,42,43,44,45,46,47,48]
    let toothNamesUpper = ["Right Third Molar","Right Second Molar","Right First Molar","Right Second Bicuspid","Right First Bicuspid","Right Canine","Right Lateral Incisor","Right Central Incisor","Left Central Incisor","Left Lateral Incisor","Left Canine","Left First Bicuspid","Left Second Bicuspid","Left First Molar","Left Second Molar","Left Third Molar"]
    let toothNamesLower = ["Left  Central Incisor","Left Lateral Incisor","Left Canine","Left First Bicuspid","Left Second Bicuspid","Left First Molar","Left Second Molar","Left Third Molar","Right Central Incisor","Right Lateral Incisor","Right Canine","Right First Bicuspid","Right Second Bicuspid","Right First Molar","Right Second Molar","Right Third Molar"]
    
    let token = NSUserDefaults.standardUserDefaults().objectForKey("TOKEN") as? String
    let userDetails = NSUserDefaults.standardUserDefaults().objectForKey("UserData")
    
    var allTethData = NSDictionary()
    var TeethData = NSMutableArray()
    var jobListUpper = [Int](count: 16, repeatedValue: 0)
    var jobListLower = [Int](count: 16, repeatedValue: 0)
    var onlyJobUpper = [Int]()
    var onlyJobLower = [Int]()
    
    
    @IBOutlet weak var upperLoverSegment: UISegmentedControl!
    @IBOutlet weak var jobOnlySwt: UISwitch!
    @IBOutlet weak var jobListTableView: UITableView!
    @IBOutlet weak var upperView: UIView! {
        didSet{
            upperView.layer.cornerRadius = 5.0
        }
    }
    @IBOutlet weak var lowerView: UIView!{
        didSet{
            lowerView.layer.cornerRadius = 5.0
        }
    }
    @IBOutlet weak var btnHelp: UIButton! {
        didSet{
            btnHelp.layer.cornerRadius = 5.0
        }
    }
    
    
    var isUpper = true
    var isJobOnly = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upperLoverSegment.selectedSegmentIndex = 0
        jobOnlySwt.on = false
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        teethJobList(token!, userId: userDetails?.objectForKey("iUserID") as! String)
        self.materiaList("dental!123")
        self.jobType("dental!123")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isJobOnly) {
            if isUpper {
                onlyJobUpper.removeAll()
                for i in 0...jobListUpper.count-1 {
                    if jobListUpper[i] > 0 {
                        onlyJobUpper.append(i)
                    }
                }
                return onlyJobUpper.count
            }
            onlyJobLower.removeAll()
            for i in 0...jobListLower.count-1 {
                if jobListLower[i] > 0 {
                    onlyJobLower.append(i)
                }
            }
            return onlyJobLower.count
        }
        return 16
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : JobListTableCell = tableView.dequeueReusableCellWithIdentifier("JobListCell", forIndexPath: indexPath) as! JobListTableCell
        if isJobOnly == false{
            if (isUpper) {
                cell.toothImg.image = UIImage(named: "\(indexPath.row + 1)")
                cell.lblToothNo.text = "\(upperToothNO[indexPath.row])"
                cell.lblToothName.text = toothNamesUpper[indexPath.row]
                cell.lblNoOfJob.text = "\(jobListUpper[indexPath.row])"
            }
            else {
                cell.toothImg.image = UIImage(named: "\(indexPath.row + 17)")
                cell.lblToothNo.text = "\(lowerToothNo[indexPath.row])"
                cell.lblToothName.text = toothNamesLower[indexPath.row]
                cell.lblNoOfJob.text = "\(jobListLower[indexPath.row])"
            }
        }
        else {
            if (isUpper) {
                cell.toothImg.image = UIImage(named: "\(onlyJobUpper[indexPath.row] + 1)")
                cell.lblToothNo.text = "\(upperToothNO[(onlyJobUpper[indexPath.row]))"
                cell.lblToothName.text = toothNamesUpper[(onlyJobUpper[indexPath.row])]
                cell.lblNoOfJob.text = "\(jobListUpper[(onlyJobUpper[indexPath.row])])"
            }
            else {
                cell.toothImg.image = UIImage(named: "\(onlyJobLower[indexPath.row] + 17)")
                cell.lblToothNo.text = "\(lowerToothNo[onlyJobLower[indexPath.row])"
                cell.lblToothName.text = toothNamesLower[onlyJobLower[indexPath.row]]
                cell.lblNoOfJob.text = "\(jobListLower[onlyJobLower[indexPath.row]])"
            }
        }
        
        switch cell.lblNoOfJob.text! {
        case "0" :
            cell.lblNoOfJob.backgroundColor = UIColor(red: 37.0/255.0, green: 217.0/255.0, blue: 202.0/255.0, alpha: 1)
        case "1","2" :
            cell.lblNoOfJob.backgroundColor =  UIColor(red: 254.0/255.0, green: 194.0/255.0, blue: 44.0/255.0, alpha: 1)
        default :
            cell.lblNoOfJob.backgroundColor = UIColor(red: 240.0/255.0, green: 103.0/255.0, blue: 103.0/255.0, alpha: 1)
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView : UIView = UIView(frame: CGRectMake(0,0,tableView.frame.size.width,15))
        
        let selectToothlbl : UILabel = UILabel(frame: CGRectMake((headerView.frame.size.width / 4), 7, 65, 15))
        selectToothlbl.font = UIFont(name:"AvenirNextCondensed-DemiBold", size: 14)
        selectToothlbl.textColor = UIColor.darkGrayColor()
        selectToothlbl.text = "Select Tooth"
        
        let NoOfJobLbl : UILabel = UILabel(frame: CGRectMake((headerView.frame.size.width - 68), 7, 60, 15))
        NoOfJobLbl.font = UIFont(name:"AvenirNextCondensed-DemiBold", size: 14)
        NoOfJobLbl.textColor = UIColor.darkGrayColor()
        NoOfJobLbl.text = "No. of Jobs"
        
        headerView.layer.cornerRadius = 5.0
        headerView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        headerView.addSubview(selectToothlbl)
        headerView.addSubview(NoOfJobLbl)
        return headerView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell : JobListTableCell = self.jobListTableView.cellForRowAtIndexPath(indexPath) as! JobListTableCell
        self.performSegueWithIdentifier("JobSelectorSegue", sender: cell.lblToothNo.text)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "JobSelectorSegue") {
            let destination = segue.destinationViewController as! JobSelectorVC
            destination.index = sender as! String
            destination.teethData = TeethData
        }
    }
    
    @IBAction func upperLowerSegmentTapped(sender: AnyObject) {
        if (upperLoverSegment.selectedSegmentIndex == 0) {
            isUpper = true
        }
        else {
            isUpper = false
        }
        self.jobListTableView.reloadData()
    }
    @IBAction func jobOnlySwtTapped(sender: AnyObject) {
        isJobOnly = jobOnlySwt.on
        self.jobListTableView.reloadData()
    }
    
    //MARK:- WebServices call
    
    func teethJobList(accessToken : String , userId : String) -> Void {
        let parameterDic : [String : AnyObject] = [kUserAPIKey : accessToken , kUserID : userId]
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        WebServies.makeGet("job/joblist", parameter: parameterDic) { (json, error) -> () in
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            if error == nil {
                if json.objectForKey("status") as! String == "200" || json.objectForKey("status") as! String == "201" {
                    
                    self.allTethData = json.objectForKey("data") as! NSDictionary
                    
                    for i in 0...15 {
                        self.jobListUpper[teethIndex(i+1)-1] = (self.allTethData["\(i+1)"])!.count
                        self.jobListLower[teethIndex(i+1)-1] = (self.allTethData["\(i+16)"])!.count
                    }
                    
                    self.TeethData.removeAllObjects()
                    for i in 1...32 {
                        self.TeethData.addObject(self.allTethData["\(i)"]!)
                    }
                    
                    self.jobListTableView.reloadData()
                }
                else {
                    let alertView = UIAlertController(title: kAppName, message: json.objectForKey("msg") as? String, preferredStyle: UIAlertControllerStyle.Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertView.addAction(defaultAction)
                    self.presentViewController(alertView, animated: true, completion: nil)
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
    
    func jobType(accessToken : String) -> Void {
        let parameterDic : [String : AnyObject] = [kUserAPIKey : accessToken]
        
        WebServies.makeGet("jobtype/getalljobtypes", parameter: parameterDic) { (json, error) -> () in
            if error == nil {
                
                if json.objectForKey("status") as! String == "400" {
                    let alertView = UIAlertController(title: kAppName, message: json.objectForKey("msg") as? String, preferredStyle: UIAlertControllerStyle.Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertView.addAction(defaultAction)
                    self.presentViewController(alertView, animated: true, completion: nil)
                }
                else {
                    let userDict = json.objectForKey("data")!
                    NSUserDefaults.standardUserDefaults().setObject(userDict, forKey: "JobList")
                    NSUserDefaults.standardUserDefaults().synchronize()
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
    
    func materiaList(accessToken : String) -> Void{
        
        let parameterDic : [String : AnyObject] = [kUserAPIKey : accessToken]
        WebServies.makeGet("material/getallmaterial", parameter: parameterDic) { (json, error) -> () in
            if error == nil {
                if json.objectForKey("status") as! String == "400"{
                    let alertView = UIAlertController(title: kAppName, message: json.objectForKey("msg") as? String, preferredStyle: UIAlertControllerStyle.Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertView.addAction(defaultAction)
                    self.presentViewController(alertView, animated: true, completion: nil)
                    
                }else{
                    let userDict = json.objectForKey("data")!
                    NSUserDefaults.standardUserDefaults().setObject(userDict, forKey: "MateriaList")
                    NSUserDefaults.standardUserDefaults().synchronize()
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
}
