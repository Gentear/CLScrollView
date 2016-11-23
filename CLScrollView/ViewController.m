//
//  ViewController.m
//  网易滚动视图
//
//  Created by 蕾 on 15/10/16.
//  Copyright © 2015年 丛蕾. All rights reserved.
//

#import "ViewController.h"
#import "CLHeaderView.h"
#import "MJRefresh.h"
#import "CLCollectionCell.h"
#import "UICollectionViewCell+CreatCell.h"
#import "UIViewController+CLScrollPage.h"
@interface ViewController ()//<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,CLHeaderViewDelegate>
//@property (nonatomic,weak)UICollectionView * collectionView;
//@property (nonatomic,weak)CLHeaderView * header;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addScrollPage];
    self.cl_header.headerArray = @[@"头条",@"转疯了",@"搞笑",@"猎奇",@"社会",@"直播贴",@"头条",@"转疯了",@"搞笑",@"猎奇",@"社会",@"直播贴"];
    [self setCl_CellBlock:^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView) {
        CLCollectionCell *cell = [CLCollectionCell cellWithcollection:collectionView withIndex:indexPath];
        [cell prepareForReuse];
        return cell;
    }];
    [self.cl_collectionView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
