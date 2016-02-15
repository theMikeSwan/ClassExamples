//
//  EntityTableViewController.m
//  ToDos
//
//  Created by Mike Swan on 2/14/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

#import "EntityTableViewController.h"
#import <CoreData/CoreData.h>

@interface EntityTableViewController () <NSFetchedResultsControllerDelegate>
@property NSFetchedResultsController *resultsController;
@end

@implementation EntityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initiateFetchRequest];
    
}
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

/*! Subclasses must override this method to provide the correct entity. */
- (NSString *) entityName {
    return @"";
}

/*! Subclasses must override this method to provide the correct sort descriptor for the entity. */
- (NSArray *) sortDescriptors {
    return @[[[NSSortDescriptor alloc] init]];
}

/*! Creates the fetch request and sets up the fetched results controller. */
- (void) initiateFetchRequest {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName: [self entityName]];
    request.fetchBatchSize = 20;
    request.sortDescriptors = [self sortDescriptors];
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:_managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    _resultsController = controller;
    _resultsController.delegate = self;
    NSError *error = nil;
    [_resultsController performFetch:&error];
    if (error) NSLog(@"Error fetching %@ entities: %@", [self entityName], [error localizedDescription]);
    else [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_resultsController sections].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = _resultsController.sections[section];
    return sectionInfo.numberOfObjects;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

/*! Subclasses must override this method to properly configure the cell for the correct entity type. */
- (void) configureCell:(UITableViewCell *)cell atIndexPath: (NSIndexPath *)indexPath {
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
