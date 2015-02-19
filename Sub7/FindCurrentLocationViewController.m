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
#import <Parse/Parse.h> 


@interface FindCurrentLocationViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>

@property CLLocationManager *locationManager;
@property PFGeoPoint *currentLocation;
@property NSArray *shopsNearby;


@end

@implementation FindCurrentLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        self.currentLocation = geoPoint;
        
        PFQuery *query = [PFQuery queryWithClassName:@"Shop"];
        [query whereKey:@"location" nearGeoPoint:self.currentLocation withinMiles:1.0];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *proximateShops, NSError *error) {
            self.shopsNearby = proximateShops;
            
            PFQuery *newQuery = [PFQuery queryWithClassName:@"Sub"];
            [newQuery whereKey:@"shop" containedIn:self.shopsNearby];
            
            
            [self performSegueWithIdentifier:@"SearchEnded" sender:self];
        }];
    }];
    

}


//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    RootViewController *rvc = segue.destinationViewController;
//    rvc.currentLocation = self.currentLocation;
//}



@end
