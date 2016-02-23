//
//  TodoTableViewController.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/22/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController {

    @IBOutlet var dataSource: TodoDataSource!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        dataSource.managedObjectContext = appDelegate.managedObjectContext

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addItem(sender: AnyObject) {
        dataSource.addItem()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showtodoDetail" {
            let nextVC = segue.destinationViewController as! TodoDetailViewController
            let cell = sender as! EntityTableViewCell
            nextVC.todo = cell.entity as! Todo
        }
    }
}
