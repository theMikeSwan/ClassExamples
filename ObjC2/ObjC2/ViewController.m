//
//  ViewController.m
//  ObjC2
//
//  Created by Mike Swan on 11/14/15.
//  Copyright © 2015 theMikeSwan. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tweetTextField;
@property (weak, nonatomic) IBOutlet UITextView *facebookTextField;
@property (weak, nonatomic) IBOutlet UITextView *moreTextField;

@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

- (void) configureUI {
    NSArray *layers = @[self.tweetTextField.layer, self.facebookTextField.layer, self.moreTextField.layer];
    for (CALayer *layer in layers) {
        layer.cornerRadius = 10.0;
        layer.borderWidth = 2.0;
        layer.borderColor = [[UIColor blackColor] CGColor];
    }
}

// We wouldn't do this in a real app, we would let the system take care of it to get the Settings button that would lead the user to the right place to login.
- (void) notLoggedInto:(NSString *) service {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"You're not logged in!" message:[NSString stringWithFormat: @"You can't post to %@ with out logging in first.", service] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)tweet:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        NSString *initialText = self.tweetTextField.text;
        if (initialText.length > 140) {
            initialText = [initialText substringToIndex:140];
        }
        [vc setInitialText:initialText];
        [self presentViewController:vc animated:YES completion:nil];
        
    } else {
        [self notLoggedInto:@"Twitter"];
    }
}

- (IBAction)facebookPost:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [vc setInitialText:self.facebookTextField.text];
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        [self notLoggedInto:@"Facebook"];
    }
}

- (IBAction)more:(id)sender {
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:@[self.moreTextField.text] applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}

- (IBAction)doNothing:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"That button does nothing!" message:@"This little piggy went wee wee wee all the way home." preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
