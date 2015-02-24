//
//  SuggestShopViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/24/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "SuggestShopViewController.h"

@interface SuggestShopViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *shopNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *shopAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *shopPhoneTextField;
@property (weak, nonatomic) IBOutlet UISwitch *shopAcceptsCardsSwitch;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SuggestShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
