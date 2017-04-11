//
//  GuideViewController.m
//  百度地图_Demo
//
//  Created by 郭乐峰 on 2017/4/10.
//  Copyright © 2017年 niuniu. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()

@property (nonatomic, strong) NSArray *menuData;
@property (nonatomic, strong) NSArray *viewControllersData;
@end

@implementation GuideViewController

- (NSArray *)menuData {
    if (!_menuData) {
        _menuData = @[@"百度地图", @"高德地图"];
    }
    return _menuData;
}

- (NSArray *)viewControllersData {
    if (!_viewControllersData) {
        _viewControllersData = @[@"BaiduViewController", @"GaodeViewController"];
    }
    return _viewControllersData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"地图";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.menuData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.menuData[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", (long)indexPath.row);
    [self.navigationController pushViewController:[[NSClassFromString(self.viewControllersData[indexPath.row]) alloc] init] animated:YES];
}
@end
