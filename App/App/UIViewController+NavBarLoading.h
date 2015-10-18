//
//  UIViewController+NavBarLoading.h
//  App
//
//  Created by qiukai on 15/10/18.
//  Copyright © 2015年 qiukai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavBarLoading)

@property (copy, nonatomic) NSString *navBarOrigTitle;
@property (assign, nonatomic) BOOL isLoading;

- (void)startLoading;
- (void)stopLoading;

@end
