//
//  CategoryPickerViewDataSource.swift
//  SwiftTodos
//
//  Created by Mike Swan on 2/28/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

import UIKit

class CategoryPickerViewDataSource: EntityPickerViewDataSource {
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let controller = fetchedResultsController else { return nil }
        let item = controller.objectAtIndexPath(NSIndexPath(forRow: row, inSection: component)) as! TodoCategory
        return item.name
    }
    
    override func entityName() -> String {
        return "TodoCategory"
    }
    
    override func sortDescriptors() -> [NSSortDescriptor] {
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        return [nameSortDescriptor]
    }
}
