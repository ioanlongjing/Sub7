//
//  ViewController.h
//  Sub7
//
//  Created by Clint Chilcott on 2/9/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import <MapKit/MapKit.h>


@interface RootViewController : UIViewController <iCarouselDataSource, iCarouselDelegate, MKMapViewDelegate, CLLocationManagerDelegate>


@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@property CLLocation *currentLocation;


@end

