//
//  YZJNSInvocationVC.m
//  AllInCode
//
//  Created by hd on 2021/4/27.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJNSInvocationVC.h"

/// 参考文献：1.iOS之NSInvocation详解https://blog.csdn.net/wzc10101415/article/details/80305840
@interface YZJNSInvocationVC ()

@end

@implementation YZJNSInvocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self testNSInvocation];
    
    NSString *str = [self performSelector:@selector(run:) withArguments:@[@"message"]];
    NSLog(@"%s, str: %@", __func__, str);  // str: (null)
    
    NSString *str1 = [self performSelector:@selector(saySomething:b:c:) withArguments:@[@"a", @"b", @"c"]];
    NSLog(@"%s, str1: %@", __func__, str1);
    
    id returnVal = invokeBlock((id)^(NSString *a, NSString *b){
        return [NSString stringWithFormat:@"%@ and %@", a, b];
    }, @[@"a", @"b"]);
    NSLog(@"returnVal: %@", returnVal);
}

- (void)run:(NSString *)method {
    NSLog(@"%s, method: %@", __func__, method);
}

- (NSString *)saySomething:(NSString *)a b:(NSString *)b c:(NSString *)c {
    NSString *str = [NSString stringWithFormat:@"%s, a: %@, b: %@, c: %@,", __func__, a, b, c];
    NSLog(@"str: %@", str);
    return str;
}

- (void)testNSInvocation {
    // 此处必须为selector方法所在类，不能为NSObject，否则为nil
    NSMethodSignature *ms = [[self class] instanceMethodSignatureForSelector:@selector(run:)];
    if (!ms) {
        NSString *info = [NSString stringWithFormat:@"run:方法找不到"];
        [NSException raise:@"方法调用出现异常" format:info, nil];
    }
    
    // ms如果为nil，则会崩溃
    NSInvocation *iv = [NSInvocation invocationWithMethodSignature:ms];
    iv.target = self;   // 不设置，就不会调用到selector
    iv.selector = @selector(run:);
    
    NSString *way = @"byCar";
    [iv setArgument:&way atIndex:2];  // Indices 0 and 1 indicate the hidden arguments self and _cmd. Use indices 2 and greater for the arguments normally passed in a message.
    [iv invoke];
}

/// SEL
- (id)performSelector:(SEL)aSelector withArguments:(NSArray *)arguments {
    if (aSelector == nil) return nil;
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
    
    // invocation 有2个隐藏参数，所以 argument 从2开始
    if ([arguments isKindOfClass:[NSArray class]]) {
        // 避免传过来的参数少于或多于numberOfArguments里的参数个数
        NSInteger count = MIN(arguments.count, signature.numberOfArguments - 2);
        for (int i = 0; i < count; i++) {
            const char *type = [signature getArgumentTypeAtIndex:2 + i];
            // 需要做参数类型判断然后解析成对应类型，这里默认所有参数均为OC对象
            if (strcmp(type, "@") == 0) {
                id argument = arguments[i];
                [invocation setArgument:&argument atIndex:2 + i];
            }
        }
    }
    
    [invocation invoke];
    
    id returnVal;
    // 如果返回值为void，则signature.methodReturnType的值为"v"
    if (strcmp(signature.methodReturnType, "@") == 0) {
        [invocation getReturnValue:&returnVal];
    }
    // 需要做返回类型判断。比如返回值为常量需要包装成对象，这里仅以最简单的`@`为例
    return returnVal;
}

/// block
static id invokeBlock(id block ,NSArray *arguments) {
    if (block == nil) return nil;
    id target = [block  copy];
 
    const char *_Block_signature(void *);
    const char *signature = _Block_signature((__bridge void *)target);
 
    NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:signature];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.target = target;
 
    // invocation 有1个隐藏参数，所以 argument 从1开始
    if ([arguments isKindOfClass:[NSArray class]]) {
        NSInteger count = MIN(arguments.count, methodSignature.numberOfArguments - 1);
        for (int i = 0; i < count; i++) {
            const char *type = [methodSignature getArgumentTypeAtIndex:1 + i];
            NSString *typeStr = [NSString stringWithUTF8String:type];
            if ([typeStr containsString:@"\""]) {
                type = [typeStr substringToIndex:1].UTF8String;
            }
            
            // 需要做参数类型判断然后解析成对应类型，这里默认所有参数均为OC对象
            if (strcmp(type, "@") == 0) {
                id argument = arguments[i];
                [invocation setArgument:&argument atIndex:1 + i];
            }
        }
    }
 
    [invocation invoke];
 
    id returnVal;
    const char *type = methodSignature.methodReturnType;
    NSString *returnType = [NSString stringWithUTF8String:type];
    if ([returnType containsString:@"\""]) {
        type = [returnType substringToIndex:1].UTF8String;
    }
    if (strcmp(type, "@") == 0) {
        [invocation getReturnValue:&returnVal];
    }
    // 需要做返回类型判断。比如返回值为常量需要包装成对象，这里仅以最简单的`@`为例
    return returnVal;
}
 
@end
