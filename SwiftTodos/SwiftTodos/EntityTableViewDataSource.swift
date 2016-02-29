//
//  EntityTableViewDataSource.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/28/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit
import CoreData

class EntityTableViewDataSource: EntityDataSource, UITableViewDataSource {
    @IBOutlet var tableView: UITableView?
    
    override func reloadDataView() {
        tableView?.reloadData()
    }
    
    // MARK: - TableView DataSource and Delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController?.sections?.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard fetchedResultsController != nil else { return 0 }
        let sectionInfo = self.fetchedResultsController!.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIDForIndexPath(indexPath), forIndexPath: indexPath)
        self.configureCell(cell, atIndex: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, atIndex indexPath: NSIndexPath) {
        let theCell = cell as! EntityTableViewCell
        theCell.entity = self.fetchedResultsController!.objectAtIndexPath(indexPath) as! NSManagedObject
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        guard managedObjectContext != nil else { return }
        if editingStyle == .Delete {
            managedObjectContext!.deleteObject(fetchedResultsController!.objectAtIndexPath(indexPath) as! NSManagedObject)
            managedObjectContext!.processPendingChanges()
        } else if editingStyle == .Insert {
            self.addItem()
        }
    }
    
    // MARK: - FetchedResultsControllerDelegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView?.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        guard tableView != nil else { return }
        switch type {
        case .Insert:
            tableView!.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView!.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            self.configureCell(tableView!.cellForRowAtIndexPath(indexPath!)!, atIndex: indexPath!)
        case .Move:
            tableView!.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            tableView!.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView?.endUpdates()
    }
}
