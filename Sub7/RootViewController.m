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
#import "GetSubs.h"
#import "SuggestSubViewController.h"
#import "TableViewCellAsHeader.h"


@interface RootViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, FindLocationDelegate>

@property NSMutableArray *sandwichImages;
@property Sub *tappedSub;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *subImagesArray;
@property UIRefreshControl *refreshControl;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.refreshControl = [[UIRefreshControl alloc] init];
//    self.refreshControl.backgroundColor = [UIColor blackColor];
    self.refreshControl.tintColor = [UIColor blackColor];
    self.refreshControl.alpha = 0.35;
    [self.refreshControl addTarget:self
                            action:@selector(refreshTableView)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

-(void)viewWillAppear:(BOOL)animated {
    self.title = @"Select a Sandwich";
    if (!self.currentLocation) {
        [self performSegueWithIdentifier:@"pickSubSeg" sender:self];
    }

}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self scrollViewDidScroll:nil];
    
//    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] initWithString:textView.text];
//    NSRange range = NSMakeRange(0, [attString length]);
//    
//    [attString addAttribute:NSFontAttributeName value:textView.font range:range];
//    [attString addAttribute:NSForegroundColorAttributeName value:textView.textColor range:range];
//    
//    NSShadow* shadow = [[NSShadow alloc] init];
//    shadow.shadowColor = [UIColor whiteColor];
//    shadow.shadowOffset = CGSizeMake(0.0f, 1.0f);
//    [attString addAttribute:NSShadowAttributeName value:shadow range:range];
//    
//    textView.attributedText = attString;
    
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


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32.0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TableViewCellAsHeader *headerCell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
    headerCell.backgroundColor = [UIColor whiteColor];
    headerCell.nameLabel.text = [NSString stringWithFormat:@"%@", [self.subs[section]name]];
    headerCell.priceLabel.text = [NSString stringWithFormat:@"$%.02f",[[self.subs[section]price]floatValue]];
    
    return headerCell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 90.0)];
//    view.backgroundColor = [UIColor whiteColor];
//    return view;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JBParallaxCell *cell = [tableView dequeueReusableCellWithIdentifier:@"parallaxCell"];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", [self.subs[indexPath.section]name]];
//    cell.priceLabel.text = [NSString stringWithFormat:@"$%.02f",[[self.subs[indexPath.section]price]floatValue]];
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
        //dvc.title = dvc.selectedSub.name;
        self.title = @"";
    }
    else if ([segue.identifier isEqualToString:@"pickSubSeg"]) {
        FindCurrentLocationViewController *fclvc = segue.destinationViewController;
        fclvc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"SuggestSub"]) {
        SuggestSubViewController *dvc = segue.destinationViewController;
        dvc.suggestedSub = [Sub new];
    }
    
}

-(void)refreshTableView {
    [GetSubs getSubsNearbywithCompletion:^(NSArray *subsArray, NSArray *subImagesArray) {
        self.subImagesArray = subImagesArray;
        self.subs = subsArray;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}


@end
