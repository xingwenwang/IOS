//
//  XWTableViewCell.h
//  XWCustomShadow
//
//  Created by 王兴文 on 2019/2/14.
//  Copyright © 2019年 XingWenWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWOuterShadowView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet XWOuterShadowView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

NS_ASSUME_NONNULL_END
