//
//  CustomCollectionViewCell.h
//  iosTest2017
//
//  Created by yangzijiang on 2018/12/20.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const MLCustomCollectionViewCellId = @"MLCustomCollectionViewCellID";

NS_ASSUME_NONNULL_BEGIN

/**
 自定义UICollectionViewCell
 */
@interface CustomCollectionViewCell : UICollectionViewCell

@property (copy, nonatomic) NSString *title;


/**
 [1] 自定义UICollectionViewCell 以及碰到的问题 https://blog.csdn.net/qq_25527655/article/details/52514725
 [2] 自定义UICollectionviewCell简述 https://www.jianshu.com/p/b04bfea143e3
 */
@end

NS_ASSUME_NONNULL_END
