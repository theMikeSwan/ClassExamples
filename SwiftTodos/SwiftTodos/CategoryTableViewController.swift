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
    @IBOutlet weak var editButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        dataSource.managedObjectContext = appDelegate.managedObjectContext

        let editButton = self.editButtonItem()
        let addButton = self.navigationItem.rightBarButtonItems?.first
        self.navigationItem.rightBarButtonItems = [addButton!, editButton]
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
        if segue.identifier == SegueID.showCategoryDetail.rawValue {
            let nextVC = segue.destinationViewController as! CategoryDetailViewController
            let cell = sender as! EntityTableViewCell
            nextVC.category = cell.entity as! TodoCategory
        }
    }

}
