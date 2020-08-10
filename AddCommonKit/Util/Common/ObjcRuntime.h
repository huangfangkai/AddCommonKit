//
//  ObjcRuntime.h
//  111
//
//  Created by hfk on 2020/6/26.
//  Copyright © 2020 hfk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//根据类名称获取类
//系统就提供 NSClassFromString(NSString *clsname)

//获取一个类的所有属性名字:类型的名字，具有@property的, 父类的获取不了！
NSDictionary *GetPropertyListOfObject(NSObject *object);
NSDictionary *GetPropertyListOfClass(Class cls);

void Swizzle(Class c, SEL origSEL, SEL newSEL);

NS_ASSUME_NONNULL_END
