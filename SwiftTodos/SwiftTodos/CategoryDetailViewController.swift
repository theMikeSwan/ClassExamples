//
//  CategoryDetailViewController.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/22/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit

class CategoryDetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet var dataSource: CategoryDetailDataSource!
    @IBOutlet var deleteButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var category: TodoCategory! {
        didSet {
            self.configureUI()
            dataSource.tasks = category.todos?.allObjects as? [Todo]
        }
    }
    
    func configureUI() {
        guard categoryField != nil && category != nil else { return }
        categoryField.text = category.name
        tableView.reloadData()

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    @IBAction func changeName(sender: UITextField) {
            guard category != nil else { return }
            category.name = sender.text
    }
    
    @IBAction func deleteCategory(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Delete This Category?", message: "Are you sure you want to delete this category? All tasks in this category will be deleted as well!!", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .Destructive, handler: { (_) -> Void in
            self.category.managedObjectContext?.deleteObject(self.category)
            self.navigationController?.popViewControllerAnimated(true)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = deleteButton
        configureUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        guard category != nil else { return }
        dataSource.tasks = category.todos?.allObjects as? [Todo]
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        categoryField.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueID.showTodoDetail.rawValue {
            let nextVC = segue.destinationViewController as! TodoDetailViewController
            let cell = sender as! EntityTableViewCell
            nextVC.todo = (cell.entity as! Todo)
        }
    }
}
