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
@dynamic name;
@dynamic address;
@dynamic city;
@dynamic state;
@dynamic zip;
@dynamic cashOnly;
@dynamic shopsArray;
@dynamic location;

+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    NSString *shop = @"Shop";
    return shop;
}




@end
