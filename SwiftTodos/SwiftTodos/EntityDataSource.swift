//
//  EntityDataSource.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/28/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit
import CoreData

class EntityDataSource: NSObject, NSFetchedResultsControllerDelegate {
    var managedObjectContext: NSManagedObjectContext? {
        didSet {
            if managedObjectContext != nil {
                self.initiateFetchRequest()
            }
        }
    }
    var fetchedResultsController: NSFetchedResultsController?
    /// Set the predicate that should be used by the fetchedResultsController. It should be set before setting the managedObjectContext. The default is nil.
    var fetchPredicate: NSPredicate?
    
    /// Returns an array of sort decriptors to be used on the fetch results.
    func sortDescriptors() -> [NSSortDescriptor] {
        fatalError("Subclasses must implement sortDescriptors!!")
    }
    /// Returns the name of the entity to be fetched.
    func entityName() -> String {
        fatalError("Subclasses must implement entityName!!")
    }
    
    /// Called if the fetch request is successful so that the data view can be refreshed with the new data.
    func reloadDataView() {
        print("**WARNING** Subclasses need to implement reloadDataView in order for data to be displayed.")
    }
    
    func cellReuseIDForIndexPath(indexPath: NSIndexPath) -> String {
        return "managedObjectCell"
    }
    
    func fetchBatchSize() -> Int {
        return 20
    }
    
    func initiateFetchRequest() {
        guard managedObjectContext != nil else { return }
        let request = NSFetchRequest()
        let entity = NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: self.managedObjectContext!)
        request.entity = entity
        request.fetchBatchSize = self.fetchBatchSize()
        request.sortDescriptors = self.sortDescriptors()
        if fetchPredicate != nil { request.predicate = fetchPredicate }
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController = controller
        fetchedResultsController!.delegate = self
        do {
            try fetchedResultsController!.performFetch()
            self.reloadDataView()
        } catch {
            NSLog("Error fetching \(self.entityName()) entities: \(error)")
        }
    }
    
    func addItem() {
        guard managedObjectContext != nil else { print("dataSource moc was nil while adding item"); return }
        _ = NSEntityDescription.insertNewObjectForEntityForName(self.entityName(), inManagedObjectContext:managedObjectContext!)
        managedObjectContext!.processPendingChanges()
    }

}
