//
//  TopSliderView.h
//  IPHeadLine
//
//  Created by SoC on 2018/2/10.
//  Copyright © 2018年 乔强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SOCTopSliderViewDelegate<NSObject>

- (void)clickedTopSliderItemWithIndex:(NSString *)index;

@end


@interface SOCTopSliderView : UIView

@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, weak) id<SOCTopSliderViewDelegate> delegate;

- (void)setContentOffWithIndex:(NSInteger)index;

@end
