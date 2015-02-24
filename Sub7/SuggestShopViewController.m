//
//  SuggestShopViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/24/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "SuggestShopViewController.h"
#import "SuggestConfirmViewController.h"

@interface SuggestShopViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *shopNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *shopAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *shopPhoneTextField;
@property (weak, nonatomic) IBOutlet UISwitch *shopAcceptsCardsSwitch;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *allShops;

@end

@implementation SuggestShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [Shop queryForAllShopsWithCompletion:^(NSArray *resultsArray, NSError *error) {
        if (!error) {
            self.allShops = resultsArray;
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    self.selectedShop.name = self.shopNameTextField.text;
    self.selectedShop.address = self.shopNameTextField.text;
    self.selectedShop.phone = self.shopNameTextField.text;
    
    
    if (self.shopAcceptsCardsSwitch) {
        // if shop accepts credit cards it is not cashOnly
        self.selectedShop.cashOnly = NO;
    } else if (!self.shopAcceptsCardsSwitch) {
        // if shop does NOT accept credit cards it is cashOnly
        self.selectedShop.cashOnly = YES;
    }
    
    
    SuggestShopViewController *dvc = segue.destinationViewController;
    dvc.suggestedSub = self.suggestedSub;
    dvc.selectedShop = self.selectedShop;
    
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
