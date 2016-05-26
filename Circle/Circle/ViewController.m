//
//  ViewController.m
//  Circle
//
//  Created by miss on 16/5/26.
//  Copyright © 2016年 mukr. All rights reserved.
//

#import "ViewController.h"
#import "MSProgressView.h"
@interface ViewController ()
@property (nonatomic,strong)MSProgressView *myProgressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MSProgressView *progress = [[MSProgressView alloc]initWithLineColor:[UIColor redColor] loopColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]];
    self.myProgressView = progress;
    progress.frame = CGRectMake(60, 100, 200, 200);
    progress.animatable = YES;
    progress.percent = 50;
    progress.backgroundColor = [UIColor clearColor];

    [self.view addSubview:progress];

}
- (IBAction)randomTest:(id)sender {
    self.myProgressView.percent = arc4random_uniform(101);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
