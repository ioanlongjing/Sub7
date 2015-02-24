//
//  SuggestConfirmViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/24/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "SuggestConfirmViewController.h"

@interface SuggestConfirmViewController ()
@property (weak, nonatomic) IBOutlet UILabel *subNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *subImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopAcceptsCardsLabel;

@end

@implementation SuggestConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
}

- (void)viewDidAppear:(BOOL)animated {
    self.subNameLabel.text = self.suggestedSub.name;
    self.subPriceLabel.text = self.suggestedSub.price;
    //self.subImageView.image =
    
    self.shopNameLabel.text = self.selectedShop.name;
    self.shopAddressLabel.text = self.selectedShop.address;
    self.shopPhoneLabel.text = self.selectedShop.phone;
    
    if (self.selectedShop.cashOnly) {
        self.shopAcceptsCardsLabel.text = @"Not Accepting Credit Cards";
    } else if (!self.selectedShop.cashOnly) {
        self.shopAcceptsCardsLabel.text = @"Accepts Credit Cards";
    }
    
    
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
