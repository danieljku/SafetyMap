//
//  CrimeDataViewCell.swift
//  SafetyMap
//
//  Created by Daniel Ku on 7/8/16.
//  Copyright © 2016 djku. All rights reserved.
//

import Foundation
import UIKit

class CrimeDataViewCell: UITableViewCell{
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var dateAndTimeLabel: UILabel!    
    @IBOutlet weak var timeLabel: UILabel!
}