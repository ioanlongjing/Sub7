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
#import "JBParallaxCell.h"


@interface RootViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, FindLocationDelegate>

@property NSMutableArray *sandwichImages;
@property Sub *tappedSub;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *subImagesArray;
@property UIRefreshControl *refreshControl;

@end

@implementation RootViewController
- (IBAction)fuckthisshit:(UIButton *)sender {
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.refreshControl = [[UIRefreshControl alloc] init];
//    self.refreshControl.backgroundColor = [UIColor purpleColor];
//    self.refreshControl.tintColor = [UIColor whiteColor];
//    [self.refreshControl addTarget:self
//                            action:@selector(findSubs)
//                  forControlEvents:UIControlEventValueChanged];

    
    
}

-(void)viewWillAppear:(BOOL)animated {
    self.title = @"Pick Your Sub";
    if (!self.currentLocation) {
        [self performSegueWithIdentifier:@"pickSubSeg" sender:self];
    }

}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self scrollViewDidScroll:nil];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma-------------------------------------Custom Delegate---------------------------------------------------


-(void)currentLocationDetermined:(PFGeoPoint *)currentLocation withSubs:(NSArray *)subsArray withSubImages:(NSArray *)subImagesArray {
    self.currentLocation = currentLocation;
    self.subs = subsArray;
    self.subImagesArray = subImagesArray;
    
}


#pragma-----------------------------------TableView Data Source------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.subs.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 20.0)];
    view.backgroundColor = [UIColor blackColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JBParallaxCell *cell = [tableView dequeueReusableCellWithIdentifier:@"parallaxCell"];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", [self.subs[indexPath.section]name]];
    cell.priceLabel.text = [NSString stringWithFormat:@"$%.02f",[[self.subs[indexPath.section]price]floatValue]];
    cell.parallaxImage.image = self.subImagesArray[indexPath.section];

    
    return cell;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Get visible cells on table view.
    NSArray *visibleCells = [self.tableView visibleCells];
    
    for (JBParallaxCell *cell in visibleCells) {
        [cell cellOnTableView:self.tableView didScrollOnView:self.view];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailSeg"]) {
        DetailViewController *dvc = segue.destinationViewController;
        dvc.selectedSub = [self.subs objectAtIndex:[self.tableView indexPathForSelectedRow].section];
        dvc.currentLocation = self.currentLocation;
        self.title = @"Subs";
    }
    else if ([segue.identifier isEqualToString:@"pickSubSeg"]) {
        FindCurrentLocationViewController *fclvc = segue.destinationViewController;
        fclvc.delegate = self;
    }
    
}


@end
