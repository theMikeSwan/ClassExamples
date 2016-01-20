//
//  ViewController.m
//  ObjC1
//
//  Created by Mike Swan on 9/21/15.
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

- (void) notLoggedInto:(NSString *) service {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"You're not logged in!" message:[NSString stringWithFormat: @"You must log into %@ in Settings.app to post to %@", service, service] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *serviceString = [NSString stringWithFormat:@"prefs:root=%@", [service capitalizedString]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:serviceString]];
    }]];
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
