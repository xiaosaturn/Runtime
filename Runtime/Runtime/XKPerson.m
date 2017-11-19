//
//  XKPerson.m
//  Runtime
//
//  Created by Xiao on 2017/11/19.
//  Copyright © 2017年 com.xiao.forward. All rights reserved.
//

#import "XKPerson.h"

@implementation XKPerson
- (void)run{
    NSLog(@"对象方法跑起来了");
}

+ (void)runClass{
    NSLog(@"类方法跑起来了");
}

- (void)eatWithFood:(NSString *)food{
    NSLog(@"哥们吃到了-%@",food);
}
@end
