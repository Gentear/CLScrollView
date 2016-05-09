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
- (void)awakeFromNib{
    [self tableView];
}
- (CLMytableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[CLMytableView alloc]init];
        [self addSubview:_tableView];
    }
    return _tableView;
}
@end
