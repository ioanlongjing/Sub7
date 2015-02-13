//
//  CustomSandoAnnotation.m
//  Sub7
//
//  Created by Irwin Gonzales on 2/13/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "CustomSandoAnnotation.h"
#import <Parse/Parse.h>
#import "Sando.h"


@implementation CustomSandoAnnotation


+(void)getShopLocationWithCompletionHandler:(void(^)(NSArray *array, NSError *error))complete
{
    PFQuery *query = [Sando query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        complete(objects,error);
    }];
}

@end
