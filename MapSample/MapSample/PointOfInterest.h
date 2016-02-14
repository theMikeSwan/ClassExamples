//
//  PointOfInterest.h
//  MapSample
//
//  Created by Mike Swan on 2/14/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

/// Model class for storing details about points of interest.
@interface PointOfInterest : NSObject
@property CLLocation *location;
@property NSString *name;
@property NSString *imageName;
// TODO: Add additional properties as needed

/// Returns the image associated with the point
- (UIImage *)image;

/// Convience method to get the coordinate of the point from the CLLocation instance
- (CLLocationCoordinate2D) coordinate;
@end
