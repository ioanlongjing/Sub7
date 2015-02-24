//
//  Bread.h
//  Sub7
//
//  Created by Clint Chilcott on 2/23/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <Parse/Parse.h>
#import "Shop.h"

@interface Bread : PFObject<PFSubclassing>

@property (retain) Shop *shop;
@property (retain) NSString *name;

+ (void)queryForBreadsInShopWithCompletion:(void (^)(NSArray *resultsArray, NSError *error))complete shop:(Shop *)selectedShop;

@end
