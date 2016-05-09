//
//  UICollectionViewCell+CreatCell.h
//  yeeSight
//
//  Created by zyyt on 16/2/23.
//  Copyright © 2016年 zyyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (CreatCell)
/**
 *  加载xib的cell
 */
+ (id)cellWithNibcollection:(UICollectionView*)collectionView withIndex:(NSIndexPath*)index;
/**
 *  加载纯代码cell
 */
+ (id)cellWithcollection:(UICollectionView*)collectionView withIndex:(NSIndexPath*)index;
/**
 *  无重用
 */
+ (id)cellWithNibNoOperationcollection:(UICollectionView*)collectionView withIndex:(NSIndexPath*)index;
/**
 *  不用nib重用
 */
+ (id)cellWithNoOperationcollection:(UICollectionView*)collectionView withIndex:(NSIndexPath*)index;
@end
