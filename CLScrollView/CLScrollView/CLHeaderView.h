//
//  CLHeaderView.h
//  网易滚动视图
//
//  Created by zyyt on 16/5/7.
//  Copyright © 2016年 丛蕾. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLHeaderView;
@protocol CLHeaderViewDelegate <NSObject>

- (void)headerView:(CLHeaderView*)header selectedIndexChanged: (NSUInteger) index;

@end
@interface CLHeaderView : UIView
@property (strong, nonatomic) id<CLHeaderViewDelegate>delegate;
@property (strong,nonatomic)NSArray * sectionArray;
@property (nonatomic) NSUInteger selectedIndex;
/**
 *  头视图的数组
 */
@property (nonatomic,strong)NSArray * headerArray;
/**
 *  类方法初始化
 *
 */
+ (CLHeaderView *)creatHeaderView;
/**
 *  设置高亮的位置
 *
 */
- (void) setSelectedIndexAnimated:(NSUInteger)selectedIndex;
@end
