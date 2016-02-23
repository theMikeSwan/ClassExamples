//
//  TodoTableViewCell.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/22/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit

class TodoTableViewCell: EntityTableViewCell {

    @IBOutlet weak var priorityView: UIView!
    @IBOutlet weak var taskField: UILabel!
    @IBOutlet weak var completedButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureUI() {
        guard entity != nil else { return }
        let task = entity as! Todo
        taskField.text = task.task
        completedButton.selected = task.completed
        // TODO: set the proper gradient for the priority

    }

    @IBAction func toggleCompleted(sender: UIButton) {
        sender.selected = !sender.selected
        let task = entity as! Todo
        task.completed = sender.selected
    }
}
