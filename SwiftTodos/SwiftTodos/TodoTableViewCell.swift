//
//  TodoTableViewCell.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/22/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit

class TodoTableViewCell: EntityTableViewCell {

    @IBOutlet weak private var priorityView: UIView!
    @IBOutlet weak private var taskField: UILabel!
    @IBOutlet weak private var completedButton: UIButton!
    let gradient = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        priorityView.layer.addSublayer(gradient)
    }

    override func configureUI() {
        guard entity != nil else { return }
        let task = entity as! Todo
        taskField.text = task.task
        completedButton.selected = task.completed
        addGradient()
    }
    
    func addGradient() {
        let task = entity as! Todo
        gradient.frame = priorityView.bounds
        var color2 = UIColor.clearColor()
        switch task.priority {
        case .Low:
            color2 = TodoPriorityColor.low
        case .Meduim:
            color2 = TodoPriorityColor.medium
        case .High:
            color2 = TodoPriorityColor.high
        }
        gradient.colors = [color2.CGColor, UIColor.whiteColor().CGColor]
        
    }

    @IBAction func toggleCompleted(sender: UIButton) {
        sender.selected = !sender.selected
        let task = entity as! Todo
        task.completed = sender.selected
    }
}
