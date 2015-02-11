//
//  ViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/9/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "RootViewController.h"
#import "SandwichCollectionViewCell.h"
#import <Parse/Parse.h>


@interface RootViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property NSMutableArray *sandwichImages;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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


    
    //[self.collectionView setPagingEnabled:YES];



}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.sandwichImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SandwichCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.imageView.image = [self.sandwichImages objectAtIndex:indexPath.row];
    
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
