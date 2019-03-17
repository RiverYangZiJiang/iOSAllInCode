//
//  MLBaseTableVC.h
//  iosTest2017
//
//  Created by 杨子江 on 3/9/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 只是在self.view增加了tableView，设置了tableView的背景色、delegate、dataSource
 */
@interface MLBaseTableVC : UIViewController
@property (strong, nonatomic) UITableView *tableView;
@end

NS_ASSUME_NONNULL_END
