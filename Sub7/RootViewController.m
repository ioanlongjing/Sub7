//
//  ViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/9/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "RootViewController.h"
#import <Parse/Parse.h>
#import "Sando.h"
#import "Shop.h"

@interface RootViewController ()
@property NSMutableArray *shopNames;
@property NSArray *shopArray;
@property NSArray *sandoObject;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property Sando *sando;
@property Shop *shop;
@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    Sando *sando = [Sando object];
    Shop *shop = [Shop object];

    PFRelation *relation = [shop relationForKey:@"createdBy"];
    [relation addObject:sando];

    [Sando queryForAllSandoWithCompletion:^(NSArray *array, NSError *error) {
        if (!error)
        {
            self.sandoObject = [NSArray arrayWithArray:array];
            [self.collectionView reloadData];
        }
        else
        {
            NSLog(@"Query Failed %@", error.localizedDescription);
        }
            }];

    [sando saveInBackground];
}
#pragma mark - Print Parse Objects
//    Sando *objectX = (Sando *)self.sandoObject[indexPath.item];
//
//    NSString * nameX;
//    nameX = objectX[@"name"];
//    NSNumber * numberX;
//    numberX = objectX[@"price"];
//
//    cell.sandoNameLabel.text = nameX;
//    cell.sandoPriceLabel.text = [NSString stringWithFormat:@"%@",numberX];
//
//    //THIS IS THE IMAGE FEATURE,
//    //    PFFile *sandoImage = object.pic;
//    //    [sandoImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
//    //    {
//    //        UIImage *image = [UIImage imageWithData:data];
//    //        cell.imageView.image = image;
//    //    }];



@end
