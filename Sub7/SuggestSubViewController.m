//
//  SuggestSubViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/24/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "SuggestSubViewController.h"
#import "SuggestShopViewController.h"

@interface SuggestSubViewController ()
@property (weak, nonatomic) IBOutlet UITextField *subNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *subPriceTextField;
@property (weak, nonatomic) IBOutlet UIImageView *subImageView;

@end

@implementation SuggestSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
}
- (IBAction)onAddPhotoButtonPressed:(UIButton *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    SuggestShopViewController *dvc = segue.destinationViewController;
    self.suggestedSub.name = self.subNameTextField.text;
    self.suggestedSub.price = self.subPriceTextField.text;
//    self.suggestedSub.imageFile
    
    dvc.suggestedSub = self.suggestedSub;
    dvc.selectedShop = [Shop new];
    
}

@end
