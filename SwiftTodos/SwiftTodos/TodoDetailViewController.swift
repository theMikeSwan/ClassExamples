//
//  TodoDetailViewController.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/22/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit

class TodoDetailViewController: UIViewController {

    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var details: UITextView!
    @IBOutlet weak var todoCategory: UIPickerView!
    @IBOutlet weak var prioritySegmentControl: UISegmentedControl!
    @IBOutlet weak var completedButton: UIButton!
    
    var todo: Todo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskName.text = todo.task
        details.text = todo.details
        completedButton.selected = todo.completed
        prioritySegmentControl.selectedSegmentIndex = Int(todo.priorityIndex)
        // TODO: set the picker to the right view

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func changePriority(sender: AnyObject) {
        todo.priorityIndex = Int64(sender.selectedIndex)
    }
    @IBAction func toggleCompleted(sender: UIButton) {
        sender.selected = !sender.selected
        todo.completed = sender.selected
    }
}
