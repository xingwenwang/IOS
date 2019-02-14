//
//  XWOuterShadowView.m
//  XWCustomShadow
//
//  Created by 王兴文 on 2019/2/12.
//  Copyright © 2019年 XingWenWang. All rights reserved.
//

#import "XWOuterShadowView.h"
@interface XWOuterShadowView ()
{
    UIView * _shadowView;
}
@end
@implementation XWOuterShadowView
- (void)_init
{
    // add as sublayer so that self.backgroundColor will work nicely
    _outerShadowLayer = [XWOuterShadowLayer layer];
    
//    _outerShadowLayer.actions = [NSDictionary dictionaryWithObjectsAndKeys:
//                                 [NSNull null], @"position",
//                                 [NSNull null], @"bounds",
//                                 [NSNull null], @"contents",
//                                 [NSNull null], @"shadowColor",
//                                 [NSNull null], @"shadowOpacity",
//                                 [NSNull null], @"shadowOffset",
//                                 [NSNull null], @"shadowRadius",
//                                 nil];
//    [shadowView.layer addSublayer:_outerShadowLayer];
//    [self.layer addSublayer:_outerShadowLayer];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _shadowView= [[UIView alloc] init];
    _shadowView.backgroundColor = [UIColor clearColor];
    _shadowView.center = self.center;
    _shadowView.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.superview insertSubview:_shadowView belowSubview:self];
    [_shadowView.layer addSublayer:_outerShadowLayer];
    
    _outerShadowLayer.frame = _shadowView.layer.bounds;
    
    [self roundedCornersByRoundingCorners];
}
-(void)roundedCornersByRoundingCorners
{
    //设置切哪个直角
    //    UIRectCornerTopLeft     = 1 << 0,  左上角
    //    UIRectCornerTopRight    = 1 << 1,  右上角
    //    UIRectCornerBottomLeft  = 1 << 2,  左下角
    //    UIRectCornerBottomRight = 1 << 3,  右下角
    //    UIRectCornerAllCorners  = ~0UL     全部角
    if (self.shadowType == WOuterShadow_Type_CornerLine) {
        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRect:self.bounds];
        CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
        maskLayer1.frame = self.bounds;
        maskLayer1.path = maskPath1.CGPath;
        self.layer.mask = maskLayer1;
        
        UIRectCorner corners = 1000000;
        if ((self.shadowMask & WOuterShadow_Mask_Top) && (self.shadowMask & WOuterShadow_Mask_Left) && (self.shadowMask & WOuterShadow_Mask_Right)) {
            corners = (UIRectCornerTopLeft | UIRectCornerTopRight);
        }
        if ((self.shadowMask & WOuterShadow_Mask_Right) && (self.shadowMask & WOuterShadow_Mask_Top)  && (self.shadowMask & WOuterShadow_Mask_Bottom)) {
            corners = (UIRectCornerTopRight | UIRectCornerBottomRight);
        }
        if ((self.shadowMask & WOuterShadow_Mask_Bottom) && (self.shadowMask & WOuterShadow_Mask_Left) && (self.shadowMask & WOuterShadow_Mask_Right)) {
            corners = (UIRectCornerBottomLeft | UIRectCornerBottomRight);
        }
        if ((self.shadowMask & WOuterShadow_Mask_Left) && (self.shadowMask & WOuterShadow_Mask_Top)  && (self.shadowMask & WOuterShadow_Mask_Bottom)) {
            corners = (UIRectCornerTopLeft | UIRectCornerBottomLeft);
        }
        
        //得到view的遮罩路径
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(self.cornerRadius,self.cornerRadius)];
        //创建 layer
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        //赋值
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }else if (self.shadowType == WOuterShadow_Type_AllCorner)
    {
        //得到view的遮罩路径
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(self.cornerRadius,self.cornerRadius)];
        //创建 layer
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        //赋值
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }
}
#pragma mark Accessors

- (WOuterShadowMask)shadowMask
{
    return _outerShadowLayer.shadowMask;
}

- (void)setShadowMask:(WOuterShadowMask)shadowMask
{
    _outerShadowLayer.shadowMask = shadowMask;
    [self layoutSubviews];
}

-(WOuterShadowType)shadowType
{
    return _outerShadowLayer.shadowType;
}
-(void)setShadowType:(WOuterShadowType)shadowType
{
    _outerShadowLayer.shadowType = shadowType;
    if (shadowType == WOuterShadow_Type_AllLine) self.cornerRadius = 0.0;
    [self layoutSubviews];
}

- (UIColor *)shadowColor
{
    return [UIColor colorWithCGColor:_outerShadowLayer.shadowColor];
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    _outerShadowLayer.shadowColor = shadowColor.CGColor;
    [self layoutSubviews];
}

- (CGFloat)shadowOpacity
{
    return _outerShadowLayer.shadowOpacity;
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity
{
    _outerShadowLayer.shadowOpacity = shadowOpacity;
    [self layoutSubviews];
}

- (CGSize)shadowOffset
{
    return _outerShadowLayer.shadowOffset;
}

- (void)setShadowOffset:(CGSize)shadowOffset
{
    _outerShadowLayer.shadowOffset = shadowOffset;
    [self layoutSubviews];
}

- (CGFloat)shadowRadius
{
    return _outerShadowLayer.shadowRadius;
}

- (void)setShadowRadius:(CGFloat)shadowRadius
{
    _outerShadowLayer.shadowRadius = shadowRadius;
    [self layoutSubviews];
}

- (CGFloat)cornerRadius;
{
    return _outerShadowLayer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius;
{
    _outerShadowLayer.cornerRadius = cornerRadius-_outerShadowLayer.lineWidth/2.0;
    [self layoutSubviews];
}
@end
