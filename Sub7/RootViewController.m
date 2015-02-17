//
//  ViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/9/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "RootViewController.h"
#import <Parse/Parse.h>
#import "Sandwich.h"
#import "Shop.h"
#import "TableViewCell.h"


@interface RootViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray *sandwichImages;
@property NSArray *allSandwiches;
@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [Sandwich queryForAllSandwichesWithCompletion:^(NSArray *resultsArray, NSError *error) {
        self.allSandwiches = resultsArray;
        NSLog(@"%@", self.allSandwiches);
    }];
    
    
    
    
//    self.sandwichImages = [NSMutableArray new];
//    [self.sandwichImages addObject:[UIImage imageNamed:@"01.png"]];
//    [self.sandwichImages addObject:[UIImage imageNamed:@"02.png"]];
//    [self.sandwichImages addObject:[UIImage imageNamed:@"03.png"]];
//    [self.sandwichImages addObject:[UIImage imageNamed:@"04.png"]];
//    [self.sandwichImages addObject:[UIImage imageNamed:@"05.png"]];
//    [self.sandwichImages addObject:[UIImage imageNamed:@"06.png"]];
//    [self.sandwichImages addObject:[UIImage imageNamed:@"07.png"]];
//    [self.sandwichImages addObject:[UIImage imageNamed:@"08.png"]];
//    [self.sandwichImages addObject:[UIImage imageNamed:@"09.png"]];
//    [self.sandwichImages addObject:[UIImage imageNamed:@"10.png"]];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sandwichImages.count;
}

//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.imageView.image = [self.sandwichImages objectAtIndex:indexPath.row];
//    

//    //cell.imageView.image = [self.sandwichImages objectAtIndex:indexPath.row];
//    NSNumber *priceCount = self.sub[@"price"];
//
//    PFFile *sandoImage = [self.sando objectForKey:@"image"];
//    [sandoImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
//    {
//        UIImage *image = [UIImage imageWithData:data];
//        cell.imageView.image = image;
//    }];
//
////    cell.sandoNameLabel.text = self.sando.name;
////    cell.sandoPriceLabel.text = [NSString stringWithFormat:@"%@",priceCount];
////    cell.creatorLabel.text = self.shopNames[indexPath.row];
//
//    cell.sandoNameLabel.text = self.sub[@"name"];
//    cell.sandoPriceLabel.text = [NSString stringWithFormat:@"%@",priceCount];
//
//

//    return cell;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
