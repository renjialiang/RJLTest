//
//  RJLRunTimeController.m
//  RJLTestPro
//
//  Created by admin on 17/3/13.
//  Copyright © 2017年 renjialiang. All rights reserved.
//

#import "RJLRunTimeController.h"
#import "RunTimeObjectOne.h"

@implementation MyClass

+ (void)classMethod1
{
}

- (void)setFilled:(BOOL)flag
{
    self.isFilled = flag;
}

- (void)method1
{
    NSLog(@"call method method1");
}

- (void)method2
{
    NSLog(@"call method method2");
}

- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2
{
    NSLog(@"arg1 : %ld, arg2 : %@", arg1, arg2);
}

@end

static char myKey;

@interface RJLRunTimeController ()
{
    NSString *renjialiang;
}
@property (nonatomic, strong) NSArray *rjlArray;

@end

@implementation RJLRunTimeController

- (void)viewDidLoad
{
    //Runtime术语
        [self logMethodIvarProtocolProperty];

    //Runtime消息
    //    [self logMessageSend];

    //Runtime消息－Self
    //    [self logSelf];

    //Runtime消息 动态方法解析
    //    [self logDynamicMethod];

    //Runtime消息 重定向
    //    [self logMessageForward];

    //Runtime 关联对象
    //    [self logAssociatedObject];
}

- (void)viewWillAppear:(BOOL)animated
{
    //    id anObject = objc_getAssociatedObject(self, &myKey);
    //    if ([anObject isKindOfClass:[MyClass class]])
    //    {
    //        NSLog(@"%@",((MyClass *)anObject).myClassString);
    //        objc_removeAssociatedObjects(self);
    //        id other = objc_getAssociatedObject(self, &myKey);
    //        NSLog(@"%@",other);
    //    }
    //    NSLog(@"==========================================================");
}

- (void)viewDidAppear:(BOOL)animated
{
    //    NSLog(@"==========================================================");
    //    RunTimeObjectOne *one = [[RunTimeObjectOne alloc] init];
    //    [one performSelector:@selector(ReceiveMessage:) withObject:@"swizz"];
}

/**
 *  Runtime 术语
 */
