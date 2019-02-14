//
//  XWOuterShadowLayer.m
//  XWCustomShadow
//
//  Created by 王兴文 on 2019/2/11.
//  Copyright © 2019年 XingWenWang. All rights reserved.
//

#import "XWOuterShadowLayer.h"

@interface XWOuterShadowLayer ()
{
    UIBezierPath * _maskPath;
    
    CGFloat _radius;
    CGFloat _line_left;
    CGFloat _line_top;
    CGFloat _line_width;
    CGFloat _line_height;
}
@end

@implementation XWOuterShadowLayer
- (id)init
{
    self = [super init];
    if (self) {
        // Standard shadow stuff
        [self setFillColor:[[UIColor whiteColor] CGColor]];
        [self setStrokeColor:[[UIColor whiteColor] CGColor]];
        [self setLineWidth:1.0];
        [self setShadowColor:[[UIColor blackColor] CGColor]];
        [self setShadowOffset:CGSizeMake(0.0f, 0.0f)];
        [self setShadowOpacity:1.0f];
        [self setShadowRadius:5.0];
        
        self.shadowMask = WOuterShadow_Mask_All;
        self.shadowType = WOuterShadow_Type_AllLine;
    }
    return self;
}

- (void)layoutSublayers
{
    [super layoutSublayers];
    
    _radius = self.cornerRadius;
    _line_left = self.lineWidth/2.0;
    _line_top = _line_left;
    _line_width = self.bounds.size.width-_line_left;
    _line_height = self.bounds.size.height-_line_top;
    
    if (self.shadowType == WOuterShadow_Type_AllLine) {
        [self drawWithCornerOrLine];
    }else if (self.shadowType == WOuterShadow_Type_AllCorner)
    {
        [self drawWithCornerOrLine];
    }else if (self.shadowType == WOuterShadow_Type_CornerLine)
    {
        [self drawWithCornerAndLine];
    }
}
#pragma mark - 圆角或直线
-(void)drawWithCornerOrLine
{
    _maskPath = [UIBezierPath bezierPath];
    if (_shadowMask & WOuterShadow_Mask_Top) {
        _radius>0?[self topLeftArc]:[self topLeftRadius];        
        [self topLine];
        _radius>0?[self topRightArc]:[self topRightRadius];
    }
    
    if (_shadowMask & WOuterShadow_Mask_Right) {
        _radius>0?[self rightTopArc]:[self rightTopRadius];
        [self rightLine];
        _radius>0?[self rightBottomArc]:[self rightBottomRadius];
    }
    
    if (_shadowMask & WOuterShadow_Mask_Bottom) {
        _radius>0?[self bottomLeftArc]:[self bottomLeftRadius];
        [self bottomLine];
        _radius>0?[self bottomRightArc]:[self bottomRightRadius];
    }
    
    if (_shadowMask & WOuterShadow_Mask_Left) {
        _radius>0?[self leftTopArc]:[self leftTopRadius];
        [self leftLine];
        _radius>0?[self leftBottomArc]:[self leftBottomRadius];
    }
    self.path = _maskPath.CGPath;
}

#pragma mark - 圆角和线
-(void)drawWithCornerAndLine
{
    _maskPath = [UIBezierPath bezierPath];
    if (_shadowMask & WOuterShadow_Mask_Top) {
        (_shadowMask & WOuterShadow_Mask_Left)?[self topLeftArc]:[self topLeftRadius];
        [self topLine];
        (_shadowMask & WOuterShadow_Mask_Right)?[self topRightArc]:[self topRightRadius];
    }
    
    if (_shadowMask & WOuterShadow_Mask_Right) {
        (_shadowMask & WOuterShadow_Mask_Top)?[self rightTopArc]:[self rightTopRadius];
        [self rightLine];
        (_shadowMask & WOuterShadow_Mask_Bottom)?[self rightBottomArc]:[self rightBottomRadius];
    }
    
    if (_shadowMask & WOuterShadow_Mask_Bottom) {
        (_shadowMask & WOuterShadow_Mask_Left)?[self bottomLeftArc]:[self bottomLeftRadius];
        [self bottomLine];
        (_shadowMask & WOuterShadow_Mask_Right)?[self bottomRightArc]:[self bottomRightRadius];
    }
    
    if (_shadowMask & WOuterShadow_Mask_Left) {
        (_shadowMask & WOuterShadow_Mask_Top)?[self leftTopArc]:[self leftTopRadius];
        [self leftLine];
        (_shadowMask & WOuterShadow_Mask_Bottom)?[self leftBottomArc]:[self leftBottomRadius];
    }
    self.path = _maskPath.CGPath;
}

