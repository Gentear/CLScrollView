//
//  headerView.m
//  网易滚动视图
//
//  Created by 蕾 on 15/10/16.
//  Copyright © 2015年 丛蕾. All rights reserved.
//

#import "headerView.h"
@interface headerView()


@property (nonatomic, strong) UIView * indicatorView;

@property (nonatomic) NSArray * buttonArray;

@property (nonatomic, weak) UIButton * selectedButton;
@property (nonatomic) BOOL modify;


@end
@implementation headerView
+ (id)creatHeaderView{
    
    return [[self alloc]init];
    
}
- (instancetype)init{
    
    if (self  =   [super init]) {
        
//        self.backgroundColor = [UIColor lightGrayColor];
        [self creatUI];
        
    }
    return  self;
}
- (void)creatUI{
    
    self.indicatorView = [[UIView alloc] initWithFrame:CGRectMake(2, 5, 61, 35)];
    self.indicatorView.backgroundColor = [UIColor redColor];
    self.indicatorView.layer.cornerRadius = 4;
    self.indicatorView.clipsToBounds = YES;
    [self addSubview:self.indicatorView];
    self.backgroundColor = [UIColor lightGrayColor];
    self.bounces = YES;
}
- (UIButton *)selectedButton
{
    return self.buttonArray[self.selectedIndex];
}

- (void)setHeaderArray:(NSArray *)headerArray{
    
    NSMutableArray * buttonArray = [NSMutableArray arrayWithCapacity:headerArray.count];
    
    _headerArray = headerArray;
    float x = 0;
    for (NSString * title in headerArray) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.backgroundColor = [UIColor clearColor];
        button.frame= CGRectMake(x, 0, 65, 44);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.layer.cornerRadius = 4;
        button.clipsToBounds = YES;
        [self addSubview:button];
        [buttonArray addObject:button];
        if (x == 0) {
            button.selected = YES;

        }
        [button addTarget:self action:@selector(sectionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        x += 65;
    }
    
    self.buttonArray = buttonArray;
    self.contentSize = CGSizeMake(x, 1);
    
}
- (void)sectionButtonClicked:(UIButton *)button{
    
    NSUInteger newIndex = [self.buttonArray indexOfObject:button];
    if (newIndex==self.selectedIndex) {
        return;
    }
    self.selectedIndex = newIndex;
    [self setSelectedIndexAnimated:newIndex];

    
}
- (void) setSelectedIndexAnimated:(NSUInteger)selectedIndex
{
    self.selectedIndex = selectedIndex;
    for (UIButton * button in self.buttonArray) {
        button.selected = NO;
    }
    self.selectedButton.selected = YES;
    [UIView animateWithDuration:0.2 animations:^{

        self.indicatorView.frame = CGRectMake(self.selectedButton.frame.origin.x+2, self.selectedButton.frame.origin.y+5, self.selectedButton.frame.size.width-4, self.selectedButton.frame.size.height-10) ;

    } completion:^(BOOL finished) {

        CGRect  rect = [self  convertRect: CGRectMake(self.selectedButton.frame.origin.x-self.frame.size.width/2, self.selectedButton.frame.origin.y, self.frame.size.width, self.selectedButton.frame.size.height) toView:self];
        [self scrollRectToVisible:rect  animated:YES];
        

      
    }];
    if (self.delegates && [self.delegates respondsToSelector:@selector(headerView:selectedIndexChanged:)]) {

        [self.delegates  headerView:self selectedIndexChanged:selectedIndex];

    }


}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    self.frame = CGRectMake(0, 64, newSuperview.frame.size.width, 44);
    
}

@end
