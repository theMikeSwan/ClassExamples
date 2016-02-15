//
//  Priority+CoreDataProperties.h
//  ToDos
//
//  Created by Mike Swan on 2/14/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Priority.h"

NS_ASSUME_NONNULL_BEGIN

@interface Priority (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *index;
@property (nullable, nonatomic, retain) NSSet<ToDo *> *todos;

@end

@interface Priority (CoreDataGeneratedAccessors)

- (void)addTodosObject:(ToDo *)value;
- (void)removeTodosObject:(ToDo *)value;
- (void)addTodos:(NSSet<ToDo *> *)values;
- (void)removeTodos:(NSSet<ToDo *> *)values;

@end

NS_ASSUME_NONNULL_END
