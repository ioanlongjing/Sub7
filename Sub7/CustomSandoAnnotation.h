//
//  CustomSandoAnnotation.h
//  Sub7
//
//  Created by Irwin Gonzales on 2/13/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface CustomSandoAnnotation : MKPointAnnotation


+(void)getShopLocationWithCompletionHandler:(void(^)(NSArray *array, NSError *error))complete;

@end
