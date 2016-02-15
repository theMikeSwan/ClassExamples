//
//  DetailViewController.m
//  ToDos
//
//  Created by Mike Swan on 2/14/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIPickerView *priorityPicker;
@property (weak, nonatomic) IBOutlet UITextView *detailField;
@property (weak, nonatomic) IBOutlet UIButton *completedButton;
@property NSFetchedResultsController *resultsController;
@end

@implementation DetailViewController

// MARK: - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
    [self configureResultsController];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _toDo.detail = _detailField.text;
}

- (void) configureUI {
    _nameField.text = _toDo.name;
    _detailField.text = _toDo.detail;
    _completedButton.selected = _toDo.isComplete;
    [_priorityPicker selectRow:[_toDo.priority.index intValue] inComponent:0 animated:NO];
}

- (void) configureResultsController {
    // We get the entity name this way instead of entering a static string to ensure we haven't misspelled anything.
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName: NSStringFromClass([Priority class])];
    request.fetchBatchSize = 20;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES]];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[appDelegate managedObjectContext] sectionNameKeyPath:nil cacheName:@"Priorities"];
    _resultsController = controller;
    _resultsController.delegate = self;
    NSError *error = nil;
    [_resultsController performFetch:&error];
    if (error) NSLog(@"Error getting priorities: %@", [error localizedDescription]);
    else [_priorityPicker reloadAllComponents];
}

// MARK: - Actions
- (IBAction)updateName:(UITextField *)sender {
    _toDo.name = sender.text;
}

- (IBAction)toggleCompleted:(UIButton *)sender {
    sender.selected = !sender.selected;
    _toDo.isComplete = @(sender.selected);
}

// MARK: - UIPickerView data source and delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    id<NSFetchedResultsSectionInfo> sectionInfo = _resultsController.sections[0];
    return sectionInfo.numberOfObjects;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    Priority *priority = [_resultsController objectAtIndexPath:[NSIndexPath indexPathForItem:row inSection:0]];
    return priority.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _toDo.priority = [_resultsController objectAtIndexPath:[NSIndexPath indexPathForItem:row inSection:0]];
}

// MARK: - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

// MARK: - Keyboard handlers

@end
