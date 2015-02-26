//
//  FindCurrentLocationViewController.m
//  Sub7
//
//  Created by Joseph Lynch on 2/16/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "FindCurrentLocationViewController.h"
#import "RootViewController.h"
#import "Shop.h"

@interface FindCurrentLocationViewController ()<CLLocationManagerDelegate>

@property CLLocationManager *locationManager;
@property PFGeoPoint *currentLocation;
@property Shop *shop;
@property Sub *sub;
@property PFFile *stockFile;
@property NSArray *subsNearby;
@property NSMutableArray *subImages;


@end

@implementation FindCurrentLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    

    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        self.currentLocation = geoPoint;
        NSLog(@"%@", self.currentLocation);
        
        PFQuery *query = [PFQuery queryWithClassName:@"Shop"];
        [query whereKey:@"location" nearGeoPoint:self.currentLocation withinMiles:10.0];
        [query findObjectsInBackgroundWithBlock:^(NSArray *proximateShops, NSError *error) {
            
            NSLog(@"%@",error.description);
            PFQuery *newQuery = [PFQuery queryWithClassName:@"Sub"];
            [newQuery whereKey:@"shop" containedIn:proximateShops];
            [newQuery findObjectsInBackgroundWithBlock:^(NSArray *subs, NSError *error) {
                self.subsNearby = subs;
                self.subImages = [NSMutableArray new];
                for(Sub * sub in self.subsNearby)
                {
                    NSData *imageData = [sub.image getData];
                    UIImage *image = [UIImage imageWithData:imageData];
                    [self.subImages addObject:image];
                }
                
                [self.delegate currentLocationDetermined:self.currentLocation withSubs:self.subsNearby withSubImages:[self.subImages mutableCopy]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:false completion:nil];
                });
            
            }];
            
        }];
    }];
    
}

//
//- (void)viewDidLoad {
//    PFQuery *objectQuery = [PFQuery queryWithClassName:@"Sub"];
//    [objectQuery whereKey:@"name" equalTo:@"Mortadella"];
//    [objectQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        self.sub = objects.firstObject;
//        UIImage *subImage = [UIImage imageNamed:@"mortadella"];
//        NSData *pictureData = UIImageJPEGRepresentation(subImage, 1.0);
//
//        self.sub.image = [PFFile fileWithData:pictureData];
//        [self.sub saveInBackground];
//    }];

//    PFQuery *shopQuery = [PFQuery queryWithClassName:@"Shop"];
//    Shop *shop = (Shop *)[shopQuery getObjectWithId:@"zfOrgziTN5"];
//    PFGeoPoint *location = [PFGeoPoint geoPointWithLatitude:37.798691 longitude:-122.407880];
//    shop.location = location;
//    [shop saveInBackground];
//    [self dismissViewControllerAnimated:false completion:nil];
//
//}

@end
