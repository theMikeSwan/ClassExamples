//
//  ToDo+CoreDataProperties.m
//  ToDos
//
//  Created by Mike Swan on 2/14/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDo+CoreDataProperties.h"

@implementation ToDo (CoreDataProperties)

@dynamic name;
@dynamic isComplete;
@dynamic detail;
@dynamic priority;

@end
