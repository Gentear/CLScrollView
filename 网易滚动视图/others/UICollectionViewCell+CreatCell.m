//
//  UICollectionViewCell+CreatCell.m
//  yeeSight
//
//  Created by zyyt on 16/2/23.
//  Copyright © 2016年 zyyt. All rights reserved.
//

#import "UICollectionViewCell+CreatCell.h"

@implementation UICollectionViewCell (CreatCell)
+ (id)cellWithNibcollection:(UICollectionView*)collectionView withIndex:(NSIndexPath*)index{
    
    NSString * className = NSStringFromClass([self class]);
    
    
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:className];
    
    //如果有可重用的返回,如果没有可重用的创建一个新的返回
    return [collectionView dequeueReusableCellWithReuseIdentifier:className forIndexPath:index];
    
}
+ (id)cellWithNibNoOperationcollection:(UICollectionView*)collectionView withIndex:(NSIndexPath*)index{
    
    NSString * className = NSStringFromClass([self class]);
    
    NSString *uid = [NSString stringWithFormat:@"%ld%ld",(long)index.row,(long)index.section];
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:uid];
        return [collectionView dequeueReusableCellWithReuseIdentifier:uid forIndexPath:index];
}
+ (id)cellWithNoOperationcollection:(UICollectionView*)collectionView withIndex:(NSIndexPath*)index{
    
    NSString *uid = [NSString stringWithFormat:@"%ld%ld",(long)index.row,(long)index.section];
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:uid];
    
    //如果有可重用的返回,如果没有可重用的创建一个新的返回
    return [collectionView dequeueReusableCellWithReuseIdentifier:uid forIndexPath:index];
}

+ (id)cellWithcollection:(UICollectionView*)collectionView withIndex:(NSIndexPath*)index{
    
    NSString * className = NSStringFromClass([self class]);
    
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:className];
    
    //如果有可重用的返回,如果没有可重用的创建一个新的返回
    return [collectionView dequeueReusableCellWithReuseIdentifier:className forIndexPath:index];
}
@end
