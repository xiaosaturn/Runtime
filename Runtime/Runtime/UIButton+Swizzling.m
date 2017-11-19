//
//  UIButton+Swizzling.m
//  Runtime
//
//  Created by Xiao on 2017/11/19.
//  Copyright © 2017年 com.xiao.forward. All rights reserved.
//

#import "UIButton+Swizzling.h"
#import "NSObject+Swizzling.h"

@implementation UIButton (Swizzling)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(sendAction:to:forEvent:) bySwizzledSelector:@selector(xk_SendAction:to:forEvent:)];
    });
}

- (NSTimeInterval)timeInterval{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval{
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)xk_SendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if(self.isIgnore){
        [self xk_SendAction:action to:target forEvent:event];
        return;
    }
    if([NSStringFromClass(self.class) isEqualToString:@"UIButton"]){
        self.timeInterval = self.timeInterval == 0 ? defaultInterval : self.timeInterval;
        if (self.isIgnoreEvent){
            return;
        }else if (self.timeInterval > 0){
            [self performSelector:@selector(resetState) withObject:nil afterDelay:self.timeInterval];
        }
        self.isIgnoreEvent = YES;
        [self xk_SendAction:action to:target forEvent:event];
    }
}

//runtime动态绑定属性
- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent{
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isIgnoreEvent{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsIgnore:(BOOL)isIgnore{
    objc_setAssociatedObject(self, @selector(isIgnore), @(isIgnore), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isIgnore{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)resetState{
    [self setIsIgnoreEvent:NO];
}

@end
