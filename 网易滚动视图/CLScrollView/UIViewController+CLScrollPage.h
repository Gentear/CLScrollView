//
//  UIViewController+CLScrollPage.h
//  网易滚动视图
//
//  Created by zyyt on 16/11/23.
//  Copyright © 2016年 丛蕾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLHeaderView.h"

typedef UICollectionViewCell * (^CellForItemAtIndexPathBlock)(NSIndexPath *indexPath,UICollectionView *collectionView);

@interface UIViewController (CLScrollPage)
/** <#name#> */
@property (nonatomic,strong)UICollectionView * cl_collectionView;
/**
 *  <#Description#>
 */
@property (nonatomic,strong)CLHeaderView * cl_header;

/** <#name#> */
@property (nonatomic,copy)CellForItemAtIndexPathBlock cl_CellBlock;
- (void)addScrollPage;

- (void)setCl_CellBlock:(CellForItemAtIndexPathBlock)cl_CellBlock;
@end
