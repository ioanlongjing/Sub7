//
//  SuggestSubViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/24/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "SuggestSubViewController.h"
#import "SuggestShopViewController.h"
#import "JPSImagePickerController.h"


@interface SuggestSubViewController () <JPSImagePickerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *subNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *subPriceTextField;
@property (weak, nonatomic) IBOutlet UIImageView *subImageView;
@property (weak, nonatomic) UIImage *capturedImage;


@end

@implementation SuggestSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // nice one liner to dismiss keyboard
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
    
    
}

- (IBAction)onAddPhotoButtonPressed:(UIButton *)sender {
    JPSImagePickerController *imagePicker = [[JPSImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}


// Called immediately after the picture was taken
- (void)picker:(JPSImagePickerController *)picker didTakePicture:(UIImage *)picture {
    
}

// Called immediately after the "Use" button was tapped
- (void)picker:(JPSImagePickerController *)picker didConfirmPicture:(UIImage *)picture {
    
   //FIXME add image crop and risize
    
    self.capturedImage = picture;
    
    self.subImageView.image = self.capturedImage;
    
    
    
}

// Called immediately after the "Cancel" button was tapped
- (void)pickerDidCancel:(JPSImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    SuggestShopViewController *dvc = segue.destinationViewController;
    self.suggestedSub.name = self.subNameTextField.text;
    
    // convert string to NSNumber
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *myNumber = [f numberFromString:self.subPriceTextField.text];
    
    self.suggestedSub.price = myNumber;
    
    dvc.suggestedSub = self.suggestedSub;
    dvc.selectedShop = [Shop new];
    dvc.capturedImage = self.capturedImage;
    
}

@end
