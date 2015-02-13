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
#import "Sando.h"
#import "Shop.h"


@interface RootViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property NSMutableArray *sandwichImages;
@property NSMutableArray *shopNames;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//@property Sando *sando;
//@property Shop *shop;
//@property PFObject *sub;
@property NSArray *subs;
@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.subs = [Shop queryForAllShopsWithCompletion];
    [Shop queryForAllShopsWithCompletion:^(NSArray *resultsArray, NSError *error) {
        if (!error) {
            self.subs = resultsArray;
        }
    }];
    
//    
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

//    Sando *sando = [Sando object];
//    Shop *shop = [Shop object];
//
//    self.sub = [PFObject objectWithClassName:@"Sando"];
//    self.sub[@"name"] = @"BLT";
//    self.sub[@"price"] = @234;


//    PFRelation *relation = [shop relationForKey:@"createdBy"];
//    [relation addObject:sando];
//
//    [self.sub saveInBackground];
//    PFQuery *query = [Sando query];
//    [query whereKey:@"createdBy" equalTo:self.shop.name];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
//     {
//         for (Shop *shop in objects)
//         {
//             [self.shopNames addObject:shop];
//         }
//         [self.collectionView reloadData];
//     }];
//    [sando saveInBackground];

        //[self.collectionView setPagingEnabled:YES];

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.sandwichImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    //cell.imageView.image = [self.sandwichImages objectAtIndex:indexPath.row];
    NSNumber *priceCount = self.sub[@"price"];

    PFFile *sandoImage = [self.sando objectForKey:@"image"];
    [sandoImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
    {
        UIImage *image = [UIImage imageWithData:data];
        cell.imageView.image = image;
    }];

//    cell.sandoNameLabel.text = self.sando.name;
//    cell.sandoPriceLabel.text = [NSString stringWithFormat:@"%@",priceCount];
//    cell.creatorLabel.text = self.shopNames[indexPath.row];

    cell.sandoNameLabel.text = self.sub[@"name"];
    cell.sandoPriceLabel.text = [NSString stringWithFormat:@"%@",priceCount];

    [self.sub saveInBackground];

    return cell;
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self performSegueWithIdentifier:@"DetailSegue" sender:self];
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
