//
//  CategoryTableViewCell.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/22/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit

class CategoryTableViewCell: EntityTableViewCell {

    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var taskCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func configureUI() {
        guard entity != nil else { return }
        let cat = entity as! TodoCategory
        categoryName.text = cat.name
        var total = cat.todos?.count
        if total == nil { total = 0 }
        taskCount.text = "\(total) tasks"
    }

}
