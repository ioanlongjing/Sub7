//
//  Sub.m
//  Sub7
//
//  Created by Joseph Lynch on 2/17/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "Sub.h"

@implementation Sub

@dynamic name;
@dynamic price;
@dynamic stockIngredients;
@dynamic shop;

+(void)load {
    [self registerSubclass];
}

+(NSString *)parseClassName {
    return @"Sub";
}

+ (void)queryForSubsInShopWithCompletion:(void (^)(NSArray *resultsArray, NSError *error))complete shop:(Shop *)selectedShop
{
    NSMutableArray *objectArray = [NSMutableArray new];
    PFQuery *query = [Sub query];
    [query whereKey:@"shop" equalTo:selectedShop];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [objectArray addObject:objectArray];
        complete(objects, error);
    }];
}

@end
