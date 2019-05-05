//
//  ProInfoViewController.m
//  IPHeadLine
//
//  Created by SoC on 2018/3/13.
//  Copyright © 2018年 乔强. All rights reserved.
//

#import "SOCViewController.h"
#import "SOCTopSliderView.h"
#import "Macros.h"
#import "UIViewExt.h"
#import "UIView+SLEExtention.h"
#import "SOCSubTableViewController.h"

@interface SOCViewController ()<UIScrollViewDelegate, SOCTopSliderViewDelegate> {
    NSArray *topDataArray;
}

@property (nonatomic, strong) SOCTopSliderView *topSliderView;
@property (weak ,nonatomic) UIScrollView *contentView;

@end

@implementation SOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    topDataArray = @[@"哈哈哈哈",@"嘻嘻",@"哼哼",@"咯咯",@"嘿嘿嘿",@"哒哒", @"咕咕咕咕", @"嘀嘀嘀",@"啦啦"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavBar];
    [self initUI];
}

#pragma mark --private method
- (void)configNavBar {
    self.navigationItem.title = @"SOCPageView";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClicked)];
    backItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)backBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI {
    [self.view addSubview:self.topSliderView];
    _topSliderView.itemArray = topDataArray;
    [self setupChildControllerWithCount:topDataArray.count];
    [self setupContentView];
}

#pragma mark --setter && getter
- (SOCTopSliderView *)topSliderView {
    if (!_topSliderView) {
        _topSliderView = [[SOCTopSliderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
        _topSliderView.delegate = self;
    }
    return _topSliderView;
}


- (void)setupChildControllerWithCount:(NSInteger)count {
    for (int i = 0; i < count; i++) {
        SOCSubTableViewController *piSubVC = [SOCSubTableViewController new];
        [self addChildViewController:piSubVC];
    }
}

#pragma mark -- <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    SOCSubTableViewController *tabVc = self.childViewControllers[index];
    tabVc.view.left = scrollView.contentOffset.x;
    tabVc.view.top= 0;
    tabVc.view.height = scrollView.height;
    tabVc.tableView.contentInset = UIEdgeInsetsMake(_topSliderView.bottom, 0, 0, 0);
    tabVc.tableView.scrollIndicatorInsets = tabVc.tableView.contentInset;
    [scrollView addSubview:tabVc.view];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self clickedTopSliderItemWithIndex:[NSString stringWithFormat:@"%ld",index]];
    [self.topSliderView setContentOffWithIndex:index];
}

- (void)clickedTopSliderItemWithIndex:(NSString *)index {
    CGPoint offset = self.contentView.contentOffset;
    offset.x = [index integerValue]*self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

// 设置scrollview
- (void)setupContentView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.contentSize = CGSizeMake(contentView.width *self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    [self.view insertSubview:contentView atIndex:0];
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
