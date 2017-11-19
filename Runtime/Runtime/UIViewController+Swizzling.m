//
//  UIViewController+Swizzling.m
//  Runtime
//
//  Created by Xiao on 2017/11/19.
//  Copyright © 2017年 com.xiao.forward. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import "NSObject+Swizzling.h"

//替换ViewController生命周期方法
@implementation UIViewController (Swizzling)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(viewWillDisappear:) bySwizzledSelector:@selector(xk_viewWillDisappear:)];
    });
}

- (void)xk_viewWillDisappear:(BOOL)animated{
    [self xk_viewWillDisappear:animated];
    //在view即将消失的时候将加载菊花移除
//    [SVProgressHUD dismiss];
}

@end
