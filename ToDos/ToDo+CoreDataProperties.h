//
//  ToDo+CoreDataProperties.h
//  ToDos
//
//  Created by Mike Swan on 2/14/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDo.h"
#import "Priority.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *isComplete;
@property (nullable, nonatomic, retain) NSString *detail;
@property (nullable, nonatomic, retain) Priority *priority;

@end

NS_ASSUME_NONNULL_END
