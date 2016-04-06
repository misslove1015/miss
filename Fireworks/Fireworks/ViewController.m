//
//  ViewController.m
//  Fireworks
//
//  Created by miss on 16/1/21.
//  Copyright © 2016年 mukr. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor   = [UIColor blackColor];
    
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    snowEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width/2.0, -30);
    snowEmitter.emitterSize     = CGSizeMake(self.view.bounds.size.width*2.0, 0.0);
    snowEmitter.emitterMode     = kCAEmitterLayerOutline;
    snowEmitter.emitterShape    = kCAEmitterLayerLine;
    CAEmitterCell *snowflake    = [CAEmitterCell emitterCell];
    snowflake.scale             = 0.2;
    snowflake.scaleRange        = 0.5;
    snowflake.birthRate         = 20.0;
    snowflake.lifetime          = 30.0;
    snowflake.velocity          = 20;
    snowflake.velocityRange     = 10;
    snowflake.yAcceleration     = 2;
    snowflake.emissionRange     = 0.5 * M_PI;
    snowflake.spinRange         = 0.25 * M_PI;
    snowflake.contents          = (id)[[UIImage imageNamed:@"snow"] CGImage];
    snowflake.color             = [[UIColor colorWithRed:0.6 green:0.658 blue:0.743 alpha:1] CGColor];
    snowEmitter.shadowOpacity   = 1.0;
    snowEmitter.shadowRadius    = 0.0;
    snowEmitter.shadowOffset    = CGSizeMake(0.0, 1.0);
    snowEmitter.shadowColor     = [[UIColor whiteColor] CGColor];
    snowEmitter.emitterCells    = [NSArray arrayWithObject:snowflake];
    [self.view.layer addSublayer:snowEmitter];

    
    CAEmitterLayer *fireworksEmitter = [CAEmitterLayer layer];
    CGRect viewBounds                = self.view.layer.bounds;
    fireworksEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height);
    fireworksEmitter.emitterSize     = CGSizeMake(viewBounds.size.width/2.0, 0.0);
    fireworksEmitter.emitterMode     = kCAEmitterLayerOutline;
    fireworksEmitter.emitterShape    = kCAEmitterLayerLine;
    fireworksEmitter.renderMode      = kCAEmitterLayerAdditive;
    fireworksEmitter.seed            = (arc4random()%100)+1;
    CAEmitterCell  * rocket = [CAEmitterCell emitterCell];
    rocket.birthRate		= 5.0;
    rocket.emissionRange	= 0.25 * M_PI;
    rocket.velocity			= 380;
    rocket.velocityRange	= 380;
    rocket.yAcceleration	= 75;
    rocket.lifetime			= 1.02;
    rocket.contents			= (id) [[UIImage imageNamed:@"ball"] CGImage];
    rocket.scale			= 0.2;
    rocket.greenRange		= 1.0;
    rocket.redRange			= 1.0;
    rocket.blueRange		= 1.0;
    rocket.spinRange		= M_PI;

    CAEmitterCell  *  burst = [CAEmitterCell emitterCell];
    burst.birthRate			= 1.0;
    burst.velocity			= 0;
    burst.scale				= 2.5;
    burst.redSpeed			=-1.5;
    burst.blueSpeed			=+1.5;
    burst.greenSpeed		=+1.0;
    burst.lifetime			= 0.35;

    CAEmitterCell  *  spark = [CAEmitterCell emitterCell];
    spark.birthRate			= 400;
    spark.velocity			= 125;
    spark.emissionRange		= 2* M_PI;
    spark.yAcceleration		= 75;
    spark.lifetime			= 3;
    spark.contents			= (id) [[UIImage imageNamed:@"fire"] CGImage];
    spark.scale		        =0.5;
    spark.scaleSpeed		=-0.2;
    spark.greenSpeed		=-0.1;
    spark.redSpeed			= 0.4;
    spark.blueSpeed			=-0.1;
    spark.alphaSpeed		=-0.5;
    spark.spin				= 2* M_PI;
    spark.spinRange			= 2* M_PI;
    fireworksEmitter.emitterCells	= [NSArray arrayWithObject:rocket];
    rocket.emitterCells				= [NSArray arrayWithObject:burst];
    burst.emitterCells				= [NSArray arrayWithObject:spark];
    [self.view.layer addSublayer:fireworksEmitter];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
