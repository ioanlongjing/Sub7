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
@dynamic imageFile;

+(void)load {
    [self registerSubclass];
}

+(NSString *)parseClassName {
    return @"Sub";
}

@end
