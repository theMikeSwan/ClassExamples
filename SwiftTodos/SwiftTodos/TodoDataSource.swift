//
//  TodoDataSource.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/22/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit
import CoreData

class TodoDataSource: EntityTableViewDataSource {
    
    override func entityName() -> String {
        return "Todo"
    }
    
    override func sortDescriptors() -> [NSSortDescriptor] {
        let prioritySortDescriptor = NSSortDescriptor(key: "priorityIndex", ascending: true)
        let nameSortDescriptor = NSSortDescriptor(key: "task", ascending: true)
        return [prioritySortDescriptor, nameSortDescriptor]
    }

}
