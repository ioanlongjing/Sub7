//
//  DataEntryViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/12/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "ShopEditViewController.h"
#import "AllObjectsViewController.h"
#import "Sub.h"
#import "Bread.h"
#import "Cheese.h"
#import "Meat.h"
#import "Topping.h"

@interface ShopEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *shopNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *shopStreetTextField;
@property (weak, nonatomic) IBOutlet UITextField *shopCityTextField;
@property (weak, nonatomic) IBOutlet UITextField *shopStateTextField;
@property (weak, nonatomic) IBOutlet UITextField *shopZipTextField;
@property (weak, nonatomic) IBOutlet UITextField *shopPhoneTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *shopCashOnlySegControl;
@property NSArray *shopSubs;
@property NSArray *shopBreads;
@property NSArray *shopCheeses;
@property NSArray *shopMeats;
@property NSArray *shopToppings;


@end

@implementation ShopEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // dismiss keyboard when tapping outside of textfield
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    
    // Query for all Subs owned by Current Shop
    [Sub queryForSubsInShopWithCompletion:^(NSArray *resultsArray, NSError *error) {
        if (!error) {
            self.shopSubs = resultsArray;
            NSLog(@"%@", self.shopSubs);
        }
    } shop:self.selectedShop];
    
    // Query for all Breads owned by Current Shop
    [Bread queryForBreadsInShopWithCompletion:^(NSArray *resultsArray, NSError *error) {
        if (!error) {
            self.shopBreads = resultsArray;
            NSLog(@"%@", self.shopSubs);
        }
    } shop:self.selectedShop];
    
    // Query for all Cheeses owned by Current Shop
    [Cheese queryForCheesesInShopWithCompletion:^(NSArray *resultsArray, NSError *error) {
        if (!error) {
            self.shopCheeses = resultsArray;
            NSLog(@"%@", self.shopSubs);
        }
    } shop:self.selectedShop];
    
    // Query for all Meats owned by Current Shop
    [Meat queryForMeatsInShopWithCompletion:^(NSArray *resultsArray, NSError *error) {
        if (!error) {
            self.shopMeats = resultsArray;
            NSLog(@"%@", self.shopSubs);
        }
    } shop:self.selectedShop];
    
    // Query for all Toppings owned by Current Shop
    [Topping queryForToppingsInShopWithCompletion:^(NSArray *resultsArray, NSError *error) {
        if (!error) {
            self.shopToppings = resultsArray;
            NSLog(@"%@", self.shopSubs);
        }
    } shop:self.selectedShop];
    
    
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
    
//    PFObject *object = [PFObject objectWithClassName:@"Shop"];
    Shop *myShop = [Shop new];
    myShop = self.selectedShop;
    
    myShop.name = self.shopNameTextField.text;
    myShop.address = self.shopStreetTextField.text;
    myShop.city = self.shopCityTextField.text;
    myShop.state = self.shopStateTextField.text;
    myShop.zip = self.shopZipTextField.text;
    
    [myShop saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Saved shop!");
        } else if (!succeeded) {
            NSLog(@"%@", error);
        }
    }];
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    AllObjectsViewController *dvc = segue.destinationViewController;
    dvc.selectedShop = self.selectedShop;
    
    if ([segue.identifier isEqualToString:@"BreadSegue"]) {
        dvc.selectedClass = @"Bread";
//        dvc.classObjects = self.shopBreads;
    } else if ([segue.identifier isEqualToString:@"CheeseSegue"]) {
        dvc.selectedClass = @"Cheese";
//        dvc.classObjects = self.shopCheeses;
    } else if ([segue.identifier isEqualToString:@"ToppingSegue"]) {
        dvc.selectedClass = @"Topping";
//        dvc.classObjects = self.shopToppings;
    } else if ([segue.identifier isEqualToString:@"MeatSegue"]) {
        dvc.selectedClass = @"Meat";
//        dvc.classObjects = self.shopMeats;
    } else if ([segue.identifier isEqualToString:@"SubSegue"]) {
        dvc.selectedClass = @"Sub";
//        dvc.classObjects = self.shopSubs;
    }

}


@end
