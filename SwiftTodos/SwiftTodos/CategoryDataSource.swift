//
//  CategoryDataSource.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/22/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit
import CoreData

class CategoryDataSource: NSObject, EntityTableViewDataSourceProtocol {
    func entityName() -> String {
        return "TodoCategory"
    }
    
    func sortDescriptors() -> [NSSortDescriptor] {
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        return [nameSortDescriptor]
    }
    
    
    var managedObjectContext: NSManagedObjectContext?
    var fetchedResultsController: NSFetchedResultsController?
    var fetchPredicate: NSPredicate?
}