- (void)logMethodIvarProtocolProperty
{
    @autoreleasepool
    {
        //获取方法选择器 等价于 @selector
        //是个映射到方法的C字符串
        SEL rjlSel = sel_registerName("logMethodIvarProtocolProperty");
        NSLog(@"%@", NSStringFromSelector(rjlSel));
        NSLog(@"==========================================================");

        //id类实例指针 objc_object
        //    struct objc_object {
        //        Class isa;
        //    }
        //Objective-C类由Class类型表示的，它实际上是一个指向objc_class结构体指针
        //typedef struct objc_class *Class;
        //struct objc_class {
        //    Class isa  OBJC_ISA_AVAILABILITY;
        //
        //#if !__OBJC2__
        //    Class super_class                       OBJC2_UNAVAILABLE;  // 父类
        //    const char *name                        OBJC2_UNAVAILABLE;  // 类名
        //    long version                            OBJC2_UNAVAILABLE;  // 类的版本信息，默认为0
        //    long info                               OBJC2_UNAVAILABLE;  // 类信息，供运行期使用的一些位标识
        //    long instance_size                      OBJC2_UNAVAILABLE;  // 该类的实例变量大小
        //    struct objc_ivar_list *ivars            OBJC2_UNAVAILABLE;  // 该类的成员变量链表
        //    struct objc_method_list **methodLists   OBJC2_UNAVAILABLE;  // 方法定义的链表
        //    struct objc_cache *cache                OBJC2_UNAVAILABLE;  // 方法缓存
        //    struct objc_protocol_list *protocols    OBJC2_UNAVAILABLE;  // 协议链表
        //#endif
        //
        //} OBJC2_UNAVAILABLE;

        MyClass *myClass = [[MyClass alloc] init];
        unsigned int outCount = 0;
        /*对象的元类 这是因为一个 ObjC 类本身同时也是一个对象，为了处理类和对象的关系，runtime 库创建了一种叫做元类 (Meta Class) 的东西，类对象所属类型就叫做元类，它用来表述类对象本身所具备的元数据。类方法就定义于此处，因为这些方法可以理解成类对象的实例方法。每个类仅有一个类对象，而每个类对象仅有一个与之相关的元类。当你发出一个类似[NSObject alloc]的消息时，你事实上是把这个消息发给了一个类对象 (Class Object) ，这个类对象必须是一个元类的实例，而这个元类同时也是一个根元类 (root meta class) 的实例。所有的元类最终都指向根元类为其超类。所有的元类的方法列表都有能够响应消息的类方法。所以当 [NSObject alloc] 这条消息发给类对象的时候，objc_msgSend()会去它的元类里面去查找能够响应消息的方法，如果找到了，然后对这个类对象执行方法调用。*/
        Class cls = myClass.class;
        NSLog(@"Class name : %s", class_getName(cls));
        NSLog(@"super class name: %s", class_getName(class_getSuperclass(cls)));
        NSLog(@"MyClass is %@ a meta-class", (class_isMetaClass(cls) ? @"" : @"not"));

        Class meta_class = objc_getMetaClass(class_getName(cls));
        NSLog(@"%s's meta-class is %s", class_getName(cls), class_getName(meta_class));
        NSLog(@"instance size: %zu", class_getInstanceSize(cls));
        NSLog(@"==========================================================");

        /*对象方法 Method : 方法类型    对应结构体:
        struct objc_method
        {
          SEL method_name;
          char *method_type;    存储方法的参数类型和返回值类型
          IMP method_imp;   函数指针
        }*/
        Method *methods = class_copyMethodList(cls, &outCount);
        for (int i = 0; i < outCount; i++)
        {
            Method method = methods[i];
            const char *methodType = method_getTypeEncoding(method);
            IMP methodIMP = method_getImplementation(method);
            SEL methodSEL = method_getName(method);
            NSLog(@"mType = %s --- mIMP = %p --- mSEL = %@", methodType, methodIMP, NSStringFromSelector(methodSEL));
        }
        free(methods);
        //具体对象方法
        Method method1 = class_getInstanceMethod(cls, @selector(method1));
        if (method1 != NULL)
        {
            NSLog(@"method %s", sel_getName(method_getName(method1)));
        }
        //获取类方法
        Method classMethod = class_getClassMethod(cls, @selector(classMethod1));
        if (classMethod != NULL)
        {
            NSLog(@"class method : %s", sel_getName(method_getName(classMethod)));
        }
        //判断对象是否有该方法的实现
        NSLog(@"MyClass is%@ responsd to selector: method3WithArg1:arg2:", class_respondsToSelector(cls, @selector(method3WithArg1:arg2:)) ? @"" : @" not");
        NSLog(@"==========================================================");

        /*Ivar实例变量的类型 对应结构体
          struct objc_ivar {
              char *ivar_name;
              char *ivar_type;
              int ivar_offset;  地址偏移字节
              int  space;
          }*/
        //只能在objc_allocateClassPair 与 objc_registerClassPair 之间添加变量
        //获取对象成员变量 class_copyIvarList不仅有实例变量也有属性 属性前会加一个下划线
        Ivar *ivars = class_copyIvarList(cls, &outCount);
        for (int i = 0; i < outCount; i++)
        {
            Ivar ivar = ivars[i];
            const char *iName = ivar_getName(ivar);
            const char *iType = ivar_getTypeEncoding(ivar);
            long iOffSet = ivar_getOffset(ivar);
            NSLog(@"instance name:%s -- type:%s --- offset:%ld", iName, iType, iOffSet);
        }
        free(ivars);
        //这里可以根据实例对象查找对应类中的名字
        Ivar string = class_getInstanceVariable(cls, "_instance1");
        if (string != NULL)
        {
            NSLog(@"instace variable %s", ivar_getName(string));
        }
        NSLog(@"==========================================================");

        /*struct objc_property_t
        {
            const char *name;
            const char *attributes;属性的特性
        }*/
        //获取类对象属性 class_copyPropertyList 获取协议属性protocol_copyPropertyList
        objc_property_t *properties = class_copyPropertyList(cls, &outCount);
        for (int i = 0; i < outCount; i++)
        {
            objc_property_t property = properties[i];
            fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
        }
        free(properties);

        objc_property_t array = class_getProperty(cls, "myClassArray");
        if (array != NULL)
        {
            NSLog(@"property %s", property_getName(array));
        }
        NSLog(@"==========================================================");

        /*objc_cache 性能优化  每当实例对象接收到一个消息时，不会直接在isa指向的方法列表中遍历查找响应的方法，而是优先在Cache中查找。
            struct objc_cache
            {
                unsigned int mask;
                unsigned int occupied;
                Method buckets[1];
            }*/

        /*struct protocol_t : objc_object {
            const char *mangledName;
            struct protocol_list_t *protocols;
            method_list_t *instanceMethods;
            method_list_t *classMethods;
            method_list_t *optionalInstanceMethods;
            method_list_t *optionalClassMethods;
            property_list_t *instanceProperties;
            uint32_t size;   // sizeof(protocol_t)
            uint32_t flags;
            // Fields below this point are not always present on disk.
            const char **extendedMethodTypes;
            const char *_demangledName;

            const char *demangledName();

            const char *nameForLogging() {
                return demangledName();
            }

            bool isFixedUp() const;
            void setFixedUp();

            bool hasExtendedMethodTypesField() const {
                return size >= (offsetof(protocol_t, extendedMethodTypes)
                                + sizeof(extendedMethodTypes));
            }
            bool hasExtendedMethodTypes() const {
                return hasExtendedMethodTypesField() && extendedMethodTypes;
            }
        };*/
        //获取对象支持协议
        Protocol *__unsafe_unretained *protocols = class_copyProtocolList(cls, &outCount);
        Protocol *protocol;
        for (int i = 0; i < outCount; i++)
        {
            protocol = protocols[i];
            NSLog(@"protocol name: %s", protocol_getName(protocol));
        }
        NSLog(@"MyClass is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol) ? @"" : @" not", protocol_getName(protocol));
        NSLog(@"==========================================================");
    }
}

/**
 *  消息
 */
- (void)logMessageSend
{
    NSLog(@"==========================================================");
    NSLog(@"objc_msgSend()");
    //    objc_msgSend() 汇编语言编写的

    //    伪代码
    //    id objc_msgSend(id self, SEL _cmd, ...) {
    //        Class class = object_getClass(self);
    //        IMP imp = class_getMethodImplementation(class, _cmd);
    //        return imp ? imp(self, _cmd,...):0;
    //    }

    //    objc_msgSend()
    //    objc_msgSend_stret()
    //    objc_msgSendSuper()
    //    objc_msgSendSuper_stret()
    //i386 平台针对浮点数的特殊处理
    //    objc_msgSend_fpret()
    NSLog(@"==========================================================");
}

/**
 *  方法中隐藏的函数 解释［self class］ ＝＝ ［super class］
 */
- (void)logSelf
{
    NSLog(@"==========================================================");

    //当o bjc_msgSend 找到方法对应的实现时，它将直接调用该方法实现，并将消息中所有的参数都传递给方法实现，同时，它还将传送两个隐藏的参数：接收消息的对象 self 方法选择器 _cmd
    //self 实际上，它是在方法实现中访问消息接收者对象的实例变量的途径

    //方法中的super关键字接收到消息时， struct objc_super {id receiver; Class class;}

    //这个结构体指明了消息应该被传递给特定超类的定义。但receiver仍然是self本身。

    Class mClass = [super class];
    NSLog(@"%@", NSStringFromClass(mClass));
    //这点需要注意，因为当我们想通过[super class]获取超类时，编译器只是将指向self的id指针和class的SEL传递给了objc_msgSendSuper函数，因为只有在NSObject类才能找到class方法，然后class方法调用object_getClass()，接着调用objc_msgSend(objc_super->receiver, @selector(class))，传入的第一个参数是指向self的id指针，与调用[self class]相同，所以我们得到的永远都是self的类型。
    Class suClass = object_getClass(self.superclass);
    //传入的是super的id和class的SEL
    NSLog(@"%@", NSStringFromClass(suClass));
    NSLog(@"==========================================================");
}

/**
 *  动态方法解析
 */
- (void)logDynamicMethod
{
    //    @dynamic propertyName; 动态提供存取方法的属性
    NSLog(@"==========================================================");
    MyClass *myClass = [[MyClass alloc] init];
    void (*setter)(id, SEL, BOOL);
    setter = (void (*)(id, SEL, BOOL))[myClass methodForSelector:@selector(setFilled:)];
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < 1000; i++)
    {
        //避开消息绑定而直接获取方法的地址并调用方法  持续大重复调用某方法的极端情况，避开消息发送而直接调用该方法会更高效
        //        setter(myClass, @selector(setFilled:), YES);
        [myClass setFilled:YES];
    }
    CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
    NSLog(@"excute time : %f ms", linkTime * 1000.0);

    //动态添加方法实现
    //resolveClassMethod添加类方法实现
    [RunTimeObjectOne learnRuntimeClass:@"rjl learnruntimeclass"];
    //resolveInstanceMethod添加实例方法实现和类方法实现
    RunTimeObjectOne *rtObOne = [[RunTimeObjectOne alloc] init];
    [rtObOne goToSchool:@"rjl gotoSchool"];
    NSLog(@"==========================================================");
}

