//
//  PointOfInterest.m
//  MapSample
//
//  Created by Mike Swan on 2/14/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

#import "PointOfInterest.h"

@implementation PointOfInterest

- (UIImage *) image {
    return [UIImage imageNamed:self.imageName];
}

- (CLLocationCoordinate2D) coordinate {
    return self.location.coordinate;
}
@end
