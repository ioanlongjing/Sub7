//
//  DetailViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/10/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "DetailViewController.h"
#import <MapKit/MapKit.h>

@interface DetailViewController ()<CLLocationManagerDelegate, MKMapViewDelegate, MKOverlay>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property CLLocationManager *locationManager;
@property MKPointAnnotation *sandwichAnnotation;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displaySubImage];
    
    self.locationManager = [CLLocationManager new];
    self.mapView.showsUserLocation = true;
    self.sandwichAnnotation = [MKPointAnnotation new];
    CLLocation *shopLocation = [[CLLocation alloc]initWithLatitude:self.selectedSub.shop.location.latitude longitude:self.selectedSub.shop.location.longitude];
    self.sandwichAnnotation.coordinate = shopLocation.coordinate;
    [self.mapView addAnnotation:self.sandwichAnnotation];
    [self getDirections];
    [self.mapView showAnnotations: self.mapView.annotations animated:YES];
}

-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
    
    if (annotation == self.sandwichAnnotation) {
//        pin.image = [UIImage imageNamed:@"pinImage"];
        pin.canShowCallout = YES;
        pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return pin;
    }
    else {
        return nil;
    }
}

-(void) getDirections {
    CLLocation *currentLocation = [[CLLocation alloc]initWithLatitude:self.currentLocation.latitude longitude:self.currentLocation.longitude];
    MKPlacemark *source = [[MKPlacemark alloc]initWithCoordinate:currentLocation.coordinate addressDictionary:nil];
    MKMapItem *sourceMapItem = [[MKMapItem alloc]initWithPlacemark:source];
    //    [sourceMapItem setName:@""];
    MKPlacemark *destination = [[MKPlacemark alloc]initWithCoordinate:self.sandwichAnnotation.coordinate addressDictionary:nil];
    MKMapItem *destinationMapItem = [[MKMapItem alloc]initWithPlacemark:destination];
//    [destinationMapItem setName:@""];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    [request setSource:sourceMapItem];
    [request setDestination:destinationMapItem];
    [request setTransportType:MKDirectionsTransportTypeWalking];
    MKDirections *directions = [[MKDirections alloc]initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        
        NSLog(@"response = %@",response);
        NSArray *routeDirections = [response routes];
        [routeDirections enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            MKRoute *route = obj;
            
            MKPolyline *line = [route polyline];
            [self.mapView addOverlay:line];
            NSLog(@"Route Name : %@",route.name);
            NSLog(@"Total Distance (in Meters) :%f",route.distance);
            
            NSArray *steps = [route steps];
            
            NSLog(@"Total Steps : %lu",(unsigned long)[steps count]);
            
            [steps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSLog(@"Route Instruction : %@",[obj instructions]);
                NSLog(@"Route Distance : %f",[obj distance]);
            }];
        }];
    }];
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineView* aView = [[MKPolylineView alloc]initWithPolyline:(MKPolyline*)overlay] ;
        aView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        aView.lineWidth = 10;
        return aView;
    }
    return nil;
}

-(void) displaySubImage {
    NSData *data = [self.selectedSub.imageFile getData];
    UIImage *image = [UIImage imageWithData:data];
    self.imageView.image = image;
}


@end
