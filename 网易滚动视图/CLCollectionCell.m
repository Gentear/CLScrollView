//
//  CLCollectionCell.m
//  网易滚动视图
//
//  Created by 蕾 on 15/10/19.
//  Copyright © 2015年 丛蕾. All rights reserved.
//

#import "CLCollectionCell.h"
@interface CLCollectionCell()
@end
@implementation CLCollectionCell
- (void)prepareForReuse{
    //防止下拉后没有刷新成功点击其他按钮导致的刷新控件没有回复原状
    if (self.tableView.contentOffset.y == -54) {
        self.tableView.contentOffset = CGPointMake(0, 0);
    }
}
- (CLMytableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[CLMytableView alloc]init];
        [self addSubview:_tableView];
    }
    return _tableView;
}
@end
