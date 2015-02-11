//
//  Shop.h
//  Sub7
//
//  Created by Irwin Gonzales on 2/11/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <Parse/Parse.h>

@interface Shop : PFObject <PFSubclassing>

@property NSString *name;
@property NSString *address;
@property BOOL *cashOnly;

@end
