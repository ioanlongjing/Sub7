//
//  ViewController.h
//  Sub7
//
//  Created by Clint Chilcott on 2/9/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>



@interface RootViewController : UIViewController


@property PFGeoPoint *currentLocation;
@property NSArray *subs;


@end

