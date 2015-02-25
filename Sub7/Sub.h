//
//  Sub.h
//  Sub7
//
//  Created by Joseph Lynch on 2/17/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <Parse/Parse.h>
#import "Shop.h"

@interface Sub : PFObject<PFSubclassing>

@property (retain) NSString *name;
@property (retain) NSString *price;
@property (retain) NSMutableArray *stockIngredients;
@property (retain) Shop *shop;
@property (retain) PFFile *image;

+ (NSString *)parseClassName;
+ (void)queryForSubsInShopWithCompletion:(void (^)(NSArray *resultsArray, NSError *error))complete shop:(Shop *)selectedShop;

@end
