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
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // This method dequeues an existing cell if one is available, or creates a new one based on the class or nib file you previously registered, and adds it to the table.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    NSLog(@"cell %p", cell);
    
    cell.textLabel.text = self.array[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
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

#pragma mark - getters & setters
- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

@end
