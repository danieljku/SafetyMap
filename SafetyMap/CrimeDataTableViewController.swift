//
//  CrimeDataTableViewController.swift
//  SafetyMap
//
//  Created by Daniel Ku on 7/8/16.
//  Copyright © 2016 djku. All rights reserved.
//

import UIKit

class CrimeDataTableViewController: UITableViewController {
    var crimeDataList: [CrimeData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crimeDataList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("crimeDataViewCell", forIndexPath: indexPath) as! CrimeDataViewCell
                
        let row = indexPath.row
        let crime = crimeDataList[row]
        cell.categoryLabel.text = crime.category
        cell.descriptionTextView.text = crime.descript
        cell.addressTextView.text = crime.address
        cell.dateAndTimeLabel.text = crime.date.stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
        cell.timeLabel.text = crime.time
        
        return cell
    }
    
    /*

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {


    }*/

}
