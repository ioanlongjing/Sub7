//
//  MapViewController.m
//  Sub7
//
//  Created by Joseph Lynch on 2/25/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bigMapView.delegate = self;
    self.bigMapView.showsUserLocation = true;
    [self.bigMapView addAnnotation:self.shopAnnotation];
    MKPolyline *line = [self.subRoute polyline];
    [self.bigMapView addOverlay:line];
    [self.bigMapView showAnnotations: self.bigMapView.annotations animated:YES];
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineView* aView = [[MKPolylineView alloc]initWithPolyline:(MKPolyline*)overlay] ;
        aView.strokeColor = [[UIColor colorWithRed:255/255.0 green:104/255.0 blue:57/255.0 alpha:1.0] colorWithAlphaComponent:0.5];
        aView.lineWidth = 10;
        return aView;
    }
    return nil;
}

-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
    
    if (annotation == self.shopAnnotation) {
        pin.image = [UIImage imageNamed:@"pin"];
        pin.canShowCallout = YES;
        pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return pin;
    }
    else {
        return nil;
    }
}

@end