#pragma mark - 上
#pragma mark -top-left-radius-1
-(void)topLeftRadius
{
    [_maskPath moveToPoint:CGPointMake(0, _line_top)];
    [_maskPath addLineToPoint:CGPointMake(_radius+_line_left, _line_top)];
}
#pragma mark -top-left-arc-2
-(void)topLeftArc
{
    [_maskPath moveToPoint:CGPointMake(_radius+_line_left, _line_top)];
    [_maskPath addArcWithCenter:CGPointMake(_radius+_line_left, _radius+_line_top) radius:_radius startAngle:-M_PI/4.0*2.0 endAngle:-M_PI/4.0*3.0 clockwise:NO];
}
#pragma mark -top-line-3
-(void)topLine
{
    [_maskPath moveToPoint:CGPointMake(_radius+_line_left, _line_top)];
    [_maskPath addLineToPoint:CGPointMake(_line_width-_radius, _line_top)];
}
#pragma mark -top-right-radius-4
-(void)topRightRadius
{
    [_maskPath moveToPoint:CGPointMake(_line_width-_radius, _line_top)];
    [_maskPath addLineToPoint:CGPointMake(_line_width+_line_left, _line_top)];
}
#pragma mark -top-right-arc-5
-(void)topRightArc
{
    [_maskPath moveToPoint:CGPointMake(_line_width-_radius, _line_top)];
    [_maskPath addArcWithCenter:CGPointMake(_line_width-_radius, _radius+_line_top) radius:_radius startAngle:-M_PI/4.0*2.0 endAngle:-M_PI/4.0*1.0 clockwise:YES];
}

#pragma mark - 右
#pragma mark -right-top-radius-1
-(void)rightTopRadius
{
    [_maskPath moveToPoint:CGPointMake(_line_width, 0)];
    [_maskPath addLineToPoint:CGPointMake(_line_width, _radius+_line_top)];
}
#pragma mark -right-top-arc-2
-(void)rightTopArc
{
    [_maskPath moveToPoint:CGPointMake(_line_width, _radius+_line_top)];
    [_maskPath addArcWithCenter:CGPointMake(_line_width-_radius, _radius+_line_top) radius:_radius startAngle:0 endAngle:-M_PI/4.0*1.0 clockwise:NO];
}
#pragma mark -right-line-3
-(void)rightLine
{
    [_maskPath moveToPoint:CGPointMake(_line_width, _radius+_line_top)];
    [_maskPath addLineToPoint:CGPointMake(_line_width, _line_height-_radius)];
}
#pragma mark -right-bottom-radius-4
-(void)rightBottomRadius
{
    [_maskPath moveToPoint:CGPointMake(_line_width, _line_height-_radius)];
    [_maskPath addLineToPoint:CGPointMake(_line_width, _line_height+_line_top)];
}
#pragma mark -right-bottom-arc-5
-(void)rightBottomArc
{
    [_maskPath moveToPoint:CGPointMake(_line_width, _line_height-_radius)];
    [_maskPath addArcWithCenter:CGPointMake(_line_width-_radius, _line_height-_radius) radius:_radius startAngle:0 endAngle:M_PI/4.0*1.0 clockwise:YES];
}

