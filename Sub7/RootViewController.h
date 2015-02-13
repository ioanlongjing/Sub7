//
//  ViewController.h
//  Sub7
//
//  Created by Clint Chilcott on 2/9/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface RootViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>


@property (nonatomic, strong) IBOutlet iCarousel *carousel;

@end