/**
 *  消息转发 重定向
 */
- (void)logMessageForward
{
    NSLog(@"==========================================================");
    if (!@"resolveInstanceMethod")
    {
        NSLog(@"Message handled");
    }
    else
    {
        if (!@"forwardingTargetForSelector")
        {
            /**
             重定向
             */
            //替换类方法 需要重写 + (id)forwardingTargetForSelector:(SEL)aSelector 并返回类对象
            RunTimeObjectOne *rtObOne = [[RunTimeObjectOne alloc] init];
            [rtObOne mysteriousMethod:@"rjl mysteriousMethod"];
            NSLog(@"return replacement receiver");
        }
        else
        {
            //NSInvocation 在forwardInvocation 之前，Runtime系统会向对象发送methodSignatureForSelector:消息
            //并取到返回的方法签名用于生成NSInvocation对象,所以我们在重写forwardInvocation的同时也要重写
            //methodSignatureForSelector方法，否则会抛异常

            if (@"forwardInvocation")
            {
                //方法就像一个不能识别的消息的分发中心，将这些消息转发给不同接收对象。提供是将不同的对象链接到消息链的能力。
                //转发 和 继承相似 为Objc添加一些多继承的效果
                RunTimeObjectOne *rtObOne = [[RunTimeObjectOne alloc] init];
                [rtObOne simulativeMultiInheritance:@"adsf"];
                NSLog(@"Message handled");
            }
            else
            {
                NSLog(@"Message not handled");
            }
        }
    }

    NSLog(@"==========================================================");
}

/**
 *  动态向对象添加变量 ／获取／删除关联值
 */
- (void)logAssociatedObject
{
    NSLog(@"==========================================================");
    MyClass *myClass = [[MyClass alloc] init];
    myClass.myClassString = @"AssociatedObject";
    objc_setAssociatedObject(self, &myKey, myClass, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
