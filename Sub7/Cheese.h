//
//  Cheese.h
//  Sub7
//
//  Created by Clint Chilcott on 2/23/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <Parse/Parse.h>
@class Shop;
@interface Cheese : PFObject<PFSubclassing>

@property (retain) Shop *shop;
@property (retain) NSString *name;
@property (retain) NSNumber *price;

+ (void)queryForCheesesInShopWithCompletion:(void (^)(NSArray *resultsArray, NSError *error))complete shop:(Shop *)selectedShop;

@end
