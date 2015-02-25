//
//  getSubs.h
//  Sub7
//
//  Created by Joseph Lynch on 2/24/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shop.h"
#import <Parse/Parse.h>
#import "Sub.h"


@interface GetSubs : NSObject <CLLocationManagerDelegate>


@property Shop *shop;
@property Sub *sub;

+ (void)getSubsNearbywithCompletion:(void(^)(NSArray *subsArray, NSArray *subImagesArray)) complete;

@end
