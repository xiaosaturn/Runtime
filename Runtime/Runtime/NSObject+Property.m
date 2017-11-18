//
//  NSObject+Property.m
//  Runtime
//
//  Created by Xiao on 2017/11/18.
//  Copyright © 2017年 com.xiao.forward. All rights reserved.
//

#import "NSObject+Property.h"

@implementation NSObject (Property)

- (void)setName:(NSString *)name{
    /*
     将某个值与某个对象关联起来，将某个值存储到某个对象中
     object:给哪个对象添加属性
     key:属性名称
     value:属性值
     policy:保存策略
     */
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name{
    return objc_getAssociatedObject(self, @"name");
}

@end
