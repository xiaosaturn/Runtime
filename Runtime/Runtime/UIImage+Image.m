//
//  UIImage+Image.m
//  Runtime
//
//  Created by Xiao on 2017/11/18.
//  Copyright © 2017年 com.xiao.forward. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (void)load{
    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    Method myImageNamedMethod = class_getClassMethod(self, @selector(myImageNamed:));
    method_exchangeImplementations(imageNamedMethod, myImageNamedMethod);
}

+ (UIImage *)myImageNamed:(NSString *)name{
    UIImage *image = [UIImage myImageNamed:name];
    if(image){
        NSLog(@"runtime添加额外功能--加载成功");
    }else{
        NSLog(@"runtime添加额外功能--加载失败");
    }
    return image;
}

@end
