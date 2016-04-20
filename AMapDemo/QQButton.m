//
//  QQButton.m
//  QQBtn
//
//  Created by MacBook on 15/6/25.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

#define kBtnWidth (self.bounds.size.width)
#define kBtnHeight self.bounds.size.height
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
#import "QQButton.h"

@interface QQButton()

/** 绘制不规则图形 */
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation QQButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
        
    }
    
    return self;
}

//- (void)awakeFromNib
//{
//    [self setUp];
//}

//- (void)layoutSubviews
//{
//    [self setUp];
//}

#pragma mark - 懒加载
- (CAShapeLayer *)shapeLayer
{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = self.backgroundColor.CGColor;
        [self.superview.layer insertSublayer:_shapeLayer below:self.layer];
    }
    
    return _shapeLayer;
}

- (UIView *)samllCircleView
{
    if (!_samllCircleView) {
        _samllCircleView = [[UIView alloc] init];
        _samllCircleView.backgroundColor = self.backgroundColor;
        [self.superview insertSubview:_samllCircleView belowSubview:self];
        
    }
    
    return _samllCircleView;
}

- (void)setUp
{
    [self setBackgroundColor:[UIColor colorWithRed:57.0/255.0 green:173.0/255.0 blue:37.0/255.0 alpha:1]];
    CGFloat cornerRadius = 0.15*SCREEN_WIDTH / 2.0;
//    CGFloat cornerRadius = (kBtnHeight > kBtnWidth ? kBtnWidth / 2.0 : kBtnHeight / 2.0);
//    NSLog(@"radius is %f",SCREEN_WIDTH);
    [self setTitle:@"100" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _maxDistance = cornerRadius * 4;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    
    CGRect samllCireleRect = CGRectMake(0, 0, cornerRadius * (2 - 1) , cornerRadius * (2 - 1));
    _samllCircleView.bounds = samllCireleRect;
    _samllCircleView.center = self.center;
    _samllCircleView.layer.cornerRadius = _samllCircleView.bounds.size.width / 2;
//    NSLog(@"big x:%f y:%f;small x:%f y:%f",self.center.x,self.center.y,_samllCircleView.center.x,_samllCircleView.center.y);
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    
}

#pragma mark - 手势
- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint panPoint = [pan translationInView:self];

    CGPoint changeCenter = self.center;
    changeCenter.x += panPoint.x;
    changeCenter.y += panPoint.y;
    self.center = changeCenter;
    [pan setTranslation:CGPointZero inView:self];
    
    //俩个圆的中心点之间的距离
    CGFloat dist = [self pointToPoitnDistanceWithPoint:self.center potintB:self.samllCircleView.center];
    NSLog(@"dist is %f",dist);
    if (dist < _maxDistance) {
        
//        CGFloat cornerRadius = (kBtnHeight > kBtnWidth ? kBtnWidth / 2 : kBtnHeight / 2);
        CGFloat cornerRadius = 0.15*SCREEN_WIDTH / 2.0;
        CGFloat samllCrecleRadius = cornerRadius - dist / 10;
        _samllCircleView.bounds = CGRectMake(0, 0, samllCrecleRadius * (2 - 1), samllCrecleRadius * (2 - 1));
        _samllCircleView.layer.cornerRadius = _samllCircleView.bounds.size.width / 2;
        
        if (_samllCircleView.hidden == NO && dist > 0) {
            //画不规则矩形
            self.shapeLayer.path = [self pathWithBigCirCleView:self smallCirCleView:_samllCircleView].CGPath;
        }
    } else {
        
        [self.shapeLayer removeFromSuperlayer];
        self.shapeLayer = nil;
        
        self.samllCircleView.hidden = YES;
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        if (dist > _maxDistance) {
            
//            //播放销毁动画
//            [self startDestroyAnimations];
//            
//            //销毁全部控件
//            [self killAll];
            self.samllCircleView.center = self.center;
            self.samllCircleView.hidden = NO;
            
//            if(self.shapeLayer){
//                NSLog(@"yes");
//            }
//            self.shapeLayer.path = [self pathWithBigCirCleView:self smallCirCleView:_samllCircleView].CGPath;
//            
        } else {
            
            [self.shapeLayer removeFromSuperlayer];
            self.shapeLayer = nil;
            
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.center = self.samllCircleView.center;
            } completion:^(BOOL finished) {
                self.samllCircleView.hidden = NO;
            }];
        }
    }
}

#pragma mark - 俩个圆心之间的距离
- (CGFloat)pointToPoitnDistanceWithPoint:(CGPoint)pointA potintB:(CGPoint)pointB
{
    CGFloat offestX = pointA.x - pointB.x;
    CGFloat offestY = pointA.y - pointB.y;
    CGFloat dist = sqrtf(offestX * offestX + offestY * offestY);
    
    return dist;
}


#pragma mark - 不规则路径
- (UIBezierPath *)pathWithBigCirCleView:(UIView *)bigCirCleView  smallCirCleView:(UIView *)smallCirCleView
{
    CGPoint bigCenter = bigCirCleView.center;
    CGFloat x2 = bigCenter.x;
    CGFloat y2 = bigCenter.y;
    CGFloat r2 = bigCirCleView.bounds.size.width / 2;
    
    CGPoint smallCenter = smallCirCleView.center;
    CGFloat x1 = smallCenter.x;
    CGFloat y1 = smallCenter.y;
    CGFloat r1 = smallCirCleView.bounds.size.width / 2;
    
    // 获取圆心距离
    CGFloat d = [self pointToPoitnDistanceWithPoint:self.samllCircleView.center potintB:self.center];
    CGFloat sinθ = (x2 - x1) / d;
    CGFloat cosθ = (y2 - y1) / d;
    
    // 坐标系基于父控件
    CGPoint pointA = CGPointMake(x1 - r1 * cosθ , y1 + r1 * sinθ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosθ , y1 - r1 * sinθ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosθ , y2 - r2 * sinθ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosθ , y2 + r2 * sinθ);
    CGPoint pointO = CGPointMake(pointA.x + d / 2 * sinθ , pointA.y + d / 2 * cosθ);
    CGPoint pointP = CGPointMake(pointB.x + d / 2 * sinθ , pointB.y + d / 2 * cosθ);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    // A
    [path moveToPoint:pointA];
    // AB
    [path addLineToPoint:pointB];
    // 绘制BC曲线
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    // CD
    [path addLineToPoint:pointD];
    // 绘制DA曲线
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    
    return path;
}


@end