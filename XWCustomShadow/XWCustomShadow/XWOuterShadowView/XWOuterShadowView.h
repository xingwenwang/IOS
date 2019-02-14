//
//  XWOuterShadowView.h
//  XWCustomShadow
//
//  Created by 王兴文 on 2019/2/12.
//  Copyright © 2019年 XingWenWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWOuterShadowLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWOuterShadowView : UIView

@property (nonatomic, strong, readonly) XWOuterShadowLayer* outerShadowLayer;
@property (nonatomic) WOuterShadowMask shadowMask;
@property (nonatomic) WOuterShadowType shadowType;

@property (nonatomic, strong) UIColor* shadowColor;
@property (nonatomic, assign) CGFloat  shadowOpacity;
@property (nonatomic, assign) CGSize   shadowOffset;
@property (nonatomic, assign) CGFloat  shadowRadius;

@property (nonatomic, assign) CGFloat  cornerRadius;

@end

NS_ASSUME_NONNULL_END
