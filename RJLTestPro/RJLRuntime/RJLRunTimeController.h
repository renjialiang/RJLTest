//
//  RJLRunTimeController.h
//  RJLTestPro
//
//  Created by admin on 17/3/13.
//  Copyright © 2017年 renjialiang. All rights reserved.
//

//typedef struct objc_protocol protocol;
//
////Category 指向分类的结构体指针
//typedef struct objc_category *Category;
//struct objc_category
//{
//    char *category_name;
//    char *class_name;
//    struct objc_method_list *instance_methods;
//    struct objc_method_list *class_methods;
//    struct objc_protocol_list *protocols;
//};
//
//
//struct Block_literal_1 {
//    void *isa;
//    int flags;
//    int reserved;
//    void (* invoke)(void *,...);
//    struct Block_descriptor_1 {
//        unsigned long int reserved;
//        unsigned long int size;
//        void (*copy_helper)(void *dst, void *src);
//        void (*dispose_helper)(void *src);
//    }*descriptor;
//};

//objc_object id
//struct objc_object {
//    Class isa  OBJC_ISA_AVAILABILITY;
//};
//
///// A pointer to an instance of a class.
//typedef struct objc_object *id;

//objc_cache
//
//上面提到了objc_class结构体中的cache字段，它用于缓存调用过的方法。这个字段是一个指向objc_cache结构体的指针，其定义如下：
//
//struct objc_cache {
//    unsigned int mask /* total = mask + 1 */                 OBJC2_UNAVAILABLE;
//    unsigned int occupied                                    OBJC2_UNAVAILABLE;
//    Method buckets[1]                                        OBJC2_UNAVAILABLE;
//};

//动态创建类
// 创建一个新类和元类
//Class objc_allocateClassPair ( Class superclass, const char *name, size_t extraBytes );
// 销毁一个类及其相关联的类
//void objc_disposeClassPair ( Class cls );
// 在应用中注册由objc_allocateClassPair创建的类
//void objc_registerClassPair ( Class cls );

//动态创建对象
//创建类实例
//id class_createInstance(Class cls,size_t extraBytes);
//在制定位置创建类实例
//id objc_constructInstance(Class cls, void *bytes);
//销毁类实例
//void * objc_destructInstance(id obj);

//返回指定对象的一份拷贝
//id object_copy (id obj, size_t size);
//释放指定对象占用的内存
//id object_dispose(id obj);

// 修改类实例的实例变量的值
//Ivar object_setInstanceVariable ( id obj, const char *name, void *value );
// 获取对象实例变量的值
//Ivar object_getInstanceVariable ( id obj, const char *name, void **outValue );
// 返回指向给定对象分配的任何额外字节的指针
//void * object_getIndexedIvars ( id obj );
// 返回对象中实例变量的值
//id object_getIvar ( id obj, Ivar ivar );
// 设置对象中实例变量的值
//void object_setIvar ( id obj, Ivar ivar, id value );

// 返回给定对象的类名
//const char * object_getClassName ( id obj );
// 返回对象的类
//Class object_getClass ( id obj );
// 设置对象的类
//Class object_setClass ( id obj, Class cls );

// 获取已注册的类定义的列表
//int objc_getClassList ( Class *buffer, int bufferCount );
// 创建并返回一个指向所有已注册类的指针列表
//Class * objc_copyClassList ( unsigned int *outCount );
// 返回指定类的类定义
//Class objc_lookUpClass ( const char *name );
//Class objc_getClass ( const char *name );
//Class objc_getRequiredClass ( const char *name );
// 返回指定类的元类
//Class objc_getMetaClass ( const char *name );

//typedef struct objc_ivar *Ivar;
//struct objc_ivar
//{
//    char *ivar_name;
//    char *ivar_type;
//    int ivar_offset;
//    int space;
//}

#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>

@interface MyClass : NSObject
{
    NSInteger _instance1;

    NSString *_instance2;
}
@property (nonatomic, assign) BOOL isFilled;

@property (nonatomic, strong) NSArray *myClassArray;

@property (nonatomic, copy) NSString *myClassString;

- (void)method1;

- (void)method2;

+ (void)classMethod1;

- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2;

@end

@interface RJLRunTimeController : UIViewController

@end
