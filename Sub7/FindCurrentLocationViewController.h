//
//  FindCurrentLocationViewController.h
//  Sub7
//
//  Created by Joseph Lynch on 2/16/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h> 
#import "Sub.h"


@protocol FindLocationDelegate <NSObject>
@optional

-(void) currentLocationDetermined:(PFGeoPoint *)currentLocation withSubs:(NSArray *)subsArray;


@end

@interface FindCurrentLocationViewController : UIViewController

@property (nonatomic, weak) id <FindLocationDelegate> delegate;
@property NSArray *subsNearby;

@end
