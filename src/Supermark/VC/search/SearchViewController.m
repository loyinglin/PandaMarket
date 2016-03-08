//
//  SearchViewController.m
//  Supermark
//
//  Created by 林伟池 on 15/8/14.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "SearchViewController.h"
#import "CartDetailCell.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.searchDisplayController.searchResultsTableView registerNib:[UINib nibWithNibName:@"CartDetailCell" bundle:nil] forCellReuseIdentifier:@"CartDetailCell"];

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

#pragma mark - view init

#pragma mark - ui

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* cellIdentifier = @"CartDetailCell";
    CartDetailCell* cell = (CartDetailCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell initViewWithIndex:(int)indexPath.row];

    return cell;    
}

#pragma mark - notify

@end
