//
//  XWTableViewCell.m
//  XWCustomShadow
//
//  Created by 王兴文 on 2019/2/14.
//  Copyright © 2019年 XingWenWang. All rights reserved.
//

#import "XWTableViewCell.h"

@implementation XWTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
//    _shadowView.cornerRadius = 10.0;
//    _shadowView.shadowColor = [UIColor redColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
