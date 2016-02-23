//
//  TodoDataSource.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/22/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit
import CoreData

class TodoDataSource: NSObject, EntityTableViewDataSourceProtocol {
    
    func entityName() -> String {
        return "Todo"
    }
    
    func sortDescriptors() -> [NSSortDescriptor] {
        let prioritySortDescriptor = NSSortDescriptor(key: "priorityIndex", ascending: true)
        let nameSortDescriptor = NSSortDescriptor(key: "task", ascending: true)
        return [prioritySortDescriptor, nameSortDescriptor]
    }
    
    
    var managedObjectContext: NSManagedObjectContext?
    var fetchedResultsController: NSFetchedResultsController?
    var fetchPredicate: NSPredicate?
}
