//
//  Shop.h
//  Sub7
//
//  Created by Irwin Gonzales on 2/11/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <Parse/Parse.h>

@interface Shop : PFObject <PFSubclassing>


@property (retain) NSString *name;
@property (retain) NSString *address;
@property (retain) NSString *city;
@property (retain) NSString *state;
@property (retain) NSString *zip;
@property (retain) NSString *phone;
@property BOOL *cashOnly;
@property (retain) NSMutableArray *shopsArray;
@property (retain) PFGeoPoint *location;

+ (NSString *)parseClassName;
+ (void)queryForAllShopsWithCompletion:(void (^)(NSArray *resultsArray, NSError *error))complete;


@end
