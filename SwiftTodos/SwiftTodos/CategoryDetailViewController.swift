//
//  CategoryDetailViewController.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/22/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit

class CategoryDetailViewController: UIViewController {
    
    @IBOutlet weak var categoryField: UITextField!
    // TODO: Change this to a new data source that just does a passed in set or array of items.

    @IBOutlet var dataSource: TodoDataSource!
    
    var category: TodoCategory! {
        didSet {
            self.configureUI()
        }
    }
    
    func configureUI() {
        categoryField.text = category.name
        // TODO: Make the table display the category's tasks

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showtodoDetail" {
            let nextVC = segue.destinationViewController as! TodoDetailViewController
            let cell = sender as! EntityTableViewCell
            nextVC.todo = cell.entity as! Todo
        }
    }
}
