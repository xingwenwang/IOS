//
//  XWOuterShadowLayer.h
//  XWCustomShadow
//
//  Created by 王兴文 on 2019/2/11.
//  Copyright © 2019年 XingWenWang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    WOuterShadow_Mask_None       = 0,
    WOuterShadow_Mask_Top        = 1 << 1,
    WOuterShadow_Mask_Bottom     = 1 << 2,
    WOuterShadow_Mask_Left       = 1 << 3,
    WOuterShadow_Mask_Right      = 1 << 4,
    WOuterShadow_Mask_Vertical   = WOuterShadow_Mask_Top | WOuterShadow_Mask_Bottom,
    WOuterShadow_Mask_Horizontal = WOuterShadow_Mask_Left | WOuterShadow_Mask_Right,
    WOuterShadow_Mask_All        = WOuterShadow_Mask_Vertical | WOuterShadow_Mask_Horizontal
} WOuterShadowMask;

typedef enum {
    WOuterShadow_Type_AllLine = 0,
    WOuterShadow_Type_AllCorner,
    WOuterShadow_Type_CornerLine
} WOuterShadowType;

@interface XWOuterShadowLayer : CAShapeLayer

@property (nonatomic) WOuterShadowMask shadowMask;
@property (nonatomic) WOuterShadowType shadowType;

@end

NS_ASSUME_NONNULL_END
