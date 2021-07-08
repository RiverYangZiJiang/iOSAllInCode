//
//  UITableViewControllerTest.m
//  iosTest2017
//
//  Created by 杨子江 on 4/12/18.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "UITableViewControllerTest.h"
#import "CustomTableViewCell.h"


@interface UITableViewControllerTest ()
@property (strong, nonatomic) NSMutableArray *array;
@end

@implementation UITableViewControllerTest

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.array addObjectsFromArray:@[@"a", @"b", @"c", @"d", @"a", @"b", @"c", @"d", @"a", @"b", @"c", @"d", @"a", @"b", @"c", @"d", @"a", @"b", @"c", @"d", @"a", @"b", @"c", @"d", @"a", @"b", @"c", @"d"]];
    
    self.tableView.estimatedRowHeight = 72;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    
    // 解决单元格左滑显示红色删除按钮，然后不动，然后按住单元格水平右滑，不隐藏删除按钮的问题
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    recognizer.numberOfTouchesRequired = 1;
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.tableView addGestureRecognizer:recognizer];
}

- (void)handleGesture:(UISwipeGestureRecognizer *)recognizer{
    NSLog(@"%@ %s", NSStringFromClass([UITableViewControllerTest class]), __func__);
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self.tableView setEditing:NO animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // This method dequeues an existing cell if one is available, or creates a new one based on the class or nib file you previously registered, and adds it to the table.
//    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    CustomTableViewCell *cell = [CustomTableViewCell cellWithTableView:tableView];
    NSLog(@"cell %p", cell);
    
    cell.titleLabel.text = self.array[indexPath.row];
//    cell.descLabel.text = self.array[indexPath.row];
    if (indexPath.row % 2) {
        cell.descLabel.text = @"self.array[indexPath.row]self.array[indexPath.row]self.array[indexPath.row]self.array[indexPath.row]self.array[indexPath.row]self.array[indexPath.row]self.array[indexPath.row]self.array[indexPath.row]";
    }else {
        cell.descLabel.text = @"self.array[indexPath.row]self.array[indexPath.row]self.array[indexPath.row]self.array";
    }
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// default is UITableViewCellEditingStyleDelete
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2) {
        // use insert enum has no effects
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.array removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        [self.array addObject:@"x"];
        NSIndexPath *ip = [NSIndexPath indexPathForRow:self.array.count inSection:indexPath.section];
        [tableView insertRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationRight];
    }   
}

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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
}

#pragma mark - 无限滚动，无缝加载
/*
 +使用UITableView 的 Prefetching API 来对数据进行预加载，从而来实现数据的无缝加载。
 提到列表分页，相信大家第一个想到的就是 MJRefresh，用于上拉下拉来刷新数据，当滚动数据到达底部的时候向服务器发送请求，然后在控件底部显示一个 Loading 动画，待请求数据返回后，Loading 动画消失，由 UITableView 或者 UICollectionView 控件继续加载这些数据并显示给用户
 在 iOS 10 上，Apple 对 UICollectionView 和 UITableView 引入了 Prefetching API，它提供了一种在需要显示数据之前预先准备数据的机制，旨在提高数据的滚动性能。在 UI 初始化的时候 App 会加载一些初始数据，然后当用户滚动快要到达显示内容的底部时加载更多的数据。多年来，像 Instagram, Twitter 和 Facebook 这样的社交媒体公司都使这种技术。如果查看他们的 App ，你就可以看到无限滚动的实际效果
 
 优雅的处理网络数据，你真的会吗？不如看看这篇.https://mp.weixin.qq.com/s/Jcl4Din60i6IcahvbvDraQ
*/


#pragma mark - getters & setters
- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

@end
