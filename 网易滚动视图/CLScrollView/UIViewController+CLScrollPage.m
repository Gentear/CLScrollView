//
//  UIViewController+CLScrollPage.m
//  网易滚动视图
//
//  Created by zyyt on 16/11/23.
//  Copyright © 2016年 丛蕾. All rights reserved.
//

#import "UIViewController+CLScrollPage.h"
#import "CLCollectionCell.h"
#import "UICollectionViewCell+CreatCell.h"
#import "MJRefresh.h"
#import <objc/runtime.h>
//static const void *cl_header = &cl_header;

@interface UIViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,CLHeaderViewDelegate>

@end

@implementation UIViewController(CLScrollPage)
- (void)addScrollPage{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatUI];
}
#pragma mark - 懒加载
- (void)setCl_header:(CLHeaderView *)cl_header{
    objc_setAssociatedObject(self, @selector(setCl_header:), cl_header, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CLHeaderView *)cl_header{
    return objc_getAssociatedObject(self, @selector(setCl_header:));
}
- (void)setCl_collectionView:(UICollectionView *)cl_collectionView{
    objc_setAssociatedObject(self, @selector(setCl_collectionView:), cl_collectionView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UICollectionView *)cl_collectionView{
    return objc_getAssociatedObject(self, @selector(setCl_collectionView:));
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/self.view.frame.size.width;
    [self.cl_header setSelectedIndexAnimated:page];
}
- (void)headerView:(CLHeaderView *)header selectedIndexChanged:(NSUInteger)index{
    [self.cl_collectionView scrollRectToVisible:CGRectMake(index * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
}
- (void)creatUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width,self.view.frame.size.height);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.cl_collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.cl_collectionView.backgroundColor = [UIColor whiteColor];
    self.cl_collectionView.delegate = self;
    self.cl_collectionView.dataSource = self;
    self.cl_collectionView.pagingEnabled = YES;
    self.cl_collectionView.bounces = NO;
    [self.view addSubview:self.cl_collectionView];
    self.cl_header = [CLHeaderView creatHeaderView];
    [self.view addSubview:self.cl_header];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cl_header.headerArray.count;
}
//创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CLCollectionCell *cell = [CLCollectionCell cellWithcollection:collectionView withIndex:indexPath];
    [cell prepareForReuse];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    CLCollectionCell *myCell = (CLCollectionCell *)cell;
    [myCell.tableView.mj_header endRefreshing];
}
@end