#pragma mark - 下
#pragma mark -bottom-left-radius-1
-(void)bottomLeftRadius
{
    [_maskPath moveToPoint:CGPointMake(0, _line_height)];
    [_maskPath addLineToPoint:CGPointMake(_radius+_line_left, _line_height)];
}
#pragma mark -bottom-left-arc-2
-(void)bottomLeftArc
{
    [_maskPath moveToPoint:CGPointMake(_radius+_line_left, _line_height)];
    [_maskPath addArcWithCenter:CGPointMake(_radius+_line_left, _line_height-_radius) radius:_radius startAngle:M_PI/4.0*2.0 endAngle:M_PI/4.0*3.0 clockwise:YES];
}
#pragma mark -bottom-line-3
-(void)bottomLine
{
    [_maskPath moveToPoint:CGPointMake(_radius+_line_left, _line_height)];
    [_maskPath addLineToPoint:CGPointMake(_line_width-_radius, _line_height)];
}
#pragma mark -bottom-right-radius-4
-(void)bottomRightRadius
{
    [_maskPath moveToPoint:CGPointMake(_line_width-_radius, _line_height)];
    [_maskPath addLineToPoint:CGPointMake(_line_width+_line_left, _line_height)];
}
#pragma mark -bottom-right-arc-5
-(void)bottomRightArc
{
    [_maskPath moveToPoint:CGPointMake(_line_width-_radius, _line_height)];
    [_maskPath addArcWithCenter:CGPointMake(_line_width-_radius, _line_height-_radius) radius:_radius startAngle:M_PI/4.0*2.0 endAngle:M_PI/4.0*1.0 clockwise:NO];
}

#pragma mark - 左
#pragma mark -left-top-radius-1
-(void)leftTopRadius
{
    [_maskPath moveToPoint:CGPointMake(_line_left, 0)];
    [_maskPath addLineToPoint:CGPointMake(_line_left, _radius+_line_top)];
}
#pragma mark -left-top-arc-2
-(void)leftTopArc
{
    [_maskPath moveToPoint:CGPointMake(_line_left, _radius+_line_top)];
    [_maskPath addArcWithCenter:CGPointMake(_radius+_line_left, _radius+_line_top) radius:_radius startAngle:-M_PI endAngle:-M_PI/4.0*3.0 clockwise:YES];
}
#pragma mark -left-line-3
-(void)leftLine
{
    [_maskPath moveToPoint:CGPointMake(_line_left, _line_height-_radius)];
    [_maskPath addLineToPoint:CGPointMake(_line_left, _radius+_line_top)];
}
#pragma mark -left-bottom-radius-4
-(void)leftBottomRadius
{
    [_maskPath moveToPoint:CGPointMake(_line_left, _line_height-_radius)];
    [_maskPath addLineToPoint:CGPointMake(_line_left, _line_height+_line_top)];
}
#pragma mark -left-bottom-arc-5
-(void)leftBottomArc
{
    [_maskPath moveToPoint:CGPointMake(_line_left, _line_height-_radius)];
    [_maskPath addArcWithCenter:CGPointMake(_radius+_line_left, _line_height-_radius) radius:_radius startAngle:-M_PI endAngle:M_PI/4.0*3.0 clockwise:NO];
}

#pragma mark Accessors
- (void)setShadowMask:(WOuterShadowMask)shadowMask
{
    _shadowMask = shadowMask;
    [self setNeedsLayout];
}

- (void)setShadowColor:(CGColorRef)shadowColor
{
    [super setShadowColor:shadowColor];
    [self setNeedsLayout];
}

- (void)setShadowOpacity:(float)shadowOpacity
{
    [super setShadowOpacity:shadowOpacity];
    [self setNeedsLayout];
}

- (void)setShadowOffset:(CGSize)shadowOffset
{
    [super setShadowOffset:shadowOffset];
    [self setNeedsLayout];
}

- (void)setShadowRadius:(CGFloat)shadowRadius
{
    [super setShadowRadius:shadowRadius];
    [self setNeedsLayout];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    [super setCornerRadius:cornerRadius];
    [self setNeedsLayout];
}


