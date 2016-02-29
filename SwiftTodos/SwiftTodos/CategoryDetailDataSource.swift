//
//  CategoryDetailDataSource.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/28/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit
import CoreData

class CategoryDetailDataSource: NSObject, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var tasks: [Todo]? {
        didSet {
            if tasks != nil {
                tableView?.reloadData()
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tasks = tasks else { return 0 }
        return tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("managedObjectCell", forIndexPath: indexPath)
        self.configureCell(cell, atIndex: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, atIndex indexPath: NSIndexPath) {
        let theCell = cell as! EntityTableViewCell
        theCell.entity = tasks![indexPath.row]
    }
}
