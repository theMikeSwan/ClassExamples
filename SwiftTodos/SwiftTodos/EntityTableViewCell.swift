//
//  EntityTableViewCell.swift
//  
//
//  Created by Mike Swan on 2/22/16.
//
//

import UIKit
import CoreData

/**
 EntityTableViewCell is an abstract class designed to be used with a subclass of EntityTableViewDataSource. It has a single property for storing the assigned managed object.
 Subclasses of EntityTableViewCell must override configureUI() without calling super. With in configureUI() it will be necessary to cast the managed object to the specific class of the entity tha is to be displayed.
*/
class EntityTableViewCell: UITableViewCell {
    /// The managed object that should be displayed
    var entity: NSManagedObject! {
        didSet {
            if entity != nil {
                self.configureUI()
            }
        }
    }
    
    /// Subclasses must implement this method to properly configure the UI of the cell when a new entity is assigned.
    func configureUI() {
        fatalError("Subclasses must impelemnt configureUI to properly set up the cell when a new entity is set!!")
    }
}
