//
//  MSProgress.h
//  Circle
//
//  Created by miss on 16/5/26.
//  Copyright © 2016年 mukr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSProgressView : UIView

- (instancetype)initWithLineColor:(UIColor *)lineColor
                        loopColor:(UIColor *)loopColor;
@property (nonatomic, assign)CGFloat percent;
@property (nonatomic, strong)UIColor *percentColor;
@property (nonatomic, strong)UIColor *lineColor;
@property (nonatomic, strong)UIColor *loopColor;
@property (nonatomic, assign, getter=isAnimatable)BOOL animatable;
@end
