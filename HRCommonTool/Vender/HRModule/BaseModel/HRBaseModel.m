//
//  HRBaseModel.m
//  HRTestDemo
//
//  Created by pxsl on 2019/8/22.
//  Copyright © 2019 User. All rights reserved.
//

#import "HRBaseModel.h"
#import <objc/runtime.h>

@implementation HRBaseModel

////方法一：普通方式实现：
//- (void)encodeWithCoder:(NSCoder *)coder
//{
//    //告诉系统归档的属性是哪些
//    [coder encodeObject:self.name forKey:@"name"];
//    [coder encodeInteger:self.age forKey:@"age"];
//}
//
//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super init];
//    if (self) {
//        //解档
//        self.name = [coder decodeObjectForKey:@"name"];
//        self.age = [coder decodeIntegerForKey:@"age"];
//    }
//    return self;
//}

- (void)encodeWithCoder:(NSCoder *)coder
{
    //告诉系统归档的属性是哪些
    unsigned int count = 0;//表示对象的属性个数
    Ivar *ivars = class_copyIvarList([HRBaseModel class], &count);
    for (int i = 0; i<count; i++) {
        //拿到Ivar
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);//获取到属性的C字符串名称
        NSString *key = [NSString stringWithUTF8String:name];//转成对应的OC名称
        //归档 -- 利用KVC
        [coder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(ivars);//在OC中使用了Copy、Creat、New类型的函数，需要释放指针！！（注：ARC管不了C函数）
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        //解档
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([HRBaseModel class], &count);
        for (int i = 0; i<count; i++) {
            //拿到Ivar
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            //解档
            id value = [coder decodeObjectForKey:key];
            // 利用KVC赋值
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}

@end
