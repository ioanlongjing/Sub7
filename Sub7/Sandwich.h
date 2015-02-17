//
//  Sando.h
//  Sub7
//
//  Created by Irwin Gonzales on 2/11/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <Parse/Parse.h>

@interface Sandwich : PFObject <PFSubclassing>

@property NSString *name;
@property NSNumber *price;
@property NSData *image;
@property NSArray *stockIngredients;

+ (NSString *)parseClassName;
+ (void)queryForAllSandwichesWithCompletion:(void(^)(NSArray *resultsArray, NSError *error))complete;
+ (void)registerSubclass;

@end
