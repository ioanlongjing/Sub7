//
//  Bread.m
//  Sub7
//
//  Created by Clint Chilcott on 2/23/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "Bread.h"

@implementation Bread

@dynamic shop;
@dynamic name;


+(void)load {
    [self registerSubclass];
}

+(NSString *)parseClassName {
    return @"Bread";
}

+ (void)queryForBreadsInShopWithCompletion:(void (^)(NSArray *resultsArray, NSError *error))complete shop:(Shop *)selectedShop
{
    NSMutableArray *objectArray = [NSMutableArray new];
    PFQuery *query = [Bread query];
    [query whereKey:@"shop" equalTo:selectedShop];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [objectArray addObject:objectArray];
        complete(objects, error);
    }];
    
}

@end
