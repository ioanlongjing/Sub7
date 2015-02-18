//
//  HomeImageTableViewCell.h
//  Sub7
//
//  Created by Clint Chilcott on 2/17/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *sandwichImageView;
@property (weak, nonatomic) IBOutlet UILabel *subNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopLabel;

@end
