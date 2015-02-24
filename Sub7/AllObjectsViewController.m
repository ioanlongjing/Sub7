//
//  AllSubsViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/19/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "AllObjectsViewController.h"
#import "Sub.h"
#import "Bread.h"
#import "Cheese.h"
#import "Meat.h"
#import "Topping.h"
#import "IngredientProtocol.h"

@interface AllObjectsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end



@implementation AllObjectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self.tableView reloadData];
    
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
    return self.classObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    id<IngredientProtocol> currentObject = [self.classObjects objectAtIndex:indexPath.row];
    
//    if ([self.selectedClass isEqualToString:@"BreadSegue"]) {
//        Bread *curentObject = [self.classObjects objectAtIndex:indexPath.row];
//        cell.textLabel.text = curentObject.name;
//    } else if ([self.selectedClass isEqualToString:@"CheeseSegue"]) {
//        Cheese *curentObject = [self.classObjects objectAtIndex:indexPath.row];
//        cell.textLabel.text = curentObject.name;
//    } else if ([self.selectedClass isEqualToString:@"ToppingSegue"]) {
//        Topping *curentObject = [self.classObjects objectAtIndex:indexPath.row];
//        cell.textLabel.text = curentObject.name;
//    } else if ([self.selectedClass isEqualToString:@"MeatSegue"]) {
//        Meat *curentObject = [self.classObjects objectAtIndex:indexPath.row];
//        cell.textLabel.text = curentObject.name;
//    } else if ([self.selectedClass isEqualToString:@"SubSegue"]) {
//        Sub *curentObject = [self.classObjects objectAtIndex:indexPath.row];
//        cell.textLabel.text = curentObject.name;
//    }
    
    
    cell.textLabel.text = currentObject.name;
    
//    NSArray *stockIngredients = currentSub.stockIngredients;
//    
//    NSString *ingredientsString;
//    for (NSString *string in stockIngredients) {
//        ingredientsString = [ingredientsString stringByAppendingString:[NSString stringWithFormat:@"%@ ", string]];
//    }
//    cell.detailTextLabel.text = ingredientsString;
    
    return cell;
}



@end
