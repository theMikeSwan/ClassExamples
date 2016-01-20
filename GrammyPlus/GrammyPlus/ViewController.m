//
//  ViewController.m
//  GrammyPlus
//
//  Created by Mike Swan on 11/17/15.
//  Copyright © 2015 theMikeSwan. All rights reserved.
//

#import "ViewController.h"
#import "NXOAuth2.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logIn:(id)sender {
    [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:@"Instagram"];
    self.logoutButton.enabled = YES;
    self.refreshButton.enabled = YES;
    self.loginButton.enabled = NO;
}

- (IBAction)logOut:(id)sender {
    self.loginButton.enabled = YES;
    self.logoutButton.enabled = NO;
    self.refreshButton.enabled = NO;
    NXOAuth2AccountStore *store = [NXOAuth2AccountStore sharedStore];
    NSArray *instagramAccounts = [store accountsWithAccountType:@"Instagram"];
    for (id account in instagramAccounts) {
        [store removeAccount:account];
    }
}


- (IBAction)refresh:(id)sender {
    NSArray *instagramAccounts = [[NXOAuth2AccountStore sharedStore] accountsWithAccountType:@"Instagram"];
    if (instagramAccounts.count <= 0) return;
    NXOAuth2Account *account = instagramAccounts[0];
    NSString *token = account.accessToken.accessToken;
    // The URL listed in the video kept giving me a 404, this one from the documentation works much better.
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/media/recent/?access_token=%@", token]];
    NSURLSession *session = [NSURLSession sharedSession];
    [[ session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Session error: %@", error);
            return;
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        if (httpResponse.statusCode < 200 || httpResponse.statusCode >= 300) {
            NSLog(@"HTTP response error: %ld", httpResponse.statusCode);
            return;
        }
        NSError *anError = nil;
        id package = [NSJSONSerialization JSONObjectWithData:data options:0 error:&anError];
        if (!package) {
            NSLog(@"JSON error: %@", anError);
            return;
        }
        NSLog(@"package: %@", package);
        NSString *imagePath = package[@"data"][0][@"images"][@"standard_resolution"][@"url"];
        NSURL *imageURL = [NSURL URLWithString:imagePath];
        [[session dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Session error getting image: %@", error);
                return;
            }
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            if (httpResponse.statusCode < 200 || httpResponse.statusCode >= 300) {
                NSLog(@"HTTP response error while getting image: %ld", httpResponse.statusCode);
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = [UIImage imageWithData:data];
            });
        }] resume];
    }] resume];
    
}

@end
