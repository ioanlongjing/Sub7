//
//  SuggestSubViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/24/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "SuggestSubViewController.h"

@interface SuggestSubViewController ()
@property (weak, nonatomic) IBOutlet UITextField *subNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *subPriceTextField;
@property (weak, nonatomic) IBOutlet UIImageView *subImageView;

@end

@implementation SuggestSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)onAddPhotoButtonPressed:(UIButton *)sender {
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
