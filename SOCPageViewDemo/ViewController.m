//
//  ViewController.m
//  SOCPageViewDemo
//
//  Created by SoC on 2018/3/13.
//  Copyright © 2018年 SoC. All rights reserved.
//

#import "ViewController.h"
#import "Macros.h"
#import "SOCViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIButton *jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jumpBtn.frame = CGRectMake(0, kScreenHeight-80, kScreenWidth, 80);
    jumpBtn.backgroundColor = [UIColor orangeColor];
    [jumpBtn addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpBtn];
    
}

- (void)jump:(UIButton *)sender {
    SOCViewController *soc = [SOCViewController new];
    [self presentViewController:soc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
