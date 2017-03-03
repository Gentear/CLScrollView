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

char * const cl_CellForItemAtIndexPathBlock = "CellForItemAtIndexPathBlock";

@interface UIViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,CLHeaderViewDelegate>

@end

@implementation UIViewController(CLScrollPage)
- (void)addScrollPage{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatUI];
}
- (void)creatUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width,self.view.frame.size.height);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.cl_collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.cl_collectionView.showsHorizontalScrollIndicator = NO;
    self.cl_collectionView.showsVerticalScrollIndicator = NO;
    self.cl_collectionView.backgroundColor = [UIColor whiteColor];
    self.cl_collectionView.delegate = self;
    self.cl_collectionView.dataSource = self;
    self.cl_collectionView.pagingEnabled = YES;
    self.cl_collectionView.bounces = NO;
    [self.view addSubview:self.cl_collectionView];
    self.cl_header = [CLHeaderView creatHeaderView];
    self.cl_header.delegate = self;
    [self.view addSubview:self.cl_header];
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
- (CellForItemAtIndexPathBlock)cl_CellBlock {
    return objc_getAssociatedObject(self, cl_CellForItemAtIndexPathBlock);
}

- (void)setCl_CellBlock:(CellForItemAtIndexPathBlock)cl_CellBlock
{
    objc_setAssociatedObject(self,
                                 cl_CellForItemAtIndexPathBlock,
                                 cl_CellBlock,
                                 OBJC_ASSOCIATION_COPY);
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wobjc-protocol-method-implementation"
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //内容左上角位置 - 到滚动视图左上角的偏移
    NSLog(@"offset x=%f y=%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/self.view.frame.size.width;
    [self.cl_header setSelectedIndexAnimated:page];
}
#pragma mark - CLHeaderViewDelegate
- (void)headerView:(CLHeaderView *)header selectedIndexChanged:(NSUInteger)index{
    [self.cl_collectionView scrollRectToVisible:CGRectMake(index * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
}
#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cl_header.headerArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cl_CellBlock){
       return self.cl_CellBlock(indexPath,collectionView);
    }
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    for (UIView *tableView in cell.subviews) {
        if ([tableView isKindOfClass:[UITableView class]]) {
            UITableView *Tmp = (UITableView *)tableView;
            [Tmp.mj_header endRefreshing];
        }
    }
}
#pragma clang diagnostic pop  


@end
