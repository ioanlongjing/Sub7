//
//  ViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/9/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "Shop.h"
#import "Sub.h"
#import "FindCurrentLocationViewController.h"


@interface RootViewController () <iCarouselDelegate, iCarouselDataSource, FindLocationDelegate>

@property NSMutableArray *sandwichImages;
@property Sub *tappedSub;
@property PFFile *stockFile;
@property FindCurrentLocationViewController *fclvc;

@end

@implementation RootViewController

-(void)viewWillAppear:(BOOL)animated {
    if (!self.currentLocation) {
        [self performSegueWithIdentifier:@"pickSubSeg" sender:self];
    }
}


-(void)currentLocationDetermined:(PFGeoPoint *)currentLocation withSubs:(NSArray *)subsArray {
    self.currentLocation = currentLocation;
    self.subs = subsArray;
    [self.carousel reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *subImage = [UIImage imageNamed:@"stock"];
    NSData *data = UIImageJPEGRepresentation(subImage, 1.0);
    self.stockFile = [PFFile fileWithData:data];
    
    self.carousel.type = iCarouselTypeRotary;
    [self.carousel reloadData];
    
}


#pragma -----------------------------------Carousel Delegate Methods----------------------------------------------

-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.subs.count;
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
    
    
    
    UIImageView *imageView = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 350.0f, 350.0f)];
        view.tag = 1;
        
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
        imageView = (UIImageView *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
//    label.text = [[self.sandwichImages objectAtIndex:index] stringValue];
    Sub *sub = [self.subs objectAtIndex:index];
    if (sub.imageFile) {
        [sub.imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                ((UIImageView *)view).image = image;
                view.contentMode = UIViewContentModeScaleAspectFit;
            }
        }];
    }
    else {
        sub.imageFile = self.stockFile;
        [sub.imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                ((UIImageView *)view).image = image;
                view.contentMode = UIViewContentModeScaleAspectFit;
            }
        }];
    }
    

    
    return view;
}


- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%ld", (long)index);
    self.tappedSub = [self.subs objectAtIndex:index];
    [self performSegueWithIdentifier:@"DetailSeg" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailSeg"]) {
        DetailViewController *dvc = segue.destinationViewController;
        dvc.selectedSub = self.tappedSub;
    }
    else if ([segue.identifier isEqualToString:@"pickSubSeg"]) {
        FindCurrentLocationViewController *fclvc = segue.destinationViewController;
        fclvc.delegate = self;
    }
    
}


@end
