//
//  ViewController.m
//  折叠
//
//  Created by zr on 16/10/13.
//  Copyright © 2016年 zr. All rights reserved.
//

#import "ViewController.h"
#import "Group.h"
#import "groupModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *TBView;
    NSMutableArray *DataSouse;
    NSMutableArray *groups;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self readGroupData];
    [self CreateTBView];
}
//读取组信息
- (void)readGroupData
{
    groupModel *model = [[groupModel alloc]init];
    model.name = @"数学";
    model.time = @"星期四";
    DataSouse = [[NSMutableArray alloc]init];
    [DataSouse addObject:model];
    
    groups = [[NSMutableArray alloc]init];
    for (int i = 0; i<[DataSouse count]; i++) {
        Group *group = [[Group alloc]init];
        group.isOpen = NO;
        groupModel *model1 = DataSouse[i];
        group.groupName = model1.name;
        //添加数据源
        [groups addObject:group];
    }
}
-(void)CreateTBView
{
    TBView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    TBView.delegate  = self;
    TBView.dataSource = self;
    [self.view addSubview:TBView];
    [TBView registerClass:[UITableViewCell class]forCellReuseIdentifier:@"cell"];

}


#pragma mark - ===============================协议代理=======================================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return groups.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //组
    Group *group = groups[section];
    //当前组是打开
    if (group.isOpen)
    {
        return 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor lightGrayColor];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //组的信息
    Group *group = groups[section];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = section + 1;
    
    UILabel *spl = [[UILabel alloc]initWithFrame:CGRectMake(0,43.5 , self.view.frame.size.width, 0.5)];
    spl.backgroundColor = [UIColor lightGrayColor];
    [button addSubview:spl];
    
    //箭头
    UIImageView *arrowImageView = [[UIImageView alloc]init];
    [button addSubview:arrowImageView];
    if (group.isOpen)
    {
        arrowImageView.frame = CGRectMake(self.view.frame.size.width -23, 20, 13, 8);
        arrowImageView.image = [UIImage imageNamed:@"medown1"];
    }
    else
    {
        arrowImageView.frame = CGRectMake(self.view.frame.size.width -23, 20, 10, 13);
        arrowImageView.image = [UIImage imageNamed:@"next"];
    }
    

    return button;
}
#pragma mark - ===============打开／关闭组
-(void)btnClick:(UIButton*)sender
{
    //取组的信息
    Group *group = groups[sender.tag - 1];
    
    //打开
    if (group.isOpen)
    {
        group.isOpen = NO;
    }
    else //闭合
    {
        group.isOpen = YES;
    }
    
    //刷新当前分区
    [TBView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag - 1] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
