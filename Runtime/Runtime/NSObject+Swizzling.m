//
//  NSObject+Swizzling.m
//  Runtime
//
//  Created by Xiao on 2017/11/19.
//  Copyright © 2017年 com.xiao.forward. All rights reserved.
//

#import "NSObject+Swizzling.h"

@implementation NSObject (Swizzling)
/*
 在运行时，类（Class）维护了一个消息分发列表来解决消息的正确发送。每一个消息列表的入口是一个方法（Method），这个方法映射了一对键值对，其中键是这个方法的名字（SEL），值是指向这个方法实现的函数指针 implementation（IMP）
 
 为什么要添加didAddMethod判断？
 先尝试添加原SEL其实是为了做一层保护，因为如果这个类没有实现originalSelector，但其父类实现了，那class_getInstanceMethod会返回父类的方法。这样method_exchangeImplementations替换的是父类的那个方法，这当然不是我们想要的。所以我们先尝试添加 orginalSelector，如果已经存在，再用 method_exchangeImplementations 把原方法的实现跟新的方法实现给交换掉。
 大概的意思就是我们可以通过class_addMethod为一个类添加方法（包括方法名称（SEL）和方法的实现（IMP）），返回值为BOOL类型，表示方法是否成功添加。需要注意的地方是class_addMethod会添加一个覆盖父类的实现，但不会取代原有类的实现。也就是说如果class_addMethod返回YES，说明子类中没有方法originalSelector，通过class_addMethod为其添加了方法originalSelector，并使其实现（IMP）为我们想要替换的实现。
 同时再将原有的实现（IMP）替换到swizzledMethod方法上，
从而实现了方法的交换，并且未影响父类方法的实现。反之如果class_addMethod返回NO，说明子类中本身就具有方法originalSelector的实现，直接调用交换即可。
 */
+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector{
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    //先尝试给源SEL添加IMP，这里为了避免源SEL没有实现IMP的情况
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if(didAddMethod){
        //添加成功，说明源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        //添加失败，说明SEL已经有IMP，直接将两个SEL的IMP交换即可
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
