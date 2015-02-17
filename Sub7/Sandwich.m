//
//  Sando.m
//  Sub7
//
//  Created by Irwin Gonzales on 2/11/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "Sandwich.h"

@implementation Sandwich
@dynamic name,price,image,stockIngredients;

+ (NSString *)parseClassName
{
    NSString *sandwich = @"Sandwich";
    return sandwich;
}

+ (void)registerSubclass
{
    [self registerSubclass];
}
+ (void)queryForAllSandwichesWithCompletion:(void(^)(NSArray *resultsArray, NSError *error))complete
{
    PFQuery *query = [Sandwich query];
    [query includeKey:@"shop"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        complete(objects, error);
    }];
    
}

@end
