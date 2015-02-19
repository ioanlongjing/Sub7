//
//  DataEntryViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/12/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "ShopEditViewController.h"

@interface ShopEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *shopNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *shopStreetTextField;
@property (weak, nonatomic) IBOutlet UITextField *shopCityTextField;
@property (weak, nonatomic) IBOutlet UITextField *shopStateTextField;
@property (weak, nonatomic) IBOutlet UITextField *shopZipTextField;
@property (weak, nonatomic) IBOutlet UITextField *shopPhoneTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *shopCashOnlySegControl;

@end

@implementation ShopEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)viewDidAppear:(BOOL)animated {
//    self.selectedShop.name
//    self.selectedShop.address
//    self.selectedShop.city
//    self.selectedShop.state
//    self.selectedShop.zip
//    self.selectedShop.cashOnly
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSaveButtonPressed:(id)sender {
}


@end
