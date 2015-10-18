//
//  ViewController.m
//  App
//
//  Created by qiukai on 15/10/18.
//  Copyright © 2015年 qiukai. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+NavBarLoading.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"test";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.isLoading) {
        [self stopLoading];
    } else {
        [self startLoading];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
