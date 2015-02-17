//
//  FindCurrentLocationViewController.m
//  Sub7
//
//  Created by Joseph Lynch on 2/16/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "FindCurrentLocationViewController.h"
#import <MapKit/MapKit.h>
#import "RootViewController.h"


@interface FindCurrentLocationViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>

@property CLLocationManager *locationManager;
@property CLLocation *currentLocation;


@end

@implementation FindCurrentLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager.delegate = self;

}

-(void) updateCurrentLocation {
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self.locationManager stopUpdatingLocation];
    self.currentLocation = locations.firstObject;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RootViewController *rvc = segue.destinationViewController;
    rvc.currentLocation = self.currentLocation;
}



@end
