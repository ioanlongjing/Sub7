//
//  ViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/9/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "RootViewController.h"

#import "CustomCollectionViewCell.h"
#import <Parse/Parse.h>


@interface RootViewController ()
@property NSMutableArray *sandwichImages;

@end

@implementation RootViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.carousel.type = iCarouselTypeRotary;
    

    
//    // Test Parse Connection
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
    
    
    
    self.sandwichImages = [NSMutableArray new];
    [self.sandwichImages addObject:[UIImage imageNamed:@"01.png"]];
    [self.sandwichImages addObject:[UIImage imageNamed:@"02.png"]];
    [self.sandwichImages addObject:[UIImage imageNamed:@"03.png"]];
    [self.sandwichImages addObject:[UIImage imageNamed:@"04.png"]];
    [self.sandwichImages addObject:[UIImage imageNamed:@"05.png"]];
    [self.sandwichImages addObject:[UIImage imageNamed:@"06.png"]];
    [self.sandwichImages addObject:[UIImage imageNamed:@"07.png"]];
    [self.sandwichImages addObject:[UIImage imageNamed:@"08.png"]];
    [self.sandwichImages addObject:[UIImage imageNamed:@"09.png"]];
    [self.sandwichImages addObject:[UIImage imageNamed:@"10.png"]];
    
   

    [self.carousel reloadData];
    
    //[self.collectionView setPagingEnabled:YES];



}

#pragma -----------------------------------Carousel Delegate Methods----------------------------------------------

-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.sandwichImages.count;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1;
    }
    return value;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    
    
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 300.0f)];
        ((UIImageView *)view).image = [self.sandwichImages objectAtIndex:index];
        view.contentMode = UIViewContentModeScaleAspectFit;
        
//        label = [[UILabel alloc] initWithFrame:view.bounds];
//        label.backgroundColor = [UIColor clearColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [label.font fontWithSize:50];
//        label.tag = 1;
//        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
//    label.text = [[self.sandwichImages objectAtIndex:index] stringValue];
    
    return view;
}


- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSNumber *item = [self.sandwichImages objectAtIndex:index];
    [self performSegueWithIdentifier:@"DetailSeg" sender:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