/*
 #pragma mark - 线
 -(void)drawWithLine
 {
 CGFloat line_left = self.lineWidth/2.0;
 CGFloat line_top = line_left;
 CGFloat line_width = self.bounds.size.width;
 CGFloat line_height = self.bounds.size.height;
 UIBezierPath * maskPath = [UIBezierPath bezierPath];
 
 if (_shadowMask & WOuterShadow_Mask_Top) {
 [maskPath moveToPoint:CGPointMake(0, line_top)];
 [maskPath addLineToPoint:CGPointMake(line_width, line_top)];
 }
 
 if (_shadowMask & WOuterShadow_Mask_Right) {
 [maskPath moveToPoint:CGPointMake(line_width-line_left, line_top)];
 [maskPath addLineToPoint:CGPointMake(line_width-line_left, line_height)];
 }
 
 if (_shadowMask & WOuterShadow_Mask_Bottom) {
 [maskPath moveToPoint:CGPointMake(line_width, line_height-line_top)];
 [maskPath addLineToPoint:CGPointMake(0, line_height-line_top)];
 }
 
 if (_shadowMask & WOuterShadow_Mask_Left) {
 [maskPath moveToPoint:CGPointMake(line_left, line_height)];
 [maskPath addLineToPoint:CGPointMake(line_left, 0)];
 }
 self.path = maskPath.CGPath;
 }
 #pragma mark - 圆角
 -(void)drawWithCorner
 {
 CGFloat radius = self.cornerRadius;
 CGFloat line_left = self.lineWidth/2.0;
 CGFloat line_top = line_left;
 CGFloat line_width = self.bounds.size.width-line_left;
 CGFloat line_height = self.bounds.size.height-line_top;
 UIBezierPath * maskPath = [UIBezierPath bezierPath];
 
 if (_shadowMask & WOuterShadow_Mask_Top) {
 [maskPath moveToPoint:CGPointMake(radius+line_left, line_top)];
 [maskPath addArcWithCenter:CGPointMake(radius+line_left, radius+line_top) radius:radius startAngle:-M_PI/4.0*2.0 endAngle:-M_PI/4.0*3.0 clockwise:NO];
 
 [maskPath moveToPoint:CGPointMake(radius+line_left, line_top)];
 [maskPath addLineToPoint:CGPointMake(line_width-radius, line_top)];
 
 [maskPath moveToPoint:CGPointMake(line_width-radius, line_top)];
 [maskPath addArcWithCenter:CGPointMake(line_width-radius, radius+line_top) radius:radius startAngle:-M_PI/4.0*2.0 endAngle:-M_PI/4.0*1.0 clockwise:YES];
 }
 
 if (_shadowMask & WOuterShadow_Mask_Right) {
 [maskPath moveToPoint:CGPointMake(line_width, radius+line_top)];
 [maskPath addArcWithCenter:CGPointMake(line_width-radius, radius+line_top) radius:radius startAngle:0 endAngle:-M_PI/4.0*1.0 clockwise:NO];
 
 [maskPath moveToPoint:CGPointMake(line_width, radius+line_top)];
 [maskPath addLineToPoint:CGPointMake(line_width, line_height-radius)];
 
 [maskPath moveToPoint:CGPointMake(line_width, line_height-radius)];
 [maskPath addArcWithCenter:CGPointMake(line_width-radius, line_height-radius) radius:radius startAngle:0 endAngle:M_PI/4.0*1.0 clockwise:YES];
 }
 
 if (_shadowMask & WOuterShadow_Mask_Bottom) {
 [maskPath moveToPoint:CGPointMake(radius+line_left, line_height)];
 [maskPath addArcWithCenter:CGPointMake(radius+line_left, line_height-radius) radius:radius startAngle:M_PI/4.0*2.0 endAngle:M_PI/4.0*3.0 clockwise:YES];
 
 [maskPath moveToPoint:CGPointMake(radius+line_left, line_height)];
 [maskPath addLineToPoint:CGPointMake(line_width-radius, line_height)];
 
 [maskPath moveToPoint:CGPointMake(line_width-radius, line_height)];
 [maskPath addArcWithCenter:CGPointMake(line_width-radius, line_height-radius) radius:radius startAngle:M_PI/4.0*2.0 endAngle:M_PI/4.0*1.0 clockwise:NO];
 }
 
 if (_shadowMask & WOuterShadow_Mask_Left) {
 [maskPath moveToPoint:CGPointMake(line_left, line_height-radius)];
 [maskPath addArcWithCenter:CGPointMake(radius+line_left, line_height-radius) radius:radius startAngle:-M_PI endAngle:M_PI/4.0*3.0 clockwise:NO];
 
 [maskPath moveToPoint:CGPointMake(line_left, line_height-radius)];
 [maskPath addLineToPoint:CGPointMake(line_left, radius+line_top)];
 
 [maskPath moveToPoint:CGPointMake(line_left, radius+line_top)];
 [maskPath addArcWithCenter:CGPointMake(radius+line_left, radius+line_top) radius:radius startAngle:-M_PI endAngle:-M_PI/4.0*3.0 clockwise:YES];
 }
 self.path = maskPath.CGPath;
 }
 */

@end
