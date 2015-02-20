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
#import "Shop.h"
#import "Sub.h"


@interface FindCurrentLocationViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>

@property CLLocationManager *locationManager;
@property PFGeoPoint *currentLocation;
@property NSArray *subsNearby;
@property Shop *shop;
@property Sub *sub;


@end

@implementation FindCurrentLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    
//    PFQuery *objectQuery = [PFQuery queryWithClassName:@"Sub"];
//    [objectQuery whereKey:@"name" equalTo:@"Chicken Breast"];
//    [objectQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        self.sub = objects.firstObject;
//        UIImage *subImage = [UIImage imageNamed:@"chickenBreast"];
//        NSData *pictureData = UIImageJPEGRepresentation(subImage, 1.0);
//
//        self.sub.imageFile = [PFFile fileWithData:pictureData];
//        [self.sub saveInBackground];
//    }];
    
//    PFQuery *shopQuery = [PFQuery queryWithClassName:@"Shop"];
//    [shopQuery whereKey:@"name" equalTo:@"Good Luck Cafe & Deli"];
//    [shopQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        self.shop = objects.firstObject;
//        PFGeoPoint *location = [PFGeoPoint geoPointWithLatitude:37.793853 longitude:-122.404827];
//        self.shop.location = location;
//        [self.shop saveInBackground];
//        
//    }];
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        self.currentLocation = geoPoint;
        NSLog(@"%@", self.currentLocation);
        
        
        PFQuery *query = [PFQuery queryWithClassName:@"Shop"];
        [query whereKey:@"location" nearGeoPoint:self.currentLocation withinMiles:1.0];
        [query findObjectsInBackgroundWithBlock:^(NSArray *proximateShops, NSError *error) {
            
            NSLog(@"%@",error.description);
            PFQuery *newQuery = [PFQuery queryWithClassName:@"Sub"];
            [newQuery whereKey:@"shop" containedIn:proximateShops];
            [newQuery findObjectsInBackgroundWithBlock:^(NSArray *subs, NSError *error) {
                self.subsNearby = subs;                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"pickSubSeg" sender:self];
                });
            
            }];
            
        }];
    }];
    
    

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RootViewController *rvc = segue.destinationViewController;
    rvc.currentLocation = self.currentLocation;
    rvc.subs = self.subsNearby;
}



@end
