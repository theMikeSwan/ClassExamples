//
//  ToDoTableViewCell.m
//  ToDos
//
//  Created by Mike Swan on 2/14/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

#import "ToDoTableViewCell.h"

@interface ToDoTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *priorityView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *completedButton;


@end
@implementation ToDoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void) configureUI {
    _nameLabel.text = _toDo.name;
    _completedButton.selected = _toDo.isComplete;
}

- (IBAction)toggleCompleted:(UIButton *)sender {
    sender.selected = !sender.selected;
    _toDo.isComplete = @(sender.selected);
}

@end
