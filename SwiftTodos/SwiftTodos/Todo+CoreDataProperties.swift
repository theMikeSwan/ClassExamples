//
//  Todo+CoreDataProperties.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/22/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Todo {

    @NSManaged var task: String?
    @NSManaged var details: String?
    @NSManaged var completed: Bool
    @NSManaged var priorityIndex: Int64
    @NSManaged var category: NSManagedObject?

}
