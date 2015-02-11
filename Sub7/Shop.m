//
//  Shop.m
//  Sub7
//
//  Created by Irwin Gonzales on 2/11/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "Shop.h"

@implementation Shop
@dynamic name,address,cashOnly;

+(NSString *)parseClassName
{
    NSString *shop = @"Shop";
    return shop;
}

+(void)registerSubclass
{
    [self registerSubclass];
}
@end
