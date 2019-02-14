//
//  ViewController.m
//  XWCustomShadow
//
//  Created by 王兴文 on 2019/2/13.
//  Copyright © 2019年 XingWenWang. All rights reserved.
//

#import "ViewController.h"
#import "XWOuterShadowView.h"
#import "XWTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong)NSArray *infoArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor =[UIColor yellowColor];
//
    
    _infoArr =[NSArray arrayWithObjects:
               @"三字经",
               @"人之初，性本善。性相近，习相远。",
               @"苟不教，性乃迁。教之道，贵以专。",
               @"昔孟母，择邻处。子不学，断机杼。",
               @"窦燕山，有义方。教五子，名俱扬。",
               @"养不教，父之过。教不严，师之惰。",
               @"子不学，非所宜。幼不学，老何为。",
               @"玉不琢，不成器。人不学，不知义。\n为人子，方少时。亲师友，习礼仪。\n香九龄，能温席。孝于亲，所当执。\n融四岁，能让梨。弟于长，宜先知。",
               @"首孝悌，次见闻。知某数，识某文。\n一而十，十而百。百而千，千而万。\n三才者，天地人。三光者，日月星。\n三纲者，君臣义。父子亲，夫妇顺。\n曰春夏，曰秋冬。此四时，运不穷。",
               nil];
    [self myTableView];
    
//    [self loadWCustomShadow];
}



#pragma mark- 初始界面Table
-(UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _myTableView.estimatedRowHeight = 400;
        _myTableView.rowHeight = UITableViewAutomaticDimension;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.delegate=self;
        _myTableView.dataSource=self;
        _myTableView.estimatedSectionFooterHeight=0;
        _myTableView.estimatedSectionHeaderHeight=0;
        [self.view addSubview:_myTableView];
        [_myTableView registerNib:[UINib nibWithNibName:@"XWTableViewCell" bundle:nil] forCellReuseIdentifier:@"XWTableViewCellID"];
    }
    return _myTableView;
}
#pragma mark- UITableViewDelegate,UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _infoArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XWTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"XWTableViewCellID"];
    cell.nameLabel.text = _infoArr[indexPath.section];
    
    cell.shadowView.backgroundColor = [UIColor whiteColor];
//    cell.shadowView.backgroundColor = [UIColor clearColor];
    cell.shadowView.cornerRadius = 10.0;
    cell.shadowView.shadowColor = [UIColor redColor];
    cell.shadowView.shadowType = WOuterShadow_Type_CornerLine;
    cell.shadowView.shadowMask = WOuterShadow_Mask_Horizontal;
    if (indexPath.section == 0) cell.shadowView.shadowMask = WOuterShadow_Mask_Top|WOuterShadow_Mask_Horizontal;
    if (indexPath.section == _infoArr.count-1) cell.shadowView.shadowMask = WOuterShadow_Mask_Bottom|WOuterShadow_Mask_Horizontal;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)loadWCustomShadow
{
    XWOuterShadowView *showView =[[XWOuterShadowView alloc]init];
    showView.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
    showView.bounds =CGRectMake(0, 0, self.view.frame.size.width/2.0, self.view.frame.size.height/3.0);
    showView.backgroundColor = [UIColor yellowColor];
//    showView.backgroundColor = [UIColor clearColor];
    showView.cornerRadius = 16.0;
    showView.shadowColor = [UIColor redColor];
    showView.shadowType = WOuterShadow_Type_CornerLine;
    showView.shadowMask = WOuterShadow_Mask_Vertical|WOuterShadow_Mask_Left;
    [self.view addSubview:showView];
    //    [showView.outerShadowLayer addShadowColor:[UIColor redColor]];
    
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, showView.frame.size.width, showView.frame.size.height)];
    //    label.text = @"Hello World!";
    //    label.backgroundColor =[UIColor blueColor];
    [label sizeToFit];
    [showView addSubview:label];
}


@end
