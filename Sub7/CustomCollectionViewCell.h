//
//  CustomCollectionViewCell.h
//  Sub7
//
//  Created by Clint Chilcott on 2/10/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *sandoPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *sandoNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *creatorLabel;


@end
