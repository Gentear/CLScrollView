//
//  headerView.h
//  网易滚动视图
//
//  Created by 蕾 on 15/10/16.
//  Copyright © 2015年 丛蕾. All rights reserved.
//

#import <UIKit/UIKit.h>
@class headerView;

@protocol headerViewDelegate <NSObject>

- (void) headerView: (headerView*)header selectedIndexChanged: (NSUInteger) index;

@end

@interface headerView : UIScrollView

@property (nonatomic, weak) NSArray * sectionArray;
@property (nonatomic) NSUInteger selectedIndex;

@property (nonatomic, weak) id<headerViewDelegate> delegates;
@property (nonatomic,strong)NSArray * headerArray;

+ (headerView *)creatHeaderView;
- (void) setSelectedIndexAnimated:(NSUInteger)selectedIndex;
@end


