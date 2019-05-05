//
//  TopSliderView.m
//  IPHeadLine
//
//  Created by SoC on 2018/2/10.
//  Copyright © 2018年 乔强. All rights reserved.
//

#import "SOCTopSliderView.h"
#import "Macros.h"
#import "UIViewExt.h"

@interface SOCTopSliderView ()

@property (nonatomic, strong) UIView *sliderView;

@end

@implementation SOCTopSliderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bgScrollView];
        [self.bgScrollView addSubview:self.sliderView];
    }
    return self;
}

#pragma mark --private method
- (void)clickedItemBtn:(UIButton *)sender {
    for (UIView *view in _bgScrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            btn.selected = NO;
        }
    }
    sender.selected = YES;
    
    [UIView animateWithDuration:.5 animations:^{
        _sliderView.left = sender.left;
        _sliderView.width = sender.width;
    }];
    if (_bgScrollView.contentSize.width > kScreenWidth-40) {
        [self settleTitleButton:sender];
    }
    NSInteger i = sender.tag-7878;
    if (_delegate && [_delegate respondsToSelector:@selector(clickedTopSliderItemWithIndex:)]) {
        [_delegate performSelector:@selector(clickedTopSliderItemWithIndex:) withObject:[NSString stringWithFormat:@"%ld",i]];
    }
}

- (void)setContentOffWithIndex:(NSInteger)index {
    
    for (UIView *view in _bgScrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            btn.selected = NO;
        }
    }
    UIButton *sender = (UIButton *)[_bgScrollView viewWithTag:7878+index];
    sender.selected = YES;
    
    [UIView animateWithDuration:.2 animations:^{
        _sliderView.left = [_bgScrollView viewWithTag:index+7878].left;
        _sliderView.width = [_bgScrollView viewWithTag:index+7878].width;
        
    }];
    
    if (_bgScrollView.contentSize.width > kScreenWidth-40) {
        [self settleTitleButton:(UIButton *)[_bgScrollView viewWithTag:index+7878]];
    }
    
}

- (void)settleTitleButton:(UIButton *)button
{
    // 标题
    // 这个偏移量是相对于scrollview的content frame原点的相对对标
    CGFloat deltaX = button.center.x - (kScreenWidth) / 2;
    // 设置偏移量，记住这段算法
    if (deltaX < 0)
    {
        // 最左边
        deltaX = 0;
    }
    CGFloat maxDeltaX = _bgScrollView.contentSize.width - (kScreenWidth);
    if (deltaX > maxDeltaX)
    {
        // 最右边不能超范围
        deltaX = maxDeltaX;
    }
    [_bgScrollView setContentOffset:CGPointMake(deltaX, 0) animated:YES];
    
}

#pragma mark --setter && getter
- (UIScrollView *)bgScrollView {
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _bgScrollView.showsVerticalScrollIndicator = NO;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _bgScrollView;
}

- (UIView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[UIView alloc] initWithFrame:CGRectMake(20, _bgScrollView.bottom-2, 10, 1.5)];
        _sliderView.backgroundColor = [UIColor redColor];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _sliderView.bottom, kScreenWidth, .5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineView];
    }
    return _sliderView;
}


- (void)setItemArray:(NSArray *)itemArray {
    if (itemArray.count <= 0) {
        return;
    }
    _itemArray = itemArray;
    
    CGFloat w = 0;
    for (int i = 0; i < itemArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20+w, 0, 10, _bgScrollView.height);
        [btn setTitle:itemArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        if (i == 0) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(clickedItemBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.height = self.bgScrollView.height;
        [btn sizeToFit];
        btn.top = (self.bgScrollView.height-btn.height)/2;
        w = btn.right;
        btn.tag = 7878+i;
        [_bgScrollView addSubview:btn];
    }
    _sliderView.width = [_bgScrollView viewWithTag:7878].width;
    _bgScrollView.contentSize = CGSizeMake(w+20, 0);
}

@end
