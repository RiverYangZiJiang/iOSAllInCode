//
//  YZJSnippets.m
//  AllInCode
//
//  Created by 杨子江 on 6/1/20.
//  Copyright © 2020 github.com/njhu. All rights reserved.
//

#import "YZJSnippets.h"

@interface YZJSnippets ()
/**
 1.https://www.cnblogs.com/LeeGof/p/8808257.html
 2.https://www.jianshu.com/p/a93fe8e91bd3
   迁移快捷代码：在~/Library/Developer/Xcode/UserData/CodeSnippets（如果没有CodeSnippets 可以先自定义一个代码段 然后文件自动生成）
 */
@end

@implementation YZJSnippets

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//2.4Weak修饰
//__weak typeof(self)weakSelf = self;
//2.5Strong修饰
//__strong __typeof(<#weakSelf#>)strongSelf = <#weakSelf#>;
//2.6UITableViewDataSource
//复制代码
//#pragma mark - UITableViewDataSource
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return <#Section Number#>;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return <#Rows Number#>;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#reuseIdentifier#> forIndexPath:<#indexPath#>];
//
//    <#statements#>
//
//    return cell;
//}
//复制代码
//2.7UITableViewDelegate
//#pragma mark - UITableViewDelegate
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    <#statements#>
//}
//2.8生成单例方法
//复制代码
//+ (instancetype)shared<#name#> {
//    static <#class#> *_shared<#name#> = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _shared<#name#> = <#initializer#>;
//    });
//
//    return _shared<#name#>;
//}
//复制代码
//2.9定义Pragma
//#pragma mark - <#Section#>
//2.10类扩展
//@interface <#Class Name#> ()
//
//<#Continuation#>
//
//@end
//2.11GCD主线程队列
//dispatch_async(dispatch_get_main_queue(), ^{
//    <#code#>
//});
//2.12GCD全局队列
//dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
//    <#code#>
//});
//2.13Window初始化
//复制代码
//self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//ViewController *vc = [[ViewController alloc] init];
//UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//self.window.rootViewController = nav;
//self.window.backgroundColor = [UIColor whiteColor];
//[self.window makeKeyAndVisible];
//复制代码
//2.14Get方法
//复制代码
//- (<#TYPE#> *)<#NAME#> {
//    if (nil == _<#NAME#>) {
//        _<#NAME#> = [[<#TYPE#> alloc] init];
//    }
//    return _<#NAME#>;
//}
//复制代码
//2.15Enum枚举
//typedef NS_ENUM(NSUInteger, <#Name#>) {
//    <#value0#> = 0,
//    <#value1#>
//};
//2.16OPTIONS枚举
//typedef NS_OPTIONS(NSInteger, <#name#>) {
//    <#value0#> = 0,
//    <#value1#> = 1
//};

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
