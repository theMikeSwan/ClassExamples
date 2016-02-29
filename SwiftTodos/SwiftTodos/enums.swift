//
//  enums.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/28/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit
import QuartzCore

enum SegueID: String {
    case showTodoDetail
    case showCategoryDetail
}

struct TodoPriorityColor {
    static let low = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0)
    static let medium = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
    static let high = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
}