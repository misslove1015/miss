//
//  ViewController.h
//  iOS8PushFix
//
//  Created by miss on 16/5/27.
//  Copyright © 2016年 mukr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

