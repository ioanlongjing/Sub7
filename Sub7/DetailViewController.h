//
//  DetailViewController.h
//  Sub7
//
//  Created by Clint Chilcott on 2/10/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sub.h"
#import <Parse/Parse.h>

@interface DetailViewController : UIViewController

@property Sub *selectedSub;
@property PFGeoPoint *currentLocation;

@end
