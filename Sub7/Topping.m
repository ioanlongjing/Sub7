//
//  Topping.m
//  Sub7
//
//  Created by Clint Chilcott on 2/23/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "Topping.h"

@implementation Topping

@dynamic shop;
@dynamic name;
@dynamic price;

+(void)load {
    [self registerSubclass];
}

+(NSString *)parseClassName {
    return @"Topping";
}

+ (void)queryForToppingsInShopWithCompletion:(void (^)(NSArray *resultsArray, NSError *error))complete shop:(Shop *)selectedShop
{
    NSMutableArray *objectArray = [NSMutableArray new];
    PFQuery *query = [Topping query];
    [query whereKey:@"shop" equalTo:selectedShop];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [objectArray addObject:objectArray];
        complete(objects, error);
    }];
    
}

@end
