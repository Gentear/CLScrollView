//
//  CLMytableView.m
//  网易滚动视图
//
//  Created by zyyt on 16/5/9.
//  Copyright © 2016年 丛蕾. All rights reserved.
//
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenBounds [UIScreen mainScreen].bounds
#import "CLMytableView.h"
#import "MJRefresh.h"
@interface CLMytableView()<UITableViewDataSource,UITableViewDelegate>
@property (assign,nonatomic) NSInteger index;

@end
@implementation CLMytableView

- (instancetype)init{
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
        [self creatUI];
    }
    return self;
}
- (void)willMoveToSuperview:(UIView *)newSuperview{
    self.frame = CGRectMake(0, 108, ScreenWidth, ScreenHeight - 108);
}
- (void)creatUI{
    self.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.index = 80;
        [self reloadData];
//        [self.mj_header endRefreshing];
    }];
    [self.mj_header beginRefreshing];
    self.mj_footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
     
        // 进入刷新状态后会自动调用这个block
        self.index += 30;
        [self reloadData];
        [self.mj_footer endRefreshing];

    }];

}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.index;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

@end
