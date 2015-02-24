//
//  Cheese.m
//  Sub7
//
//  Created by Clint Chilcott on 2/23/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "Cheese.h"

@implementation Cheese

@dynamic shop;
@dynamic name;
@dynamic price;

+(void)load {
    [self registerSubclass];
}

+(NSString *)parseClassName {
    return @"Cheese";
}

+ (void)queryForCheesesInShopWithCompletion:(void (^)(NSArray *resultsArray, NSError *error))complete shop:(Shop *)selectedShop
{
    NSMutableArray *objectArray = [NSMutableArray new];
    PFQuery *query = [Cheese query];
    [query whereKey:@"shop" equalTo:selectedShop];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [objectArray addObject:objectArray];
        complete(objects, error);
    }];
    
}

@end
