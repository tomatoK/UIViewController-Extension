//
//  UIViewController+NavBarLoading.m
//  App
//
//  Created by qiukai on 15/10/18.
//  Copyright © 2015年 qiukai. All rights reserved.
//

#import "UIViewController+NavBarLoading.h"
#import <objc/runtime.h>

@implementation UIViewController (NavBarLoading)

static char NavBarOrigTitleKey;
- (void)setNavBarOrigTitle:(NSString *)navBarOrigTitle {
    objc_setAssociatedObject(self, &NavBarOrigTitleKey, navBarOrigTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)navBarOrigTitle {
    return objc_getAssociatedObject(self, &NavBarOrigTitleKey);
}

static char NavBarIsLoadingKey;
- (void)setIsLoading:(BOOL)isLoading {
    objc_setAssociatedObject(self, &NavBarIsLoadingKey, @(isLoading), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isLoading {
    return [objc_getAssociatedObject(self, &NavBarIsLoadingKey) boolValue];
}

- (void)startLoading {
    if (!self.isLoading) {
        self.navBarOrigTitle = self.title;
        UIView *navBarLoadingContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        self.navigationItem.titleView = navBarLoadingContainer;
        self.isLoading = YES;
        
        UILabel *loadingTitleLabel = [[UILabel alloc] init];
        loadingTitleLabel.textAlignment = NSTextAlignmentCenter;
        loadingTitleLabel.textColor = [UIColor blackColor];
        loadingTitleLabel.text = @"加载中...";
        
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityIndicator startAnimating];
        [navBarLoadingContainer addSubview:loadingTitleLabel];
        [navBarLoadingContainer addSubview:activityIndicator];
        
        // 布局, o(╯□╰)o 还是Masonry方便
        CGFloat padding = 5;
        NSLayoutConstraint *trailingConstraintForLabel = [NSLayoutConstraint constraintWithItem:loadingTitleLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:loadingTitleLabel.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:-padding];
        NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:loadingTitleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:loadingTitleLabel.superview attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        
        NSLayoutConstraint *leadingConstraintForIndicator = [NSLayoutConstraint constraintWithItem:activityIndicator attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:activityIndicator.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:padding];
        NSLayoutConstraint *centerYConstraintForIndicator = [NSLayoutConstraint constraintWithItem:activityIndicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:loadingTitleLabel attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        
        loadingTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
        [loadingTitleLabel.superview addConstraints:@[trailingConstraintForLabel, centerYConstraint, centerYConstraintForIndicator, leadingConstraintForIndicator]];
    }
}

- (void)stopLoading {
    if (self.isLoading) {
        self.navigationItem.titleView = nil;
        self.title = self.navBarOrigTitle;
        self.isLoading = NO;
    }
}

@end
