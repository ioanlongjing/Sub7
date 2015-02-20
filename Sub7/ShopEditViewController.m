//
//  DataEntryViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/12/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "ShopEditViewController.h"
#import "AllSubsViewController.h"

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
    
    if (self.selectedShop) {
        self.shopNameTextField.text = self.selectedShop.name;
        self.shopStreetTextField.text = self.selectedShop.address;
        self.shopCityTextField.text = self.selectedShop.city;
        self.shopStateTextField.text = self.selectedShop.state;
        self.shopZipTextField.text = [NSString stringWithFormat:@"%@", self.selectedShop.zip];
        
//        if (self.selectedShop.cashOnly == nil) {
//            // nil means unknown, set to the third segment, seg 2
//            self.shopCashOnlySegControl.selectedSegmentIndex = 2;
//        } else if (self.selectedShop.cashOnly == NO) {
//            self.shopCashOnlySegControl.selectedSegmentIndex = 1;
//        } else if (self.selectedShop.cashOnly == YES) {
//            self.shopCashOnlySegControl.selectedSegmentIndex = 0;
//        }
        
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSaveButtonPressed:(id)sender {
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    AllSubsViewController *dvc = segue.destinationViewController;
    
    dvc.selectedShop = self.selectedShop;

}


@end
