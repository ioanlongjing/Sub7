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
    _subImageView.image = _capturedImage;
    
    
//    if (self.selectedShop.cashOnly) {
//        self.shopAcceptsCardsLabel.text = @"Not Accepting Credit Cards";
//    } else if (!self.selectedShop.cashOnly) {
//        self.shopAcceptsCardsLabel.text = @"Accepts Credit Cards";
//    }
    
    
}
- (IBAction)onSubmitButtonPressed:(UIButton *)sender {
    
    
    // convert image to JPEG and save suggested sub object
    NSData *data = UIImageJPEGRepresentation(_capturedImage, 0.5f);
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self.suggestedSub setObject:imageFile forKey:@"image"];
            [self.suggestedSub setObject:self.selectedShop forKey:@"shop"];
            [self.suggestedSub saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    NSLog(@"Saved");
                } else {
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
    }];
    
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
