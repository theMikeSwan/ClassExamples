//
//  PointOfIntrestAnnotation.h
//  MapSample
//
//  Created by Mike Swan on 2/14/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "PointOfInterest.h"

@interface PointOfIntrestAnnotation : MKPointAnnotation
@property PointOfInterest *poi;
@end
