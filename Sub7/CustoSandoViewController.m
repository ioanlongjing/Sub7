//
//  CustomizeSandoViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/10/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "CustoSandoViewController.h"

@interface CustoSandoViewController () <UICollisionBehaviorDelegate>
@property UIDynamicAnimator *animator;

@end

@implementation CustoSandoViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 5, 5)];
    [self.view addSubview:testView];
    
    
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:self.view.subviews];
    [animator addBehavior:gravityBehavior];

    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:self.view.subviews];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionDelegate = self;
    [animator addBehavior:collisionBehavior];
    
    self.animator = animator;
}



@end
