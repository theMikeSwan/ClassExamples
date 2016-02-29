//
//  TodoDetailViewController.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/22/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit
import CoreData

class TodoDetailViewController: UIViewController, EntityPickerViewDataSourceDelegate, UITextFieldDelegate, UITextViewDelegate {
    // TODO: Save changes to notes when leaving the screen!!


    @IBOutlet weak private var taskName: UITextField!
    @IBOutlet weak private var details: UITextView!
    @IBOutlet weak private var todoCategory: UIPickerView!
    @IBOutlet weak private var prioritySegmentControl: UISegmentedControl!
    @IBOutlet weak private var completedButton: UIButton!
    @IBOutlet private var deleteButton: UIBarButtonItem!
    @IBOutlet private var dataSource: CategoryPickerViewDataSource!
    
    var todo: Todo? {
        didSet {
            configureUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.delegate = self
        dataSource.managedObjectContext = todo?.managedObjectContext
        self.navigationItem.rightBarButtonItem = deleteButton
        configureUI()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        taskName.endEditing(true)
        details.endEditing(true)
    }
    
    func configureUI() {
        guard let todo = todo else { return }
        guard taskName != nil else { return }
        taskName.text = todo.task
        details.text = todo.details
        completedButton.selected = todo.completed
        prioritySegmentControl.selectedSegmentIndex = Int(todo.priorityIndex)
        todoCategory.reloadAllComponents()
        var row = 0
        if todo.category != nil { row = dataSource.rowOfEntity(todo.category!) }
        todoCategory.selectRow(row, inComponent: 0, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pickerView(pickerView: UIPickerView, didSelectEntity entity: NSManagedObject) {
        todo?.category = entity as! TodoCategory
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textViewDidChange(textView: UITextView) {
        guard todo != nil else { return }
        todo!.details = textView.text
    }
    
    @IBAction func deleteTask(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Delete This Task?", message: "Are you sure you want to delete this task?", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .Destructive, handler: { (_) -> Void in
            self.todo!.managedObjectContext?.deleteObject(self.todo!)
            self.navigationController?.popViewControllerAnimated(true)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func changeName(sender: UITextField) {
        guard todo != nil else { return }
        todo!.task = sender.text
    }
    
    @IBAction func changePriority(sender: UISegmentedControl) {
        todo?.priorityIndex = Int64(sender.selectedSegmentIndex)
    }
    
    @IBAction func toggleCompleted(sender: UIButton) {
        sender.selected = !sender.selected
        todo?.completed = sender.selected
    }
}
