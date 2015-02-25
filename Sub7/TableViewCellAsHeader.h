//
//  TableViewCellAsHeader.h
//  Sub7
//
//  Created by Clint Chilcott on 2/25/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCellAsHeader : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
