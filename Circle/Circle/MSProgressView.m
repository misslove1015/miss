//
//  MSProgress.m
//  Circle
//
//  Created by miss on 16/5/26.
//  Copyright © 2016年 mukr. All rights reserved.
//

#import "MSProgressView.h"

#define angle2Arc(angle) (angle * M_PI /180)
//设置文字缩放比例
#define FontScale MIN(self.bounds.size.height, self.bounds.size.width)/100.f

@interface MSProgressView()

@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, assign) CGPoint circleCenter;
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, assign) CGFloat value;
@property (nonatomic, assign) CGFloat desValue;

@end

@implementation MSProgressView

- (instancetype)init{
    if (self = [super init]) {
        [self defaultColor];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self defaultColor];
    }
    return self;
}

- (instancetype)initWithLineColor:(UIColor*)lineColor
                       loopColor:(UIColor*)loopColor{
    if (self = [super init]) {
        self.lineColor = lineColor;
        self.loopColor = loopColor;
    }
    return self;
}

- (void)defaultColor{
    _lineColor = [UIColor redColor];
    _loopColor = [UIColor lightGrayColor];
}

- (void)drawRect:(CGRect)rect {
    
    _circleCenter = CGPointMake(rect.size.width*0.5 , rect.size.height*0.5 );
    
    CGFloat radius = MIN(rect.size.height, rect.size.width) * 0.5;
    
    //画内圆
    UIBezierPath* arc2 = [UIBezierPath bezierPathWithArcCenter:_circleCenter
                                                        radius:radius*0.9
                                                    startAngle:0
                                                      endAngle:2*M_PI
                                                     clockwise:YES];
    [arc2 setLineWidth:radius*0.15];
    [self.loopColor set];
    
    [arc2 stroke];
    
    //画弧线
    UIBezierPath* path = [UIBezierPath
                          bezierPathWithArcCenter:_circleCenter
                          radius:radius*0.9
                          startAngle:M_PI_2
                          endAngle:angle2Arc(self.angle)+M_PI_2
                          clockwise:YES];
    [self.lineColor set];
    [path setLineCapStyle:kCGLineCapRound];
    path.lineWidth = radius* 0.15;
    [path stroke];
    
    //    CGPoint StartCircleCenter  = CGPointMake(_circleCenter.x + radius*0.9 * cosf(M_PI_2),
    //                                             _circleCenter.y + radius*0.9 * sinf(M_PI_2));
    //    UIBezierPath* startCircle = [UIBezierPath
    //                                 bezierPathWithArcCenter:StartCircleCenter
    //                                 radius:radius*0.09
    //                                 startAngle:0
    //                                 endAngle:2*M_PI
    //                                 clockwise:YES];
    //
    // [startCircle fill];
    
    [self drawText];
    
    
}

- (void)drawText{
    NSMutableAttributedString* precentStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.0f%%",self.desValue]];
    NSRange precentRange = NSMakeRange(0, precentStr.string.length);
    [precentStr addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:15*FontScale]
                       range:precentRange];
    [precentStr addAttribute:NSForegroundColorAttributeName
                       value:self.percentColor
                       range:precentRange];
    
    CGRect precentRect = [precentStr boundingRectWithSize:self.bounds.size
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                                  context:nil];
    
    CGFloat precentX = _circleCenter.x - precentRect.size.width/2;
    CGFloat precentY = _circleCenter.y - precentRect.size.height/2;

    
    [precentStr drawAtPoint:CGPointMake(precentX, precentY)];
}



- (void)setPercent:(CGFloat)precent{
    if (precent>100) {
        precent = 100;
    }
    _percent = precent;
    
    if (self.animatable) {
        self.link.paused = NO;
    }else{
        _angle = _percent /100 * 360;
        _desValue = _percent;
        [self setNeedsDisplay];
    }
}


/**
 *  屏帧动画
 */
- (void)animateprecent{
    if (self.value < self.percent) {
        
        self.value ++;
        _desValue = _value;
        _angle = self.value /100 * 360;
        
        [self setNeedsDisplay];
    }else{
        self.link.paused = YES;
        self.value = 0;
    }
}



#pragma makr - 懒加载定时器
-(CADisplayLink *)link{
    if (_link == nil && self.animatable == YES) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(animateprecent)];
        _link.frameInterval = 1 ;
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _link;
}


- (UIColor*)percentColor{
    if (_percentColor == nil) {
        _percentColor = [UIColor lightGrayColor];
    }
    return _percentColor;
}

- (void)dealloc{
    [self.link invalidate];
    self.link = nil;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
