//
//  AllShopsViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/18/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "AllShopsViewController.h"
#import "Shop.h"
#import "ShopEditViewController.h"

@interface AllShopsViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSArray *allShops;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation AllShopsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [Shop queryForAllShopsWithCompletion:^(NSArray *resultsArray, NSError *error) {
        self.allShops = resultsArray;
        [self.tableView reloadData];
        NSLog(@"%@", self.allShops);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    ShopEditViewController *dvc = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"SelectedShop"]){
        dvc.selectedShop = [self.allShops objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    } else if ([segue.identifier isEqualToString:@"AddShop"]) {
        dvc.selectedShop = [Shop new];
    }
    
}


#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allShops.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Shop *currentShop = [self.allShops objectAtIndex:indexPath.row];
    cell.textLabel.text = currentShop.name;
    cell.detailTextLabel.text = currentShop.address;
    
    return cell;
}


@end
