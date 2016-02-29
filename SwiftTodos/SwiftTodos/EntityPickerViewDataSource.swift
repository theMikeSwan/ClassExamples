//
//  EntityPickerViewDataSource.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/28/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit
import CoreData

/**
 Delegate protocol for EntityPickerViewDataSource.
*/
protocol EntityPickerViewDataSourceDelegate :NSObjectProtocol {
    /// Called when a row is selected in the picker view.
    /// - Parameter pickerView: The picker view that made the selection
    /// - Parameter entity: the NSManagedObject (or subclass) instance that was selected.
    func pickerView(pickerView: UIPickerView, didSelectEntity entity: NSManagedObject)
}

/**
 EntityPickerViewDataSource is a subclass of EntityDataSource for supplying entities to a picker view. This class does not add any methods that need to be subclassed over what is already required by EntityDataSource.
 */
class EntityPickerViewDataSource: EntityDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
    /// Instance that will be informed when a managed object is selected.
    weak var delegate: EntityPickerViewDataSourceDelegate?
    var pickerView: UIPickerView?
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        self.pickerView = pickerView
        return self.fetchedResultsController?.sections?.count ?? 0
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let controller = fetchedResultsController else { return 0 }
        let sectionInfo = controller.sections![component]
        return sectionInfo.numberOfObjects
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.pickerView(pickerView, didSelectEntity: fetchedResultsController!.objectAtIndexPath(NSIndexPath(forRow: row, inSection: component)) as! NSManagedObject)
    }
    
    /// convience method for determining the row index of a specified NSManagedObject.
    func rowOfEntity(entity: NSManagedObject) -> Int {
        return fetchedResultsController?.indexPathForObject(entity)?.row ?? 0
    }
    
    override func reloadDataView() {
        pickerView?.reloadAllComponents()
    }
}
