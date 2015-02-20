//
//  AllSubsViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/19/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "AllSubsViewController.h"
#import "Sub.h"

@interface AllSubsViewController () <UITableViewDelegate, UITableViewDataSource>
@property NSMutableArray *selectedSubs;
@end

@implementation AllSubsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selectedSubs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Sub *currentSub = [self.selectedSubs objectAtIndex:indexPath.row];
    cell.textLabel.text = currentSub.name;
    NSArray *stockIngredients = currentSub.stockIngredients;
    
    NSString *ingredientsString;
    for (NSString *string in stockIngredients) {
        ingredientsString = [ingredientsString stringByAppendingString:[NSString stringWithFormat:@"%@ ", string]];
    }
    cell.detailTextLabel.text = ingredientsString;
    
    return cell;
}



@end
