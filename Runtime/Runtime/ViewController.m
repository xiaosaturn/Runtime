//
//  ViewController.m
//  Runtime
//
//  Created by Xiao on 2017/11/18.
//  Copyright © 2017年 com.xiao.forward. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Property.h"
#import "XKPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self comRuntime];
}

//理解
- (void)comRuntime{
    XKPerson *p = [XKPerson new];
    Class personClass = [XKPerson class];
    objc_msgSend(p, @selector(run));
    objc_msgSend(personClass, @selector(runClass));
    objc_msgSend(p, @selector(eatWithFood:),@"香蕉");
}

//交换系统方法
- (void)exchangeImageNamedMethod{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    UIImage *image = [UIImage imageNamed:@"scenery.jpg"];
    imageV.image = image;
    [self.view addSubview:imageV];
}

//给分类动态添加属性
- (void)dynamicAddProperty{
    NSObject *objc = [[NSObject alloc] init];
    objc.name = @"晓锟";
    NSLog(@"My Name is %@",objc.name);
}

//字典转模型
- (void)dictToModel{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
