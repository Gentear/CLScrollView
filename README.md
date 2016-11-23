#CLScrollView

> 一个网易滚动视图类似的页面 使用比较简单方便

```
[self addScrollPage];
self.cl_header.headerArray = @[@"头条",@"转疯了",@"搞笑",@"猎奇",@"社会",@"直播贴",@"头条",@"转疯了",@"搞笑",@"猎奇",@"社会",@"直播贴"];
[self.cl_collectionView reloadData];
```
>添加各个页面的cell并反回
```
[self setCl_CellBlock:^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView) {
        CLCollectionCell *cell = [CLCollectionCell cellWithcollection:collectionView withIndex:indexPath];
        [cell prepareForReuse];
        return cell;
    }];
```
