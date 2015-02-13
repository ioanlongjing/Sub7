//
//  Shop.h
//  Sub7
//
//  Created by Irwin Gonzales on 2/11/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <Parse/Parse.h>

@interface Shop : PFObject <PFSubclassing>
+ (NSString *)parseClassName;

@property NSString *name;
@property NSString *address;
@property NSString *city;
@property NSString *state;
@property NSNumber *zip;
@property BOOL *cashOnly;
@property NSMutableArray *shopsArray;

+ (void)queryForAllShopsWithCompletion:(void (^)(NSArray *, NSError *))complete;

@end
