//
//  ViewController.m
//  iOS8PushFix
//
//  Created by miss on 16/5/27.
//  Copyright © 2016年 mukr. All rights reserved.
//

#import "ViewController.h"
#import "PushFixTableViewCell.h"
#import "UITableView+MISSPushFix.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PushFixTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.rowNumberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    if (![tableView ky_isEstimatedRowHeightInCache:indexPath]) {
        CGSize cellSize = [cell systemLayoutSizeFittingSize:CGSizeMake(self.view.frame.size.width, 0) withHorizontalFittingPriority:1000.0 verticalFittingPriority:50.0];
        [tableView ky_putEstimatedCellHeightToCache:indexPath height:cellSize.height];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView ky_getEstimatedCellHeightFromCache:indexPath defaultHeight:100];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
