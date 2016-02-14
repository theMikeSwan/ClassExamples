//
//  ViewController.m
//  iOSDesignClassWk1
//
//  Created by Mike Swan on 1/21/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://www.apple.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    CLGeocoder *locator = [[CLGeocoder alloc] init];
    [locator geocodeAddressString:@"1 Infinite Loop, Cupertino, CA" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLLocationCoordinate2D location = placemarks[0].location.coordinate;
            MKCoordinateSpan span = MKCoordinateSpanMake(.01, .01);
            MKCoordinateRegion region = MKCoordinateRegionMake(location, span);
            _mapView.region = region;
        }
    }];
    
    _textView1.text = @"Think Different";
    
    _textView2.text = @"1-800-MY-APPLE";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
