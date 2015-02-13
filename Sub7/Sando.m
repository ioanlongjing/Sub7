//
//  Sando.m
//  Sub7
//
//  Created by Irwin Gonzales on 2/11/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "Sando.h"

@implementation Sando
@dynamic name,price,pic,sandoNames;

+(NSString *)parseClassName
{
    NSString *sando = @"Sando";
    return sando;
}

+ (void)registerSubclass
{
    [self registerSubclass];
}

+ (void)queryForAllSandosWithCompletion:(void(^)(NSArray *, NSError *))complete
{
    PFQuery *query = [Sando query];
    [query includeKey:@"shop"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        complete(objects, error);
    }];
    
}

@end
