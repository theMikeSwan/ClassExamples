//
//  EntityDataSource.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/28/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit
import CoreData

/**
 EntityDataSource is the root class for simplifying the display of Core Data entities in data views (such as table views and collection views).
 This class handles the common feteched results tasks while the subclasses; EntityTableViewDataSource, EntityCollectionViewDataSource, and EntityPickerViewDataSource; handle the specifics for table, collection, and picker views.
 
 Usage:
 In order to use this class you need to provide an implementation of sortDescriptors() and entityName(). For more details see the documentation for each of those functions.
 */
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
    /// Specifies the reuse ID for cells. The default value is "managedObjectCell".
    func cellReuseIDForIndexPath(indexPath: NSIndexPath) -> String {
        return "managedObjectCell"
    }
    /// Specifies the batch size that should be used. The default is 20.
    func fetchBatchSize() -> Int {
        return 20
    }
    
    /// Adds an entity of the type specified by entityName()
    func addItem() {
        guard managedObjectContext != nil else { return }
        _ = NSEntityDescription.insertNewObjectForEntityForName(self.entityName(), inManagedObjectContext:managedObjectContext!)
        managedObjectContext!.processPendingChanges()
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
}
