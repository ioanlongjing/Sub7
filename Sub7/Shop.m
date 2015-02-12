//
//  Shop.m
//  Sub7
//
//  Created by Irwin Gonzales on 2/11/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "Shop.h"
#import <Parse/PFObject+Subclass.h>

@implementation Shop
@dynamic name,address,city,state,zip,cashOnly;

+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    NSString *shop = @"Shop";
    return shop;
}


+ (void)queryForAllShopsWithCompletion:(void (^)(NSArray *, NSError *))complete
{
    PFQuery *query = [Shop query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        complete(objects, error);
    }];
}


@end
