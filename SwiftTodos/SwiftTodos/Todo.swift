//
//  Todo.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/22/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import Foundation
import CoreData

enum TodoPriority: Int64 {
    case Low = 0
    case Meduim
    case High
}

class Todo: NSManagedObject {
    /// Property to make the priority level a bit more clear than a number
    var priority: TodoPriority {
        get {
            return TodoPriority(rawValue: self.priorityIndex)!
        }
        set {
            self.priorityIndex = newValue.rawValue
        }
    }
}
