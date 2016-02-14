//
//  PointOfInterestAnnotationView.m
//  MapSample
//
//  Created by Mike Swan on 2/14/16.
//  Copyright © 2016 theMikeSwan. All rights reserved.
//

#import "PointOfInterestAnnotationView.h"
#import "PointOfIntrestAnnotation.h"


@implementation PointOfInterestAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation
                   reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.pinTintColor = [UIColor magentaColor];
        PointOfIntrestAnnotation *a = annotation;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[a.poi image]];
        self.detailCalloutAccessoryView = imageView;
        self.canShowCallout = YES;
    }
    return self;
}
@end
