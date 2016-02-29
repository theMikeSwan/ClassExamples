//
//  EntityPickerViewDataSource.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/28/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit
import CoreData

protocol EntityPickerViewDataSourceDelegate :NSObjectProtocol {
    func pickerView(pickerView: UIPickerView, didSelectEntity entity: NSManagedObject)
}

class EntityPickerViewDataSource: EntityDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
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
    
    func rowOfEntity(entity: NSManagedObject) -> Int {
        return fetchedResultsController?.indexPathForObject(entity)?.row ?? 0
    }
    
    override func reloadDataView() {
        pickerView?.reloadAllComponents()
    }
}
