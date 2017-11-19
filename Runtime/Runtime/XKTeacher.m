//
//  XKTeacher.m
//  Runtime
//
//  Created by Xiao on 2017/11/19.
//  Copyright © 2017年 com.xiao.forward. All rights reserved.
//

#import "XKTeacher.h"
#import <objc/message.h>

@interface XKTeacher()

@end

@implementation XKTeacher

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([XKTeacher class], &count);
    for(int i=0;i<count;i++){
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    //需要释放
    free(ivars);
}

//解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([XKTeacher class], &count);
        for(int i=0;i<count;i++){
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        //需要释放
        free(ivars);
    }
    return self;
}

@end
