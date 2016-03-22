//
//  JobListTableCell.swift
//  DentalDsign
//
//  Created by Nimble Chapps on 25/02/16.
//  Copyright © 2016 Nimble Chapps. All rights reserved.
//

import UIKit

class JobListTableCell: UITableViewCell {

    @IBOutlet weak var toothImg: UIImageView!
    
    @IBOutlet weak var lblToothNo: UILabel!
    @IBOutlet weak var lblToothName: UILabel!
    @IBOutlet weak var lblNoOfJob: UILabel! {
        didSet{
            if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad{
                lblNoOfJob.layer.cornerRadius = 21.0
            }else{
                lblNoOfJob.layer.cornerRadius = 20.0
            }
            lblNoOfJob.layer.masksToBounds = true
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
