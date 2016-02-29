//
//  CategoryDataSource.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/22/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit
import CoreData

class CategoryDataSource: EntityTableViewDataSource {
    override func entityName() -> String {
        return "TodoCategory"
    }
    
    override func sortDescriptors() -> [NSSortDescriptor] {
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        return [nameSortDescriptor]
    }
}
