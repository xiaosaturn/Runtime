//
//  UIButton+Swizzling.h
//  Runtime
//
//  Created by Xiao on 2017/11/19.
//  Copyright © 2017年 com.xiao.forward. All rights reserved.
//

#import <UIKit/UIKit.h>

//默认时间间隔
#define defaultInterval 1

@interface UIButton (Swizzling)

//点击间隔
@property (nonatomic,assign) NSTimeInterval timeInterval;
//用于设置单个按钮不需要被hook
@property (nonatomic,assign) BOOL isIgnore;

@end
