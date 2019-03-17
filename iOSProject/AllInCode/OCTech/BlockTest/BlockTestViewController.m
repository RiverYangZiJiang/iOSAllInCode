//
//  BlockTestViewController.m
//  OCTest
//
//  Created by 杨子江 on 11/18/18.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "BlockTestViewController.h"

// Use Type Definitions to Simplify Block Syntax 输入typedefBlock的snippet就OK
// If you need to define more than one block with the same signature, you might like to define your own type for that signature.
// define a type for a simple block with no arguments or return value, like this:
typedef void(^XYZSimpleBlock)(void);

@interface BlockTestViewController ()
// Objects Use Properties to Keep Track of Blocks
// Note: You should specify copy as the property attribute, because a block needs to be copied to keep track of its captured state outside of the original scope. This isn’t something you need to worry about when using Automatic Reference Counting, as it will happen automatically, but it’s best practice for the property attribute to show the resultant behavior. For more information, see Blocks Programming Topics .
@property (copy) void (^blockProperty)(void);

// It’s also possible to use type definitions for block property declarations, like this:
@property (copy) XYZSimpleBlock blockPropertyOfTypeDefinitions;

@property (copy) XYZSimpleBlock block;
@end

@implementation BlockTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self blockTakeArgumentsAndReturnValues];
    //    [self passBlocksAsArgumentsToMethodOrFunctions];
    //    [self useTypeDefinitionsToSimplifyBlockSyntax];
    
    // Objects Use Properties to Keep Track of Blocks
    //    self.blockProperty = ^{
    //        NSLog(@"%s", __func__);  // -[ViewController viewDidLoad]_block_invoke
    //    };
    //    self.blockProperty();
    
    [self configureBlock];
}

- (void)blockSyntax{
    // block variable declaration
    // void return type of block; ^ indication that this is a block; simpleBlock name of block variable; void argument type
    void (^simpleBlock)(void);  // declare声明
    // Compose a block and assign it to the variable
    simpleBlock = ^{  // define定义
        NSLog(@"This is a simple block");
    };
    // invoke the block
    simpleBlock();
}

- (void)blockTakeArgumentsAndReturnValues{
    double(^multiplyTowValues)(double, double) = ^double(double firstValue, double secondValue){
        return firstValue * secondValue;
    };
    // 调用block时是同步执行的，不会开启线程，和调用函数一样，能够得到返回结果。
    double result = multiplyTowValues(2, 4);
    NSLog(@"%s, The result is %f", __func__, result);
}

// In practice, it’s common to pass blocks to functions or methods for invocation elsewhere. You might use Grand Central Dispatch to invoke a block in the background, for example, or define a block to represent a task to be invoked repeatedly, such as when enumerating a collection. Blocks are also used for callbacks, defining the code to be executed when a task completes.As an example, your app might need to respond to a user action by creating an object that performs a complicated task, such as requesting information from a web service. Because the task might take a long time, you should display some kind of progress indicator while the task is occurring, then hide that indicator once the task is complete.
// It would be possible to accomplish this using delegation: You’d need to create a suitable delegate protocol, implement the required method, set your object as the delegate of the task, then wait for it to call a delegate method on your object once the task finished.
// Blocks make this much easier, however, because you can define the callback behavior at the time you initiate the task
- (void)passBlocksAsArgumentsToMethodOrFunctions{
    [self doSomethingWithBlock:^{  // here define the block
        NSLog(@"%s", __func__);  // -[ViewController passBlocksAsArgumentsToMethodOrFunctions]_block_invoke
    }];
    
    [self doSomethingWithTheBlockWithArgumentsOrValues:^(double firstValue, double secondValue) {  // here define the block
        NSLog(@"%s %f", __func__, firstValue + secondValue);  // -[ViewController passBlocksAsArgumentsToMethodOrFunctions]_block_invoke_2 3.000000
    }];
}
- (void)doSomethingWithBlock:(void(^)(void))callbackBlock{
    // ...other operation
    
    // invock the block after other operation
    callbackBlock();
}

// A Block Should Always Be the Last Argument to a Method. It’s best practice to use only one block argument to a method. If the method also needs other non-block arguments, the block should come last
// 定义带block的method or function的时候，需要确定给block什么参数值，以及什么时候回调block；至于block的定义，即调用该block之后要做什么以及怎么处理这些参数值，就由定义block的地方决定，就由调用本method or function的地方决定
- (void)doSomethingWithTheBlockWithArgumentsOrValues:(void(^)(double firstValue, double secondValue))callbackBlock{
    // ...other operation
    
    // invock the block after other operation
    callbackBlock(1, 2);  // here assign value for block arguments
}

// Custom type definitions are particularly useful when dealing with blocks that return blocks or take other blocks as arguments.
- (void)useTypeDefinitionsToSimplifyBlockSyntax{
    XYZSimpleBlock anotherBlock = ^{
        NSLog(@"%s", __func__);  // -[ViewController useTypeDefinitionsToSimplifyBlockSyntax]_block_invoke
    };
    anotherBlock();
}


- (void)beginFetchWithCallbackBlock:(XYZSimpleBlock)callbackBlock {
    callbackBlock();
}

// Avoid Strong Reference Cycles when Capturing self. To avoid this problem, it’s best practice to capture a weak reference to self, like this:
- (void)configureBlock {
    BlockTestViewController * __weak weakSelf = self;
    self.block = ^{
        [weakSelf doSomething];   // capture the weak reference
    };
    
    self.block();
}

- (void)doSomething{
    NSLog(@"%s", __func__);  // -[ViewController doSomething]
}














@end
