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
@property NSArray *shopArray;
@property NSArray *sandoNames;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property Shop *shop;
@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

    Sando *sando = [Sando new];
    Shop *shop = [Shop new];

//    sando.name = @"BLT";
//    sando.price = @(2.34);

    [Sando queryForAllSandoWithCompletion:^(NSArray *array, NSError *error) {
        if (!error)
        {
            self.sandoNames = [NSArray arrayWithArray:array];
            [self.collectionView reloadData];
        }
        else
        {
            NSLog(@"Query Failed: %@", error.localizedDescription);
        }
    }];

    PFRelation *relation = [shop relationForKey:@"createdBy"];
    [relation addObject:sando];

    [sando saveInBackground];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.sandoNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    Sando *objectX = (Sando *)self.sandoNames[indexPath.item];

    NSString * nameX;
    nameX = objectX[@"name"];
    NSNumber * numberX;
    numberX = objectX[@"price"];

    cell.sandoNameLabel.text = nameX;
    cell.sandoPriceLabel.text = [NSString stringWithFormat:@"%@",numberX];

    //THIS IS THE IMAGE FEATURE,
    //    PFFile *sandoImage = object.pic;
    //    [sandoImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
    //    {
    //        UIImage *image = [UIImage imageWithData:data];
    //        cell.imageView.image = image;
    //    }];
    return cell;
}

@end
