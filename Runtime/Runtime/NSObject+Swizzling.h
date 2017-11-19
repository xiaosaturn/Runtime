//
//  NSObject+Swizzling.h
//  Runtime
//
//  Created by Xiao on 2017/11/19.
//  Copyright © 2017年 com.xiao.forward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>

@interface NSObject (Swizzling)

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector;

@end
