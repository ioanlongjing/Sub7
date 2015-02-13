//
//  Sando.h
//  Sub7
//
//  Created by Irwin Gonzales on 2/11/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <Parse/Parse.h>

@interface Sando : PFObject <PFSubclassing>

@property NSString *name;
@property NSNumber *price;
@property PFFile *pic;

+ (void)queryForAllSandoWithCompletion:(void (^)(NSArray *, NSError *))complete;

@end
