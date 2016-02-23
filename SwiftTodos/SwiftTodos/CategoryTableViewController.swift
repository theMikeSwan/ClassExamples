//
//  CategoryTableViewController.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/22/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    @IBOutlet var dataSource: CategoryDataSource!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        dataSource.managedObjectContext = appDelegate.managedObjectContext

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    @IBAction func addItem(sender: AnyObject) {
        dataSource.addItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCategoryDetail" {
            let nextVC = segue.destinationViewController as! CategoryDetailViewController
            let cell = sender as! EntityTableViewCell
            nextVC.category = cell.entity as! TodoCategory
        }
    }

}
