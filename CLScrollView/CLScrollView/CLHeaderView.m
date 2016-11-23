//
//  CLHeaderView.m
//  网易滚动视图
//
//  Created by zyyt on 16/5/7.
//  Copyright © 2016年 丛蕾. All rights reserved.
//
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "CLHeaderView.h"

@interface CLHeaderView()
@property (nonatomic, strong) UIView * indicatorView;
@property (strong,nonatomic) NSMutableArray * AllBtnArray;
@property (nonatomic, strong) UIButton * selectedButton;
@property (weak,nonatomic) UIScrollView *scrollView;
@end
@implementation CLHeaderView
+ (CLHeaderView *)creatHeaderView{
    return [[self alloc]init];
}
- (instancetype)init{
    
    if (self  =   [super init]) {
        
    }
    return  self;
}
- (void) setSelectedIndexAnimated:(NSUInteger)selectedIndex
{
    self.selectedIndex = selectedIndex;
    for (UIButton * button in self.AllBtnArray) {
        button.selected = NO;
    }
    self.selectedButton.selected = YES;
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.frame = CGRectMake(self.selectedButton.frame.origin.x+2, self.selectedButton.frame.origin.y+5, self.selectedButton.frame.size.width-4, self.selectedButton.frame.size.height-10) ;
        
    } completion:^(BOOL finished) {
        CGRect  rect = [self  convertRect: CGRectMake(self.selectedButton.center.x - ScreenWidth/2, 0, self.selectedButton.center.x + ScreenWidth/2, 44) toView:self];
        [self.scrollView scrollRectToVisible:rect  animated:YES];
    }];
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerView:selectedIndexChanged:)]) {
        [self.delegate  headerView:self selectedIndexChanged:selectedIndex];
    }
}
- (void)willMoveToSuperview:(UIView *)newSuperview{
    self.frame = CGRectMake(0, 64, newSuperview.frame.size.width, 44);
    self.backgroundColor = [UIColor lightGrayColor];
}
#pragma mark - 按钮点击执行方法
- (void)sectionButtonClicked:(UIButton *)myBtn{
    NSUInteger newIndex = [self.AllBtnArray indexOfObject:myBtn];
    if (newIndex==self.selectedIndex) {
        return;
    }
    self.selectedIndex = newIndex;
    [self setSelectedIndexAnimated:newIndex];
}
#pragma mark - 懒加载
- (void)setHeaderArray:(NSArray *)headerArray{
    for (UIButton *button in _AllBtnArray) {
        [button removeFromSuperview];
    }
    [self indicatorView];
    NSMutableArray * buttonArray = [NSMutableArray arrayWithCapacity:headerArray.count];
    CGSize size = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    //UIlabel控件上设置的字体号,一定要与动态计算字体号统一
    NSDictionary * attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    size = [headerArray[self.selectedIndex] boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    self.indicatorView.frame = CGRectMake(2, 5, size.width + 16, 35);
    _headerArray = headerArray;
    float x = 0;
    for (NSString * title in headerArray) {
        CGSize size = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
        //UIlabel控件上设置的字体号,一定要与动态计算字体号统一
        NSDictionary * attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        size = [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.backgroundColor = [UIColor clearColor];
        button.frame= CGRectMake(x, 0, size.width + 20, 44);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.layer.cornerRadius = 4;
        button.clipsToBounds = YES;
        [self.scrollView addSubview:button];
        [buttonArray addObject:button];
        if (x == 0) {
            button.selected = YES;
            
        }
        [button addTarget:self action:@selector(sectionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        x += size.width+20;
    }
    self.scrollView.contentSize = CGSizeMake(x, 1);
    self.AllBtnArray = buttonArray;
}
- (UIButton *)selectedButton{
    if (self.AllBtnArray.count <= 0  ) {
        return nil;
    }
    if (self.selectedIndex > self.AllBtnArray.count - 1) {
        return self.AllBtnArray[0];
    }
    return self.AllBtnArray[self.selectedIndex];
}
- (NSMutableArray *)AllBtnArray{
    if (_AllBtnArray == nil) {
        
        _AllBtnArray = [[NSMutableArray alloc]init];
    }
    return _AllBtnArray;
}
- (UIView *)indicatorView{
    if (_indicatorView == nil) {
        UIView *indicatorView = [[UIView alloc] init];
        indicatorView.backgroundColor = [UIColor redColor];
        indicatorView.layer.cornerRadius = 4;
        indicatorView.clipsToBounds = YES;
        [self.scrollView addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    return _indicatorView;
}
- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 44)];
        scrollView.bounces = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        
        _scrollView = scrollView;
    }
    return _scrollView;
}
@end
