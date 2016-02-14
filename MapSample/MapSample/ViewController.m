//
//  ViewController.m
//  MapSample
//
//  Created by Mike Swan on 2/13/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//


#import "ViewController.h"
#import "PointOfInterestAnnotationView.h"
#import "PointOfIntrestAnnotation.h"
#import "PointOfInterest.h"

// Enum so we know if we can use location services or have even asked yet.
typedef enum {
    TMSLocationAvalibilityUnknown,
    TMSLocationAvalibilityApproved,
    TMSLocationAvalibilityDenied
}TMSLocationAvalibilityStatus;

@interface ViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISwitch *trackingSwitch;
/// An Array of all our annotations.
@property NSArray *annotations;
/// Our location manager for tracking the user location if we are allowed and it is so desired.
@property CLLocationManager *locationManager;
/// Keeps track of wether we can use location services or not rather than going through a lengthy process every time.
@property TMSLocationAvalibilityStatus locationAvalibility;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _locationAvalibility = TMSLocationAvalibilityUnknown;
    _trackingSwitch.on = NO;
    [self createAnnotations];
    [self configureLocationManager];
}

/// Sets up the location manager for us
- (void) configureLocationManager {
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    manager.delegate = self;
    _locationManager = manager;
}

/// This figures out if we can use location services or not
- (void) determineLocationAvailability {
    if ([CLLocationManager locationServicesEnabled]) {
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
            [_locationManager requestWhenInUseAuthorization];
        } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
            _locationAvalibility = TMSLocationAvalibilityApproved;
        }
    } else {
        _locationAvalibility = TMSLocationAvalibilityDenied;
    }
}

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        _locationAvalibility = TMSLocationAvalibilityApproved;
        [_locationManager startUpdatingLocation];
    } else {
        _locationAvalibility = TMSLocationAvalibilityDenied;
        _trackingSwitch.on = NO;
    }
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location Manager Error: @%@",[error localizedDescription]);
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self centerMapOnAnnotation:[_mapView userLocation]];
}

/// Creates all of the annotations we want to display. Doing it with a plist file makes it easier to change in the future.
- (void) createAnnotations {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PointsOfInterest" ofType:@"plist"];
    NSArray *rawAnnotations = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in rawAnnotations) {
        PointOfInterest *newPOI = [[PointOfInterest alloc] init];
        newPOI.name = dict[@"name"];
        newPOI.imageName = dict[@"image"];
        double lat = [dict[@"latitude"] doubleValue];
        double longi = [dict[@"longitude"] doubleValue];
        newPOI.location = [[CLLocation alloc] initWithLatitude:lat longitude:longi];
        PointOfIntrestAnnotation *newAnnotation = [[PointOfIntrestAnnotation alloc] init];
        newAnnotation.poi = newPOI;
        newAnnotation.title = newPOI.name;
        newAnnotation.coordinate = newPOI.coordinate;
        [results addObject:newAnnotation];
    }
    _annotations = [NSArray arrayWithArray:results];
    [_mapView addAnnotations:_annotations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/// Declared in MKMapViewDelegate. Used to set the view that is used to mark a position on the map. Allows us to use our custom annotation view.
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation class] == [PointOfIntrestAnnotation class]) {
        PointOfInterestAnnotationView *annotationView = [[PointOfInterestAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
        return annotationView;
    }
    return nil;
}

- (IBAction)showHP1:(id)sender {
    [self centerMapOnAnnotation:[self annotationWithName:@"Harry Potter Studio Tour London"]];
}

- (IBAction)showHP2:(id)sender {
    [self centerMapOnAnnotation:[self annotationWithName:@"Wizarding World of Harry Potter Orlando"]];
}

- (IBAction)showHP3:(id)sender {
    [self centerMapOnAnnotation:[self annotationWithName:@"Wizarding World of Harry Potter Hollywood"]];
}

// This method of getting the specific annotation we want is less fragile, we always get the one that has th etitle we are looking for or nothing at all.
- (MKPointAnnotation *)annotationWithName: (NSString *)name {
    MKPointAnnotation *result;
    for (PointOfIntrestAnnotation *annotation in _annotations) {
        if ([annotation.poi.name isEqualToString:name]) {
            result = annotation;
            break;
        }
    }
    return result;
}

- (void) centerMapOnAnnotation: (id<MKAnnotation> ) annotation {
    [_mapView setCenterCoordinate:annotation.coordinate animated:YES];
//    MKCoordinateRegion region = MKCoordinateRegionMake(annotation.coordinate, MKCoordinateSpanMake(1.0, 1.0));
//    [_mapView setRegion:[_mapView regionThatFits:region]];
}

- (IBAction)toggleTracking:(id)sender {
    if (_trackingSwitch.isOn) {
        if (_locationAvalibility == TMSLocationAvalibilityDenied) {
            [self determineLocationAvailability];
            _trackingSwitch.on = NO;
            return;
        }
        if (_locationAvalibility == TMSLocationAvalibilityUnknown) {
            [self determineLocationAvailability];
            return;
        } else {
            [_locationManager startUpdatingLocation];
            _mapView.showsUserLocation = YES;
        }
    } else {
        [_locationManager stopUpdatingLocation];
        _mapView.showsUserLocation = NO;
    }
    
    
}
@end
