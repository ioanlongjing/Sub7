//
//  getSubs.m
//  Sub7
//
//  Created by Joseph Lynch on 2/24/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "GetSubs.h"

@implementation GetSubs

+ (void)getSubsNearbywithCompletion:(void(^)(NSArray *subsArray, NSArray *subImagesArray)) complete {
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        PFGeoPoint *currentLocation = geoPoint;
        NSLog(@"%@", currentLocation);
        
        
        PFQuery *query = [PFQuery queryWithClassName:@"Shop"];
        [query whereKey:@"location" nearGeoPoint:currentLocation withinMiles:10.0];
        [query findObjectsInBackgroundWithBlock:^(NSArray *proximateShops, NSError *error) {
            
            NSLog(@"%@",error.description);
            PFQuery *newQuery = [PFQuery queryWithClassName:@"Sub"];
            [newQuery whereKey:@"shop" containedIn:proximateShops];
            [newQuery findObjectsInBackgroundWithBlock:^(NSArray *subs, NSError *error) {
                NSMutableArray *subImages = [NSMutableArray new];
                for(Sub * sub in subs)
                {
                    NSData *imageData = [sub.image getData];
                    UIImage *image = [UIImage imageWithData:imageData];
                    [subImages addObject:image];
                }
                complete (subs, subImages);
                
            }];
            
        }];
    }];

}

@end
