//
//  CLCollectionCell.h
//  网易滚动视图
//
//  Created by zyyt on 16/5/9.
//  Copyright © 2016年 丛蕾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLMytableView.h"

@interface CLCollectionCell : UICollectionViewCell
@property (strong,nonatomic) CLMytableView *tableView;
- (void)prepareForReuse;
@end
