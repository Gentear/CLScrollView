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
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,CLHeaderViewDelegate>
@property (nonatomic,weak)UICollectionView * collectionView;
@property (nonatomic,weak)CLHeaderView * header;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatUI];
    CLHeaderView * header = [CLHeaderView creatHeaderView];
    [self.view addSubview:header];
    header.headerArray = @[@"头条",@"转疯了",@"搞笑",@"猎奇",@"社会",@"直播贴",@"头条",@"转疯了",@"搞笑",@"猎奇",@"社会",@"直播贴"];
    self.header = header;
    self.header.delegate = self;

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/self.view.frame.size.width;
    [self.header setSelectedIndexAnimated:page];
}
- (void)headerView:(CLHeaderView *)header selectedIndexChanged:(NSUInteger)index{
    [self.collectionView scrollRectToVisible:CGRectMake(index * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
}
- (void)creatUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //item行间距
    flowLayout.minimumLineSpacing = 0;//默认10
    flowLayout.minimumInteritemSpacing = 0;//默认10
    //设置统一大小的item
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width,self.view.frame.size.height);//默认50
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//默认竖直滚动
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//边距屏幕宽
    
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    collectionView.pagingEnabled = YES;
    collectionView.bounces = NO;
    self.collectionView = collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.header.headerArray.count;
}
//创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CLCollectionCell *cell = [CLCollectionCell cellWithNibcollection:collectionView withIndex:indexPath];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    CLCollectionCell *myCell = (CLCollectionCell *)cell;
    [myCell.tableView.mj_header endRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
