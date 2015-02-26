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
//    PFQuery *subQuery = [PFQuery queryWithClassName:@"Sub"];
//    Sub *sub = (Sub *) [subQuery getObjectWithId:@"KAjmCj9U34"];
//    UIImage *subImage = [UIImage imageNamed:@"eggSalad"];
//        NSData *pictureData = UIImageJPEGRepresentation(subImage, 1.0);
//        sub.image = [PFFile fileWithData:pictureData];
//        [sub saveInBackground];
//
//    [self dismissViewControllerAnimated:false completion:nil];
//}

@end
