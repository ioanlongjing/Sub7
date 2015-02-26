//
//  MapViewController.h
//  Sub7
//
//  Created by Joseph Lynch on 2/25/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>



@interface MapViewController : UIViewController

@property MKRoute *subRoute;
@property MKPointAnnotation *shopAnnotation;

@property (weak, nonatomic) IBOutlet MKMapView *bigMapView;

@end
