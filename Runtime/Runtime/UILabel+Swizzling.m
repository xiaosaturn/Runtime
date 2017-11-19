//
//  UILabel+Swizzling.m
//  Runtime
//
//  Created by Xiao on 2017/11/19.
//  Copyright © 2017年 com.xiao.forward. All rights reserved.
//

#import "UILabel+Swizzling.h"
#import "NSObject+Swizzling.h"
/*
 以UILabel为例，在项目比较成熟的基础上，应用中需要引入新的字体，需要更换所有Label的默认字体，但是同时，对于一些特殊设置了字体的label又不需要更换。乍看起来，这个问题确实十分棘手，首先项目比较大，一个一个设置所有使用到的label的font工作量是巨大的，并且在许多动态展示的界面中，可能会漏掉一些label，产生bug。其次，项目中的label来源并不唯一，有用代码创建的，有xib和storyBoard中的，这也将浪费很大的精力。这时Method Swizzling可以解决此问题，避免繁琐的操作。
 */

@implementation UILabel (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(init) bySwizzledSelector:@selector(sure_Init)];
        [self methodSwizzlingWithOriginalSelector:@selector(initWithFrame:) bySwizzledSelector:@selector(sure_InitWithFrame:)];
        [self methodSwizzlingWithOriginalSelector:@selector(awakeFromNib) bySwizzledSelector:@selector(sure_AwakeFromNib)];
    });
}
- (instancetype)sure_Init{
    id __self = [self sure_Init];
    UIFont * font = [UIFont fontWithName:@"Zapfino" size:self.font.pointSize];
    if (font) {
        self.font = font;
    }
    return __self;
}
- (instancetype)sure_InitWithFrame:(CGRect)rect{
    id __self = [self sure_InitWithFrame:rect];
    UIFont * font = [UIFont fontWithName:@"Zapfino" size:self.font.pointSize];
    if (font) {
        self.font = font;
    }
    return __self;
}
- (void)sure_AwakeFromNib{
    [self sure_AwakeFromNib];
    UIFont * font = [UIFont fontWithName:@"Zapfino" size:self.font.pointSize];
    if (font) {
        self.font = font;
    }
}

@end
